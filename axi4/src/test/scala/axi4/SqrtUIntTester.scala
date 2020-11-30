package axi4

import chisel3._
import chisel3.util._
import chisel3.iotesters
import chisel3.iotesters.{ChiselFlatSpec, Driver, PeekPokeTester}
import scala.math.sqrt

class SqrtUIntUnitTester (c: SqrtUInt) extends PeekPokeTester(c) {
    private val s = c

    reset (10)

    for (i <- 0 to 0xFF) {
        // waiting ready
        while (peek (s.io.deq.ready) != BigInt(1)) {
            step(1)
        }
        poke (s.io.deq.valid, 1)
        poke (s.io.deq.bits, i)

        // waiting valid
        while (peek (s.io.enq.valid) != BigInt(1)) {
            step (1)
        }
        poke (s.io.enq.ready, 1)
        expect (s.io.enq.bits, sqrt(i.toDouble).toInt)
        step(1)
    }

    println("hello")
}

class SqrtUIntTester extends ChiselFlatSpec {
    private val dataWidth = 32

    private val backendNames = if (firrtl.FileUtils.isCommandAvailable (Seq ("verilator", "--version"))) {
        Array("firrtl", "verilator")
    } else {
        Array ("firrtl")
    }
    for (backendName <- backendNames) {
        "SqrtUInt" should s"calculate square root" in {
            Driver (() => new SqrtUInt(dataWidth), backendName) {
                c => new SqrtUIntUnitTester(c)
            }should be (true)
        }
    }

    "Basic test using Driver.execute" should "be used as an alternative way to run specification" in {
        iotesters.Driver.execute (Array(), () => new SqrtUInt(dataWidth)) {
            c => new SqrtUIntUnitTester(c)
        } should be (true)
    }

    /*
    if (backendNames.contains ("verilator")) {
        "using --backend-name verilator" should "be an alternative way to run using verilator" in {
            iotesters.Driver.execute (Array("--backend-name", "verilator"), () => new SqrtUInt(dataWidth)) {
                c => new SqrtUIntUnitTester(c)
            }
        }
    }

    "running with --is-verbose" should "show more about what's going on in your tester" in {
        iotesters.Driver.execute (Array("--is-verbose"), () => new SqrtUInt(dataWidth)) {
            c => new SqrtUIntUnitTester(c)
        }should be (true)
    }
    */
}
