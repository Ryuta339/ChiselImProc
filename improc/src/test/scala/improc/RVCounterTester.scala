package improc

import java.io.File
import chisel3._
import chisel3.util._
import chisel3.iotesters
import chisel3.iotesters.{ChiselFlatSpec, Driver, PeekPokeTester}

class RVCounterUnitTester (c: RVCounter) extends PeekPokeTester (c) {
    private val counter = c

    reset (10)


    for (i <- 0 until 10) {
        poke (counter.io.user, if (i==0) 1 else 0)
        poke (counter.io.valid, true.B)
        poke (counter.io.ready, true.B)
        expect (counter.io.xoutput, i)
        step (1)
    }
}

class RVCounterTester extends ChiselFlatSpec {
    private val data_width = 12

    private val backendNames = if (firrtl.FileUtils. isCommandAvailable (Seq ("varilator", "--version"))) {
        Array ("firrtl", "verilator")
    } else {
        Array ("firrtl")
    }
    for (backendName <- backendNames) {
        "RVCounter" should s"do image processing" in {
            Driver (() => new RVCounter (data_width), backendName) {
                c => new RVCounterUnitTester (c)
            } should be (true)
        }
    }

    "Basic test using Drive.execute" should "be used as an alternative way to run specification" in {
        iotesters.Driver.execute (Array(), () => new RVCounter (data_width)) {
            c => new RVCounterUnitTester (c)
        } should be (true)
    }

    if (backendNames.contains ("verilator")) {
        "using --backend-name verilator" should "be an alternative way to run using verilator" in {
            iotesters.Driver.execute (Array("--backend-name", "verilator"), () => new RVCounter(data_width)) {
                c => new RVCounterUnitTester (c)
            } should be (true)
        }
    }

    "running with --is-verbose" should "show more about what's going on in your tester" in {
        iotesters.Driver.execute (Array("--is-verbose"), () => new RVCounter (data_width)) {
            c => new RVCounterUnitTester (c)
        } should be (true)
    }

    /**
     * By default validator backend produces vcd files, and firrtl and treadle backends do not.
     * Following examples show you how to turn on vcd for firrtl and treadle and how to turn it off for verilator
     **/
    "runnung with --generate-vcd-output on" should "create a vcd file from your test" in {
        iotesters.Driver.execute (
            Array("--generate-vcd-output", "on", "--target-dir", "test_run_dir/make_a_vcd", "--top-name", "make_a_vcd"),
            () => new RVCounter (data_width),
        ) {
            c => new RVCounterUnitTester(c)
        } should be (true)

        new File ("test_run_dir/make_a_vcd/AXIS.vcd").exists should be (true)
    }
}