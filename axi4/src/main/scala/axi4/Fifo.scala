// From chisel-book
// Chapter 11 Example Designs
// Sec.11.1 FIFO Buffer
// Sec.11.3 FIFO Design Variations

package axi4

import chisel3._
import chisel3.util._
import scala.annotation.switch

// This class is modified from chisel-book
// because the original class was adapted to not ReadyValidIO but DecoupledIO
abstract class FifoIO[T <: Data] (
    private val gen: T, 
    val enq: ReadyValidIO[T], 
    val deq: ReadyValidIO[T]
) extends Bundle {    
}

// This class was created by Shata
// todo:
// Unify FifoIO
class FifoAXIStreamDIO[T <: Data, U <: Data] (private val genEnq: T, private val genDeq: U) extends Bundle {
    val enq = AXIStreamSlaveIF(genEnq)
    val deq = AXIStreamMasterIF(genDeq)
    /* Following declarations are for debug */
    /*
    val state_reg = Output (UInt(2.W))
    val shadow_reg = Output (gen)
    val shadow_user = Output (Bool ())
    val shadow_last = Output (Bool ())
    */
}

// This class was created by Shata
// This class is an AXI Stream IO port that is used when the input data type and output data type are same.
class FifoAXIStreamIO[T <: Data] (private val gen: T) extends FifoAXIStreamDIO(gen, gen) {
}

class FifoAXISCounterIO[T <: Data] (private val gen: T) extends FifoAXIStreamIO(gen) {
    val vcount = Output (UInt (20.W))
    val hcount = Output (UInt (20.W))
}

class DebugFifoAXIStreamIO[T <: Data] (private val gen: T) extends FifoAXIStreamIO(gen) {
    val dport = Output (UInt (32.W))
    val dport2 = Output (UInt (32.W))
    val tdata = Output (UInt (16.W))
    val tdata2 = Output (UInt (200.W))
    val tvalid = Output (Bool())
    val tready = Output (Bool())
}

// This class was renamed from FifoIO in chisel-book.
class FifoDecoupledIO[T <: Data] (gen: T) extends 
        FifoIO[T] (gen, Flipped (new DecoupledIO (gen)), new DecoupledIO (gen)) {
}

abstract class Fifo[T <: Data] (gen: T, depth: Int) extends Module {
    val io = IO (new FifoDecoupledIO[T] (gen))
    assert (depth > 0, "Number of buffer elements needs to be larger than 0")
}

// Todo:
// Unify Fifo class
abstract class FifoAXIS[T <: Data] (gen: T, depth: Int) extends Module {
    val io = IO (new DebugFifoAXIStreamIO[T] (gen))
    assert (depth > 0, "Number of buffer elements needs to be larger than 0")
}

class BubbleFifo[T <: Data] (gen: T, depth: Int) extends Fifo[T] (gen: T, depth: Int) {
    private class Buffer () extends Module {
        val io = IO (new FifoDecoupledIO(gen))

        val fullReg = RegInit (false.B)
        val dataReg = Reg (gen)

        when (fullReg) {
            when (io.deq.ready) {
                fullReg := false.B
            }
        }.otherwise {
            when (io.enq.valid) {
                fullReg := true.B
                dataReg := io.enq.bits
            }
        }

        io.enq.ready := !fullReg
        io.deq.valid := fullReg
        io.deq.bits := dataReg
    }

    private val buffers = Array.fill (depth) { Module (new Buffer()) }
    for (i <- 0 until depth - 1) {
        buffers (i+1).io.enq <> buffers(i).io.deq
    }
    io.enq <> buffers(0).io.enq
    io.deq <> buffers(depth-1).io.deq
}

class DoubleBufferFifo[T <: Data] (gen: T, depth: Int) extends Fifo (gen: T, depth: Int) {
    private class DoubleBuffer[T <: Data] (gen: T) extends Module {
        val io = IO (new FifoDecoupledIO(gen))

        val empty :: one :: two :: Nil = Enum (3)
        val stateReg = RegInit (empty)
        val dataReg = Reg(gen)
        val shadowReg = Reg(gen)

        switch (stateReg) {
            is (empty) {
                when (io.enq.valid) {
                    stateReg := one
                    dataReg := io.enq.bits
                }
            }
            is (one) {
                when (io.deq.ready && !io.enq.valid) {
                    stateReg := empty
                }
                when (io.deq.ready && io.enq.valid) {
                    stateReg := one
                    dataReg := io.enq.bits
                }
                when (!io.deq.ready && io.enq.valid) {
                    stateReg := two
                    shadowReg := io.enq.bits
                }
            }
            is (two) {
                when (io.deq.ready) {
                    dataReg := shadowReg
                    stateReg := one
                }
            }
        }

        io.enq.ready := (stateReg === empty || stateReg === one)
        io.deq.valid := (stateReg === one || stateReg === two)
        io.deq.bits := dataReg
    }

    private val buffers = Array.fill ((depth+1)/2) { Module(new DoubleBuffer(gen))}
    for (i <- 0 until (depth+1)/2-1) {
        buffers(i+1).io.enq <> buffers(i).io.deq
    }
    io.enq <> buffers(0).io.enq
    io.deq <> buffers((depth+1)/2-1).io.deq
}


class DoubleBufferFifoAXIS[T <: Data] (gen: T, depth: Int) extends FifoAXIS (gen: T, depth: Int) {
    private class DoubleBufferAXIS[T <: Data] (gen: T) extends Module {
        val io = IO (new FifoAXIStreamIO(gen))
    
        // default output
        io.deq.last := false.B
        io.deq.user := false.B

        val empty :: one :: two :: Nil = Enum (3)
        val stateReg = RegInit (empty)
        val dataReg = Reg(gen)
        val shadowReg = Reg(gen)

        switch (stateReg) {
            is (empty) {
                when (io.enq.valid) {
                    stateReg := one
                    dataReg := io.enq.bits
                }
            }
            is (one) {
                when (io.deq.ready && !io.enq.valid) {
                    stateReg := empty
                }
                when (io.deq.ready && io.enq.valid) {
                    stateReg := one
                    dataReg := io.enq.bits
                }
                when (!io.deq.ready && io.enq.valid) {
                    stateReg := two
                    shadowReg := io.enq.bits
                }
            }
            is (two) {
                when (io.deq.ready) {
                    dataReg := shadowReg
                    stateReg := one
                }
            }
        }

        io.enq.ready := (stateReg === empty || stateReg === one)
        io.deq.valid := (stateReg === one || stateReg === two)
        io.deq.bits := dataReg
        io.deq.user := io.enq.user
        io.deq.last := io.enq.last
    }


    private val buffers = Array.fill ((depth+1)/2) { Module(new DoubleBufferAXIS(gen))}
    for (i <- 0 until (depth+1)/2-1) {
        buffers(i+1).io.enq <> buffers(i).io.deq
    }
    io.enq <> buffers(0).io.enq
    io.deq <> buffers((depth+1)/2-1).io.deq
}