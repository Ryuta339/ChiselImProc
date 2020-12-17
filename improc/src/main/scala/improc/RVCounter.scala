package improc

import chisel3._
import chisel3.util._

class RVCounter(data_width: Int) extends Module {
    val io = IO (new Bundle {
        val ready = Input (Bool())
        val valid = Input (Bool())
        val user = Input (Bool())
        val last = Input (Bool())
        val xoutput = Output (UInt(data_width.W))
        val youtput = Output (UInt(data_width.W))
    })

    val xcnt = RegInit (0.U(data_width.W))
    val ycnt = RegInit (0.U(data_width.W))

    when (io.user) {
        xcnt := 1.U
        ycnt := 0.U
    }.elsewhen (io.ready && io.valid) {
        when (io.last) {
            xcnt := 0.U
            ycnt := ycnt + 1.U
        } .otherwise {
            xcnt := xcnt + 1.U
        }
    }

    io.xoutput := xcnt
    io.youtput := ycnt
}