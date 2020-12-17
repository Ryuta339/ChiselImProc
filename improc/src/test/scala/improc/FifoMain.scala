package improc

import chisel3._
import chisel3.iotesters.{Driver, PeekPokeTester}

object FifoMain extends App {
    iotesters.Driver.execute (args, () => new DoubleBufferFifoAXIS (UInt(32.W), 8)) {
        c => new DoubleBufferFifoAXISUnitTester (c)
    }
}

object FifoRepl extends App {
    iotesters.Driver.executeFirrtlRepl (args, () => new DoubleBufferFifoAXIS (UInt(32.W), 8))
}