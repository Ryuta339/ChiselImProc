// from https://github.com/maltanar/axi-in-chisel
//
// Modified to fit chisel3
// by Shata

package axi4

import chisel3._
import chisel3.util._

// Define simple extensions of the Chisel Decoupled interfaces,
// with signal renaming to support auto inference of AXI stream interfaces in Vivado

// AXIStreamIF has five io ports:
// - user
// - last
// - ready / ReadyValidIO.ready
// - valid / ReadyValidIO.valid
// - bits  / ReadyValidIO.bits
//
// In order to use Flipped object,
// this class extends ReadyValidIO instead of DecoupledIO
class AXIStreamIF[T <: Data](gen: T) extends ReadyValidIO[T](gen) {
    val user = Output (Bool())
    val last = Output (Bool())

    override def cloneType: this.type = new AXIStreamIF(gen).asInstanceOf[this.type]
}

object AXIStreamMasterIF {
    def apply [T <: Data] (gen: T): AXIStreamIF[T] = new AXIStreamIF[T] (gen)
}

object AXIStreamSlaveIF {
    def apply [T <: Data] (gen: T): AXIStreamIF[T] = Flipped (new AXIStreamIF[T] (gen))
}

// Output the input data in next clock
class AXIStreamTestModule (data_width: Int) extends Module {
    val io = IO (new Bundle {
        val src = AXIStreamSlaveIF (UInt(data_width.W))
        val dst = AXIStreamMasterIF (UInt(data_width.W))
    })

    io.src.ready := true.B
    io.dst.valid := true.B
    io.dst.bits := 0.U(data_width.W)
    io.dst.user := false.B
    io.dst.last := false.B

    val reg = RegInit (0.U(data_width.W))

    when (io.src.valid) {
        reg := io.src.bits
    }
    when (io.src.ready) {
        io.dst.bits := reg
    }
}