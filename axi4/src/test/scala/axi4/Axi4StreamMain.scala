package axi4

import chisel3._
import chisel3.iotesters.{Driver, PeekPokeTester}

object ImProcMain extends App {
    val MAX_WIDTH = 1280
    val MAX_HEIGHT = 720
    iotesters.Driver.execute (args, () => new ChiselImProc (24, 1, MAX_WIDTH, MAX_HEIGHT)) {
        c => new ImProcUnitTester2 (c)
    }
}

object ImProcRepl extends App {
    val MAX_WIDTH = 1280
    val MAX_HEIGHT = 780
    iotesters.Driver.executeFirrtlRepl (args, () => new ChiselImProc(24, 1, MAX_WIDTH, MAX_HEIGHT))
}


object ImProcTestBench extends App {
    iotesters.Driver.execute (args, () => new ChiselImProc (24, 1, 4, 4)) {
        c => new ImProcUnitTester2 (c)
    }
}

object ImProcReplTestBench extends App {
    iotesters.Driver.executeFirrtlRepl (args, () => new ChiselImProc(24, 1, 4, 4))
}

