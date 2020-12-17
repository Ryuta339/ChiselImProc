package improc

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

class SqrtExtractionUIntUnitTester (c: SqrtExtractionUInt) extends PeekPokeTester(c) {
    private val s = c
    reset(10)

    for (i <- 0 to 0xFF) {
        poke (s.io.z, i)
        expect (s.io.q, sqrt(i.toDouble).toInt)
    }
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

}

class SqrtExtractionUIntTester extends ChiselFlatSpec {
    private val dataWidth = 8

    private val backendNames = if (firrtl.FileUtils.isCommandAvailable (Seq ("verilator", "--version"))) {
        Array("firrtl", "verilator")
    } else {
        Array ("firrtl")
    }
    for (backendName <- backendNames) {
        "SqrtUInt" should s"calculate square root" in {
            Driver (() => new SqrtExtractionUInt(dataWidth), backendName) {
                c => new SqrtExtractionUIntUnitTester(c)
            }should be (true)
        }
    }

    "Basic test using Driver.execute" should "be used as an alternative way to run specification" in {
        iotesters.Driver.execute (Array(), () => new SqrtExtractionUInt(dataWidth)) {
            c => new SqrtExtractionUIntUnitTester(c)
        } should be (true)
    }

}


class VecExampleUnitTester (c: VecExample) extends PeekPokeTester(c) {
    val ve = c
    reset(10)
    expect (ve.io.out, 8)
}

class VecExampleTester extends ChiselFlatSpec {
    private val backendNames = if (firrtl.FileUtils.isCommandAvailable (Seq ("verilator", "--version"))) {
        Array ("firrtl", "verilator")
    } else {
        Array ("firrtl")
    }
    for (backendName <- backendNames) {
        "VecExample" should s"be an example" in {
            Driver (() => new VecExample, backendName) {
                c => new VecExampleUnitTester(c)
            }
        }
    }

    "Basic test using Driver.execute" should "be used as an alternative way to run specification" in {
        iotesters.Driver.execute (Array(), () => new VecExample) {
            c => new VecExampleUnitTester(c)
        } should be (true)
    }

}