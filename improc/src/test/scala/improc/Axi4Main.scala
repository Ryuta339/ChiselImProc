package improc

import chisel3._
import chisel3.iotesters.{Driver, PeekPokeTester}

object AXI4Main extends App {
    iotesters.Driver.execute (args, () => new AXI4LiteSlave (4, 32)) {
        c => new AXI4LiteSlaveUnitTester (c)
    }
}

object AXI4Repl extends App {
    iotesters.Driver.executeFirrtlRepl (args, () => new AXI4LiteSlave(4,32))
}

object RVCounterMain extends App {
    iotesters.Driver.execute (args, () => new RVCounter (16)) {
        c => new RVCounterUnitTester (c)
    }
}

object RVCounterRepl extends App {
    iotesters.Driver.executeFirrtlRepl (args, () => new RVCounter (16))
}
