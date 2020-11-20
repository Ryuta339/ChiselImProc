package axi4

import java.io.File
import javax.imageio.ImageIO
import chisel3._
import chisel3.util._
import chisel3.iotesters
import chisel3.iotesters.{ChiselFlatSpec, Driver, PeekPokeTester}
import java.awt.image.BufferedImage
import java.io.InputStream
import scala.collection.mutable.ArrayBuffer

class ImProcUnitTester (c: ChiselImProc) extends PeekPokeTester (c) {
    private val proc = c
    private val MAX_WIDTH = c.MAX_WIDTH
    private val MAX_HEIGHT = c.MAX_HEIGHT
    private val MAX_TRIAL = 1

    def ReadImage (file: File): Seq[Int] = {
        try {
            val image: BufferedImage = ImageIO.read (file)
           for {
               iy <- (0 until MAX_HEIGHT)
               ix <- (0 until MAX_WIDTH)
               result = image.getRGB (ix, iy)
           } yield result
        } catch {
            case e: Exception => 
            e.printStackTrace
            Seq(0)
        }
    }

    def WriteImage (data: Seq[Int], file: File): Unit = {
        try {
            val write: BufferedImage = new BufferedImage (MAX_WIDTH, MAX_HEIGHT, BufferedImage.TYPE_INT_RGB)
            for (iy <- (0 until MAX_HEIGHT); ix <- (0 until MAX_WIDTH) ) {
                write.setRGB (ix, iy, data(ix + iy*MAX_WIDTH))
            }
            ImageIO.write (write, "png", file)
        } catch {
            case e: Exception => e.printStackTrace()
        }
    }

    reset (10)

    val imageIn = ReadImage(new File("lenna.png"))
    var imageOut = ArrayBuffer.fill(MAX_WIDTH*MAX_HEIGHT) {0}

    var inidx = 0
    var outidx = 0

    while (outidx < MAX_WIDTH*MAX_HEIGHT) {
        // Write data
        poke (proc.io.enq.valid, if (inidx<MAX_WIDTH*MAX_HEIGHT) 1 else 0)
        poke (proc.io.enq.bits, if (inidx<MAX_WIDTH*MAX_HEIGHT) imageIn(inidx) else 0)
        poke (proc.io.enq.user, if (inidx==0) 1 else 0)
        poke (proc.io.enq.last, if (inidx%MAX_WIDTH==MAX_WIDTH-1) 1 else 0)
        if (peek (proc.io.enq.ready) == BigInt(1)) {
            inidx = inidx + 1
        }

        // Read data
        poke (proc.io.deq.ready, 1)
        if (peek (proc.io.deq.valid) == BigInt(1)) {
            imageOut (outidx) = peek (proc.io.deq.bits).intValue

            expect (proc.io.deq.user, if (outidx==0) 1 else 0)
            expect (proc.io.deq.last, if (outidx%MAX_WIDTH==MAX_WIDTH-1) 1 else 0)

            outidx = outidx + 1
        }

        step (1)
    }

    WriteImage (imageOut.toSeq, new File("out.png"))

}

class ImProcUnitTester2 (c: ChiselImProc) extends PeekPokeTester (c) {
}

class ImProcTester extends ChiselFlatSpec {
    private val data_width = 24
    private val depth = 7
    private val width = 512
    private val height = 512

    private val backendNames = if (firrtl.FileUtils. isCommandAvailable (Seq ("varilator", "--version"))) {
        Array ("firrtl", "verilator")
    } else {
        Array ("firrtl")
    }
    for (backendName <- backendNames) {
        "ChiselImProc" should s"do image processing" in {
            Driver (() => new ChiselImProc (data_width, depth, width, height), backendName) {
                c => new ImProcUnitTester (c)
            } should be (true)
        }
    }

    "Basic test using Drive.execute" should "be used as an alternative way to run specification" in {
        iotesters.Driver.execute (Array(), () => new ChiselImProc (data_width, depth, width, height)) {
            c => new ImProcUnitTester (c)
        } should be (true)
    }

    if (backendNames.contains ("verilator")) {
        "using --backend-name verilator" should "be an alternative way to run using verilator" in {
            iotesters.Driver.execute (Array("--backend-name", "verilator"), () => new ChiselImProc(data_width, depth, width, height)) {
                c => new ImProcUnitTester (c)
            } should be (true)
        }
    }

    "running with --is-verbose" should "show more about what's going on in your tester" in {
        iotesters.Driver.execute (Array("--is-verbose"), () => new ChiselImProc (data_width, depth, width, height)) {
            c => new ImProcUnitTester (c)
        } should be (true)
    }

    /**
     * By default validator backend produces vcd files, and firrtl and treadle backends do not.
     * Following examples show you how to turn on vcd for firrtl and treadle and how to turn it off for verilator
     **/
    "runnung with --generate-vcd-output on" should "create a vcd file from your test" in {
        iotesters.Driver.execute (
            Array("--generate-vcd-output", "on", "--target-dir", "test_run_dir/make_a_vcd", "--top-name", "make_a_vcd"),
            () => new ChiselImProc (data_width, depth, width, height),
        ) {
            c => new ImProcUnitTester(c)
        } should be (true)

        new File ("test_run_dir/make_a_vcd/AXIS.vcd").exists should be (true)
    }
}

