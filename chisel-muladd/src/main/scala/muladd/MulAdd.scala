package muladd

import chisel3._

class MulAdd[T <: Data](gen: T, width: Int) extends Module {
    val io = IO (new Bundle {
        val a = Input(Vec(width, SInt(32.W)))
        val b = Input(Vec(width, SInt(32.W)))
        val output = Output (SInt(32.W))
    })   

    var i = 0
    var tmp = 0.S (32.W)
    while (i < width) {
        tmp += io.a(i) * io.b(i)
        i += 1
    }
    io.output := tmp
}