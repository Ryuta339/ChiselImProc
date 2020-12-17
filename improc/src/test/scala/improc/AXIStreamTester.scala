package improc

import chisel3._
import chisel3.util._
import chisel3.iotesters
import chisel3.iotesters.{ChiselFlatSpec, Driver, PeekPokeTester}

class AXIStreamUnitTester (c: AXIStreamTestModule) extends PeekPokeTester (c) {
    private val aximod = c

    reset (10)
    
    for (i <- 0 until 8) {
        poke (aximod.io.src.valid, 1)
        poke (aximod.io.src.bits, i)
        if (i > 0) {
            expect (aximod.io.dst.bits, i-1)
        }
        step (1)
    }
}

class AXIStreamTester extends ChiselFlatSpec {
    private val data_width = 32

    private val backendNames = if (firrtl.FileUtils.isCommandAvailable(Seq("verilator", "--version"))) {
        Array("firrtl", "verilator")
    }
    else {
        Array("firrtl")
    }
    for ( backendName <- backendNames) {
        "AXIStreamTestModule" should s"be fifo" in {
            Driver(() => new AXIStreamTestModule (data_width), backendName) {
                c => new AXIStreamUnitTester (c)
            } should be (true)
        }
    }

    "Basic test using Driver.execute" should  "be used as an alternative way to run specification" in {
        iotesters.Driver.execute (Array(), () => new AXIStreamTestModule(data_width)) {
            c => new AXIStreamUnitTester (c)
        } should be (true)
    }    
}