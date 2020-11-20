package muladd

import chisel3._

object MulAddMain extends App {
    iotesters.Driver.execute(args, () => new MulAdd(SInt(32.W), 16)) {
        c => new MulAddUnitTester (SInt(32.W), c)
    }
}

object MulAddRepl extends App {
    iotesters.Driver.executeFirrtlRepl (args, () => new MulAdd(SInt(32.W), 16))
}