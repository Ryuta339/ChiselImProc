package improc

import java.io.File
import javax.imageio.ImageIO
import chisel3._
import chisel3.util._
import chisel3.iotesters
import chisel3.iotesters.{ChiselFlatSpec, Driver, PeekPokeTester}
import java.awt.image.BufferedImage
import java.io.InputStream
import scala.collection.mutable.ArrayBuffer
import scala.util.Random

class ImProcUnitTester (c: ChiselImProc) extends PeekPokeTester (c) {
    private val proc = c
    private val MAX_WIDTH = c.MAX_WIDTH
    private val MAX_HEIGHT = c.MAX_HEIGHT
    private val MAX_TRIAL = 1
    Random.setSeed(1)
    val rand = new Random

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
        val vflag = rand.nextInt()%5 != 0
        poke (proc.io.enq.valid, if (inidx<MAX_WIDTH*MAX_HEIGHT && vflag) 1 else 0)
        poke (proc.io.enq.bits, if (inidx<MAX_WIDTH*MAX_HEIGHT && vflag) imageIn(inidx) else rand.nextInt(0x1000000))
        poke (proc.io.enq.user, if (inidx==0 && vflag) 1 else 0)
        poke (proc.io.enq.last, if (inidx%MAX_WIDTH==MAX_WIDTH-1 && vflag) 1 else 0)
        if (peek (proc.io.enq.ready) == BigInt(1) && vflag) {
            inidx = inidx + 1
        }

        // Read data
        val rflag = rand.nextInt()%5 != 0
        poke (proc.io.deq.ready, if (rflag) 1 else 0)
        if (peek (proc.io.deq.valid) == BigInt(1) && rflag) {
            imageOut (outidx) = peek (proc.io.deq.bits).intValue

            expect (proc.io.deq.user, if (outidx==0) 1 else 0)
            expect (proc.io.deq.last, if (outidx%MAX_WIDTH==MAX_WIDTH-1) 1 else 0)

            /*
            if (outidx%MAX_WIDTH == MAX_WIDTH/2 && outidx/MAX_WIDTH % 10 == 0) {
                println (peek (proc.io.dport2).intValue.toString)
                println (peek (proc.io.dport).intValue.toString)
            }
            */

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
    private val width = 256
    private val height = 256

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


class SqrtWrapperUnitTester (c: SqrtWrapper) extends PeekPokeTester(c) {
    private val sw = c
    reset(10)
    poke (sw.io.enq.valid, 1)
    poke (sw.io.enq.bits.data, 100)
    poke (sw.io.deq.ready, 1)
    poke (sw.io.enq.user, 1)
    poke (sw.io.enq.last, 0)
    poke (sw.io.enq.bits.horizontal, 1)
    poke (sw.io.enq.bits.vertical, 1)
    step (1)

    for (i <- 0 until 100) {
        poke (sw.io.enq.valid, 1)
        poke (sw.io.deq.ready, 1)
        poke (sw.io.enq.user, 0)
        poke (sw.io.enq.bits.data, 0)
        poke (sw.io.enq.last, if (i%10==9) 1 else 0)
        poke (sw.io.enq.bits.horizontal, 1)
        poke (sw.io.enq.bits.vertical, 1)
        println(peek (sw.io.deq.bits.data).intValue.toString)
        step (1)
    }
}

class SqrtWrapperTester extends ChiselFlatSpec {
    private val data_width = 8
    private val width = 10
    private val height = 10
    private val backendNames = if (firrtl.FileUtils.isCommandAvailable (Seq ("verilator", "--version"))) {
        Array ("firrtl", "verilator")
    } else {
        Array  ("firrtl")
    }
    for (backendName <- backendNames) {
        "SqrtWrapper" should s"calculate square root" in {
            Driver (() => new SqrtWrapper(data_width, width, height), backendName) {
                c => new SqrtWrapperUnitTester(c)
            } should be (true)
        }
    }

    "Basic test using Driver.execute" should "be used as an altetrnative way to run specification" in {
        iotesters.Driver.execute (Array(), ()=> new SqrtWrapper(data_width, width, height)) {
            c => new SqrtWrapperUnitTester (c)
        } should be (true)
    }
}