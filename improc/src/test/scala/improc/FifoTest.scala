package improc

import java.io.File
import chisel3._
import chisel3.util._
import chisel3.iotesters
import chisel3.iotesters.{ChiselFlatSpec, Driver, PeekPokeTester}

class BubbleFifoUnitTester (c: BubbleFifo[UInt]) extends PeekPokeTester (c) {
    private val fifo = c
    private val depth = 8

    reset (10)

    
    for (cnt <- 0 until depth/2) {
        poke (fifo.io.enq.valid, 1)
        poke (fifo.io.enq.bits, cnt)
        step (2) // Maximum bandwidth of this FIFO is two clock cycle per word
    }
    for (cnt <- 0 until depth/2) {
        poke (fifo.io.deq.ready, 1)
        expect (fifo.io.deq.bits, cnt)
        step (2) // Maximum bandwidth of this FIFO is two clock cycle per word
    }
}

class DoubleBufferFifoUnitTester (c: DoubleBufferFifo[UInt]) extends PeekPokeTester (c) {
    private val fifo = c
    private val depth = 8

    reset (10)

    for (cnt <- 0 until depth) {
        poke (fifo.io.enq.valid, 1)
        poke (fifo.io.enq.bits, cnt)
        step (1)
    }
    for (cnt <- 0 until depth) {
        poke (fifo.io.deq.ready, 1)
        expect (fifo.io.deq.bits, cnt)
        step (1)
    }
}

class DoubleBufferFifoAXISUnitTester (c: DoubleBufferFifoAXIS[UInt]) extends PeekPokeTester (c) {
    private val fifo = c
    private val depth = 8

    reset (10)

    for (cnt <- 0 until depth) {
        poke (fifo.io.enq.valid, 1)
        poke (fifo.io.enq.bits, cnt)
        step (1)
    }
    for (cnt <- 0 until depth) {
        poke (fifo.io.deq.ready, 1)
        expect (fifo.io.deq.bits, cnt)
        step (1)
    }
}

class BubbleFifoTester extends ChiselFlatSpec {
    private val data_size = 32
    private val depth = 8

    private val backendNames = if (firrtl.FileUtils.isCommandAvailable(Seq("verilator", "--version"))) {
        Array("firrtl", "verilator")
    }
    else {
        Array("firrtl")
    }
    for ( backendName <- backendNames) {
        "BubbleFifo" should s"be fifo" in {
            Driver(() => new BubbleFifo (UInt (data_size.W), depth), backendName) {
                c => new BubbleFifoUnitTester (c)
            } should be (true)
        }
    }

    "Basic test using Driver.execute" should  "be used as an alternative way to run specification" in {
        iotesters.Driver.execute (Array(), () => new BubbleFifo(UInt (data_size.W), depth)) {
            c => new BubbleFifoUnitTester (c)
        } should be (true)
    }


}

class DoubleBufferFifoTester extends ChiselFlatSpec {
    private val data_size = 32
    private val depth = 8

    private val backendNames = if (firrtl.FileUtils.isCommandAvailable(Seq("verilator", "--version"))) {
        Array("firrtl", "verilator")
    }
    else {
        Array("firrtl")
    }
    for ( backendName <- backendNames) {
        "BubbleFifo" should s"be fifo" in {
            Driver(() => new DoubleBufferFifo (UInt (data_size.W), depth), backendName) {
                c => new DoubleBufferFifoUnitTester (c)
            } should be (true)
        }
    }

    "Basic test using Driver.execute" should  "be used as an alternative way to run specification" in {
        iotesters.Driver.execute (Array(), () => new DoubleBufferFifo(UInt (data_size.W), depth)) {
            c => new DoubleBufferFifoUnitTester (c)
        } should be (true)
    }
}

class DoubleBufferFifoAXISTester extends ChiselFlatSpec {
    private val data_size = 32
    private val depth = 8

    private val backendNames = if (firrtl.FileUtils.isCommandAvailable(Seq("verilator", "--version"))) {
        Array("firrtl", "verilator")
    }
    else {
        Array("firrtl")
    }
    for ( backendName <- backendNames) {
        "BubbleFifo" should s"be fifo" in {
            Driver(() => new DoubleBufferFifoAXIS (UInt (data_size.W), depth), backendName) {
                c => new DoubleBufferFifoAXISUnitTester (c)
            } should be (true)
        }
    }

    "Basic test using Driver.execute" should  "be used as an alternative way to run specification" in {
        iotesters.Driver.execute (Array(), () => new DoubleBufferFifoAXIS(UInt (data_size.W), depth)) {
            c => new DoubleBufferFifoAXISUnitTester (c)
        } should be (true)
    }

    if (backendNames.contains ("verilator")) {
        "using --backend-name verilator" should "be an alternative way to run using verilator" in {
            iotesters.Driver.execute (Array("--backend-name", "verilator"), () => new DoubleBufferFifoAXIS(UInt (data_size.W), depth)) {
                c => new DoubleBufferFifoAXISUnitTester (c)
            } should be (true)
        }
    }

    "running with --is-verbose" should "show more about what's going on in your tester" in {
        iotesters.Driver.execute (Array("--is-verbose"), () => new DoubleBufferFifoAXIS(UInt (data_size.W), depth)) {
            c => new DoubleBufferFifoAXISUnitTester (c)
        } should be (true)
    }

    /**
     * By default validator backend produces vcd files, and firrtl and treadle backends do not.
     * Following examples show you how to turn on vcd for firrtl and treadle and how to turn it off for verilator
     **/
    "runnung with --generate-vcd-output on" should "create a vcd file from your test" in {
        iotesters.Driver.execute (
            Array("--generate-vcd-output", "on", "--target-dir", "test_run_dir/make_a_vcd", "--top-name", "make_a_vcd"),
            () => new DoubleBufferFifoAXIS (UInt (data_size.W), depth),
        ) {
            c => new DoubleBufferFifoAXISUnitTester (c)
        } should be (true)

        new File ("test_run_dir/make_a_vcd/AXIS.vcd").exists should be (true)
    }

}