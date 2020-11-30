package axi4

import chisel3._
import chisel3.util._

class SqrtUInt (val data_width: Int) extends Module {
    val io = IO (new Bundle {
        val enq = EnqIO(UInt(data_width.W))
        val deq = DeqIO(UInt((data_width/2).W))
    })

    val reg = Reg(UInt(data_width.W))
    val answerReg = Reg(UInt((data_width/2).W))
    val empty :: calculating :: calculated :: Nil = Enum(3)
    val stateReg = RegInit(empty)

    when (stateReg === empty) {
        when (io.deq.valid) {
            reg := io.deq.bits
            answerReg := 0.U
            stateReg := calculating
        }
    }.elsewhen (stateReg === calculating) {
        when (answerReg*answerReg <= reg) {
            answerReg := answerReg + 1.U
        }.otherwise {
            answerReg := answerReg - 1.U
            stateReg := calculated
        }
    }.elsewhen (stateReg === calculated) {
        when (io.enq.ready) {
            stateReg := empty
        }
    }
  
    io.enq.valid := (stateReg === calculated)
    io.deq.ready := (stateReg === empty)
    io.enq.bits :=  answerReg
}
