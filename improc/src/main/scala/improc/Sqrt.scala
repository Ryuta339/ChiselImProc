package improc

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

// There exists some delay
class SqrtExtractionUInt (val data_width: Int = 8) extends Module {
    val io = IO (new Bundle {
        val z = Input(UInt((2*data_width).W))
        val q = Output(UInt(data_width.W))
    })

    val zj = Wire (Vec (data_width, UInt((2*data_width+1).W)))
    val rj = Wire (Vec (data_width, UInt((2*data_width+1).W)))

    val qSub = Reg (Vec (data_width, Bool()))

    // Top-level
    zj(data_width-1) := Cat (0.U(1.W), io.z(2*data_width-1, 2*data_width-2), 0.U((2*data_width-2).W))
    rj(data_width-1) := Cat (zj(data_width-1)(2*data_width, 2*data_width-2) - 1.U, 0.U((2*data_width-2).W))
    qSub(data_width-1) := ~ rj(data_width-1)(2*data_width)

    for (i <- data_width-2 to 0 by -1) {
        when (qSub(i+1)) {
            zj(i) := Cat (rj(i+1)(data_width+i+2, 2*i+2), io.z(2*i+1, 2*i)) << (2*i).U
        }.otherwise {
            zj(i) := Cat (zj(i+1)(data_width+i+2, 2*i+2), io.z(2*i+1, 2*i)) << (2*i).U
        }
        val twire = WireInit (VecInit (qSub.slice(i+1, data_width)))
        rj(i) := (zj(i)(data_width+i+2, 2*i)- Cat (twire.asUInt, 1.U(2.W))) << (2*i).U
        qSub(i) := ~rj(i)(data_width+i+2)
    }

    io.q := qSub.asUInt
}

// Extremely slow
class SqrtExtractionUIntAxis (val data_width: Int = 8) extends Module {
    val io = IO (new Bundle {
        val enq = EnqIO(UInt((2*data_width).W))
        val deq = DeqIO(UInt(data_width.W))
    })

    val buf = Reg (UInt((2*data_width).W))
    val qSub = Reg (Vec (data_width, Bool()))
    val upsub = Reg (Vec (data_width, Bool()))

    val empty :: calculating :: calculated :: Nil = Enum(3)
    val stateReg = RegInit(empty)

    when (stateReg === empty) {
        when (io.deq.valid) {
            buf := io.deq.bits
            for (i <- 0 until data_width) {
                qSub(i) := false.B
                if (i != data_width-1) {
                    upsub (i) := false.B
                }
            }
            upsub (data_width-1) := true.B
            stateReg := calculating
        }
    }.elsewhen (stateReg === calculating) {
        val zj = Wire (Vec (data_width, UInt((2*data_width+1).W)))
        val rj = Wire (Vec (data_width, UInt((2*data_width+1).W)))

        // Top-level
        zj(data_width-1) := Cat (0.U(1.W), buf(2*data_width-1, 2*data_width-2), 0.U((2*data_width-2).W))
        rj(data_width-1) := Cat (zj(data_width-1)(2*data_width, 2*data_width-2) - 1.U, 0.U((2*data_width-2).W))
        qSub(data_width-1) := ~ rj(data_width-1)(2*data_width)

        for (i <- data_width-2 to 0 by -1) {
            when (qSub(i+1)) {
                zj(i) := Cat (rj(i+1)(data_width+i+2, 2*i+2), buf(2*i+1, 2*i)) << (2*i).U
            }.otherwise {
                zj(i) := Cat (zj(i+1)(data_width+i+2, 2*i+2), buf(2*i+1, 2*i)) << (2*i).U
            }
            val twire = WireInit (VecInit (qSub.slice(i+1, data_width)))
            rj(i) := (zj(i)(data_width+i+2, 2*i)- Cat (twire.asUInt, 1.U(2.W))) << (2*i).U
            qSub(i) := ~rj(i)(data_width+i+2)
            upsub (i) := upsub (i+1)
        }
        upsub (data_width-1) := false.B
        when (upsub(0)) {
            stateReg := calculated
        }
    
    }.elsewhen (stateReg === calculated) {
        when (io.enq.ready) {
            stateReg := empty
        }
    }
  
    io.enq.valid := (stateReg === calculated)
    io.deq.ready := (stateReg === empty)
    io.enq.bits :=  qSub.asUInt
}

class VecExample extends Module {
    val io = IO (new Bundle {
        val out = Output(UInt(4.W))
    })

    // index 0 implies LSB
    val w = Wire (Vec (4, Bool()))
    w(0) := 0.U
    w(1) := 0.U
    w(2) := 0.U
    w(3) := 1.U

    io.out := w.asUInt
}