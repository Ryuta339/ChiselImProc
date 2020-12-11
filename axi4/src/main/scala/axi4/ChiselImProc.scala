package axi4

import chisel3._
import chisel3.util._
import chisel3.util.experimental._
import javax.net.ssl.SSLEngineResult.Status

/** Gradient Direction **/
trait GradDirDefinition {
    val dir_right :: dir_top_right :: dir_top :: dir_top_left :: Nil = Enum (4)
}

class GradPix extends Bundle {
    val grad_dir = UInt (2.W)
    val value = UInt (8.W)
}

// Unsigned multiplication and addition
class MulAdd (data_width: Int, num: Int) extends Module {
    val io = IO(new Bundle {
        val a = Input (Vec(num, UInt(data_width.W)))
        val b = Input (Vec(num, UInt(data_width.W)))
        val output = Output (UInt ((2*data_width).W))
    })

    var i = 0
    var tmp = 0.U((2*data_width).W)
    val step = 3        // Have to change this when num is not 3
    for (i <- 0 until num by step) {
        var intmp = 0.U((2*data_width).W)
        for (j <- 0 until step) {
            intmp += io.a(i+j) * io.b (i+j)
        }
        tmp += intmp
    }
    io.output := tmp    
}

// Signed multiplication and addition
class SMulAdd (data_width: Int, num: Int) extends Module {
    val io = IO(new Bundle{
        val a = Input (Vec (num, SInt(data_width.W)))
        val b = Input (Vec (num, SInt(data_width.W)))
        val output = Output (SInt ((2*data_width).W))
    })

    var i = 0
    var tmp = 0.S ((2*data_width).W)
    while (i < num) {
        tmp += io.a(i) * io.b(i)
        i += 1
    }
    io.output := tmp
}

// set status
abstract class StatusFifo[T <: Data, U <: Data] (private val genEnq: T, private val genDeq: U) extends Module {

    // define states
    // block state is not used now
    val empty :: one :: two :: block :: Nil = Enum (4)
    val stateReg = RegInit (empty)
    val dataReg = Reg (genEnq)
    val shadowReg = Reg (genEnq)
    val userReg = Reg (Bool())
    val shadowUserReg = Reg (Bool())
    val lastReg = Reg (Bool())
    val shadowLastReg = Reg (Bool())


    def setStatus (io: FifoAXIStreamDIO[T,U]): Unit = {
       switch (stateReg) {
            is (empty) {
                userReg := io.enq.user
                when (io.enq.valid) {
                    stateReg := one
                    dataReg := io.enq.bits
                    lastReg := io.enq.last
                }
            }
            is (one) {
                when (io.deq.ready && !io.enq.valid) {
                    stateReg := empty
                    userReg := io.enq.user
                }.elsewhen (io.deq.ready && io.enq.valid) {
                    stateReg := one
                    dataReg := io.enq.bits
                    userReg := io.enq.user
                    lastReg := io.enq.last
                }.elsewhen (!io.deq.ready && io.enq.valid) {
                    stateReg := two
                    shadowReg := io.enq.bits
                    shadowUserReg := io.enq.user
                    shadowLastReg := io.enq.last
                }
            }
            is (two) {
                when (io.deq.ready) {
                    dataReg := shadowReg
                    userReg := shadowUserReg
                    lastReg := shadowLastReg
                    stateReg := one
                }
            }
            is (block) {
                stateReg := empty
            }
        }
        

        io.deq.last := lastReg
        io.deq.user := userReg

        io.enq.ready := (stateReg === empty || stateReg === one || stateReg === block)
        io.deq.valid := (stateReg === one || stateReg === two)

        /*
        io.state_reg := stateReg
        io.shadow_reg := shadowReg
        io.shadow_user := shadowUserReg
        io.shadow_last := shadowLastReg
        io.shadow_reg := dataReg
        io.shadow_user := userReg
        io.shadow_last := lastReg
        */

        // io.enq <> io.deq
        // io.deq.last := io.enq.last
        // io.deq.user := io.enq.user
        // io.deq.bits := io.enq.bits
    }
}

// ImageFilter is a base class for each filter
// Each filter extends this class.
// The result of a filter should be written on io.deq.bits
class ImageFilter (data_width: Int, width: Int, height: Int) extends StatusFifo(UInt(data_width.W), UInt(data_width.W)) {
    val io = IO (new FifoAXIStreamIO (UInt (data_width.W)))

    // default output
    io.deq.last := false.B
    io.deq.user := false.B

    setStatus(io)
}


// This filter does Nothing
class NothingFilter (data_width: Int, width: Int, height: Int) extends ImageFilter (data_width, width, height) {
    io.deq.bits := dataReg
}

// Only red component passes through this filter
class RedFilter (data_width: Int, width: Int, height: Int) extends ImageFilter (data_width, width, height) {
    io.deq.bits := dataReg & 0xFF0000.U
}
// Only blue component passes through this filter
class BlueFilter (data_width: Int, width: Int, height: Int) extends ImageFilter (data_width, width, height) {
    io.deq.bits := dataReg & 0x0000FF.U
}

// This filter converts 256x256x256 rgb color image into 256 gray scale image
class RGB2GrayFilter (data_width: Int, width: Int, height: Int) extends ImageFilter (data_width, width, height) {
    val pixGray = Wire (UInt(32.W))
    val rolled = Wire (UInt(16.W))

    // for debug
    val xcounter = Reg(UInt((log2Ceil(width)+1).W))
    val ycounter = Reg(UInt((log2Ceil(height)+1).W))

    when (userReg) {
        xcounter := 0.U
        ycounter := 0.U
    }.elsewhen (lastReg && (stateReg === one || stateReg === two) && io.deq.ready) {
        xcounter := 0.U
        ycounter := ycounter + 1.U
    }.elsewhen ((stateReg === one || stateReg === two) && io.deq.ready) {
        xcounter := xcounter + 1.U
    }
    
    pixGray := ((9437.U * (dataReg & 0x0000FF.U) +
            38469.U * ((dataReg & 0x00FF00.U) >> 8.U) +
            19595.U * ((dataReg & 0xFF0000.U) >> 16.U)))

    rolled := (pixGray >> 16.U)
    io.deq.bits := Mux (rolled > 0xFF.U, 0xFF.U, rolled)

    val xblock = width / 8
    val yblock = height / 8

    // io.deq.bits := xcounter / xblock.U * 2.U + ycounter / yblock.U * 16.U
}

// This filter converts 256 gray scale image into 256x256x256 color but gray scale image
class Gray2RGBFilter (data_width: Int, width: Int, height: Int) extends ImageFilter (data_width, width, height) {
    io.deq.bits := dataReg << 16.U | dataReg << 8.U | dataReg
}

// This filter is Gaussian blur.
// In the original canny-edge-detection of HLS, the gaussian kernel is 5x5.
// To deal with the delay, this gaussian kernel is 3x3.
class GaussianBlurFilter (data_width: Int, width: Int, height: Int) extends ImageFilter (data_width, width, height) {
    // val KERNEL_SIZE = 5
    val KERNEL_SIZE = 3
    val GAUSS_KERNEL = Reg (Vec (KERNEL_SIZE*KERNEL_SIZE, UInt(data_width.W)))
    /*
    GAUSS_KERNEL := Seq (
            1.U,  4.U,  6.U,  4.U, 1.U,
            4.U, 16.U, 24.U, 16.U, 4.U,
            6.U, 24.U, 36.U, 24.U, 6.U,
            4.U, 16.U, 24.U, 16.U, 4.U,
            1.U,  4.U,  6.U,  4.U, 1.U,
    )
    */
    GAUSS_KERNEL := Seq (
        1.U, 2.U, 1.U,
        2.U, 4.U, 2.U,
        1.U, 2.U, 1.U,
    )

    val lineBuffer = Reg (Vec (width*KERNEL_SIZE, UInt(data_width.W)))    
    val windowBuffer = Reg (Vec (KERNEL_SIZE*KERNEL_SIZE, UInt (data_width.W)))
    val sel = Wire (Bool())

    sel := (stateReg===one || stateReg===two) && io.deq.ready

    for (i <- 0 until width*KERNEL_SIZE-1) {
         lineBuffer(i+1) := Mux (sel, lineBuffer(i), lineBuffer(i+1))
    }
    lineBuffer (0) := Mux (sel, dataReg, lineBuffer(0))

    for (yw <- 0 until KERNEL_SIZE; xw <- 0 until (KERNEL_SIZE-1)) {
        windowBuffer (xw+yw*KERNEL_SIZE) := Mux (sel, windowBuffer (xw+yw*KERNEL_SIZE+1), windowBuffer(xw+yw*KERNEL_SIZE))
    }
    for (yw <- 0 until KERNEL_SIZE) {
        windowBuffer ((yw+1)*KERNEL_SIZE-1) := Mux (sel, lineBuffer ((yw+1)*width-1), windowBuffer((yw+1)*KERNEL_SIZE-1))
    }

    private val ma = Module (new MulAdd (data_width, KERNEL_SIZE*KERNEL_SIZE))


    ma.io.a := GAUSS_KERNEL
    ma.io.b := windowBuffer

    io.deq.bits := ma.io.output >> 4
}

// data and gradient info along horizontal and vertical axis
// TODO:
//      parameterize # of bits of horizontal and vertical 
class SobelGradient(private val data_width: Int) extends Bundle{
    val data = UInt (data_width.W)
    val horizontal = SInt (32.W)
    val vertical = SInt (32.W)
}

// This is a sobel filter (first differential filter along to x and y axis)
class SobelConvolution (data_width: Int, width: Int, height: Int) 
        extends StatusFifo(UInt(data_width.W), new SobelGradient(4*data_width)) {
    val io = IO (
        new FifoAXIStreamDIO(UInt(data_width.W), new SobelGradient(4*data_width))
    )

    val KERNEL_SIZE = 3
    // 3x3 horizontal sobel kernel
    val H_SOBEL_KERNEL = Reg (Vec (KERNEL_SIZE*KERNEL_SIZE, SInt(16.W)))
    // 3x3 vertical sobel kernel
    val V_SOBEL_KERNEL = Reg (Vec (KERNEL_SIZE*KERNEL_SIZE, SInt(16.W)))
    H_SOBEL_KERNEL := Seq (
        1.S,  0.S, -1.S,
        2.S,  0.S, -2.S,
        1.S,  0.S, -1.S,
    )
    V_SOBEL_KERNEL := Seq (
         1.S,  2.S,  1.S,
         0.S,  0.S,  0.S,
        -1.S, -2.S, -1.S,
    )

    val lineBuffer = Reg (Vec (width*KERNEL_SIZE, UInt(data_width.W)))    
    val windowBuffer = Reg (Vec (KERNEL_SIZE*KERNEL_SIZE, SInt ((2*data_width).W)))
    val sel = Wire (Bool())

    setStatus (io)

    sel := (stateReg===one || stateReg===two) && io.deq.ready

    for (i <- 0 until width*KERNEL_SIZE-1) {
        lineBuffer(i+1) := Mux (sel, lineBuffer(i), lineBuffer(i+1))
    }
    lineBuffer(0) := Mux (sel, dataReg, lineBuffer(0))

    for (yw <- 0 until KERNEL_SIZE; xw <- 0 until (KERNEL_SIZE-1)) {
        windowBuffer (xw+yw*KERNEL_SIZE) := Mux (sel, windowBuffer (xw+yw*KERNEL_SIZE+1), windowBuffer (xw+yw*KERNEL_SIZE))
    }
    for (yw <- 0 until KERNEL_SIZE) {
        windowBuffer ((yw+1)*KERNEL_SIZE-1) := Mux (sel, (0.U((2*data_width).W)+lineBuffer ((yw+1)*width-1)).asSInt, windowBuffer ((yw+1)*KERNEL_SIZE-1))
    }

    private val hma = Module (new SMulAdd (2*data_width, KERNEL_SIZE*KERNEL_SIZE))
    private val vma = Module (new SMulAdd (2*data_width, KERNEL_SIZE*KERNEL_SIZE))

    hma.io.a := H_SOBEL_KERNEL
    hma.io.b := windowBuffer
    vma.io.a := V_SOBEL_KERNEL
    vma.io.b := windowBuffer


    BoringUtils.addSource (hma.io.output.asUInt, "tdata")
    BoringUtils.addSource (Cat(windowBuffer), "tdata2")
    BoringUtils.addSource (io.deq.valid, "tvalid")
    BoringUtils.addSource (io.deq.ready, "tready")

    io.deq.bits.data := (hma.io.output*hma.io.output + vma.io.output*vma.io.output).asUInt
    io.deq.bits.horizontal := hma.io.output
    io.deq.bits.vertical := vma.io.output
}

class SqrtWrapper(data_width: Int, width: Int, height:Int) 
        extends StatusFifo (new SobelGradient(4*data_width), new SobelGradient(2*data_width)) {
    val io = IO (
        new FifoAXIStreamDIO(new SobelGradient(4*data_width), new SobelGradient(2*data_width))
    )

    val sel = Wire (Bool())
    setStatus (io)
    sel := (stateReg===one || stateReg===two) && io.deq.ready

    private class SqrtExtractionElement(val data_width: Int = 8, val lv: Int) extends Module {
        val io = IO (
            new Bundle {
                val z = Input (UInt((2*data_width).W))
                val inq = Input (UInt(data_width.W))
                val outq = Output (UInt(data_width.W))
                val inz = Input (UInt ((2*data_width+1).W))
                val outz = Output (UInt ((2*data_width+1).W))
                val inr = Input (UInt ((2*data_width+1).W))
                val outr = Output (UInt ((2*data_width+1).W))
            }
        )
       
        val zlv = Wire (UInt ((2*data_width+1).W))
        val rlv = Wire (UInt ((2*data_width+1).W))
        val qsub = Wire (Vec (data_width, Bool()))

        if (lv == data_width-1) {
            zlv := Cat (0.U(1.W), io.z(2*data_width-1, 2*data_width-2), 0.U((2*data_width-2).W))
            rlv := Cat (zlv(2*data_width, 2*data_width-2)-1.U, 0.U((2*data_width-2).W))
            qsub(data_width-1) := ~rlv(2*data_width)
        } else {
            when (io.inq(lv+1)) {
                zlv := Cat (io.inr(data_width+lv+2,2*lv+2), io.z(2*lv+1, 2*lv)) << (2*lv).U
            }.otherwise {
                zlv := Cat (io.inz(data_width+lv+2,2*lv+2), io.z(2*lv+1, 2*lv)) << (2*lv).U
            }
            rlv := (zlv(data_width+lv+2, 2*lv) - Cat (io.inq(data_width-1, lv+1), 1.U(2.W))) << (2*lv).U
            qsub(lv) := ~ rlv(data_width+lv+2)
        }
        // 下位ビットの処理
        for (i <- 0 until lv) {
            qsub (i) := 0.U
        }
        // 上位ビットの処理
        for (i <- (lv+1) until data_width) {
            qsub (i) := io.inq(i)
        }

        io.outq := qsub.asUInt
        io.outz := zlv.asUInt
        io.outr := rlv.asUInt
    }

    private val ladder = (2*data_width-1 to 0 by -1).map(x => {Module (new SqrtExtractionElement(2*data_width, x))}).toArray
    val inputreg = Reg (Vec (2*data_width, new SobelGradient(4*data_width)))
    val qreg = Reg (Vec (2*data_width, UInt((2*data_width).W)))
    val rlvreg = Reg (Vec (2*data_width, UInt((2*data_width+1).W)))
    val zlvreg = Reg (Vec (2*data_width, UInt((2*data_width+1).W)))
    for (i <- 0 until (2*data_width-1)) {
        ladder(i+1).io.z := inputreg(i).data
        ladder(i+1).io.inq := qreg(i)
        ladder(i+1).io.inz := zlvreg(i)
        ladder(i+1).io.inr := rlvreg(i)

        inputreg(i+1) := Mux (sel, inputreg(i), inputreg(i+1))
        qreg(i) := Mux (sel, ladder(i).io.outq, qreg(i))
        rlvreg(i) := Mux (sel, ladder(i).io.outr, rlvreg(i))
        zlvreg(i) := Mux (sel, ladder(i).io.outz, zlvreg(i))
    }
    ladder(0).io.z := dataReg.data
    ladder(0).io.inq := 0.U
    ladder(0).io.inr := 0.U
    ladder(0).io.inz := 0.U
    inputreg(0) := Mux (sel, dataReg, inputreg(0))
    qreg(2*data_width-1) := Mux (sel, ladder(2*data_width-1).io.outq, qreg(2*data_width-1))
    rlvreg(2*data_width-1) := Mux (sel, ladder(2*data_width-1).io.outr, rlvreg(2*data_width-1))
    zlvreg(2*data_width-1) := Mux (sel, ladder(2*data_width-1).io.outz, zlvreg(2*data_width-1))
    /*
    // Calculaate square root
    private val sqrtuint = Module (new SqrtExtractionUInt (2*data_width))
    sqrtuint.io.z := dataReg.data
    // io.deq.bits.data := sqrtuint.io.q
    val wire = Wire (Vec (2*data_width, Bool()))
    for (i <- 0 until 2*data_width) {
        wire(i) := dataReg.data(2*i+1) | dataReg.data(2*i)
    }
    io.deq.bits.data := Cat (wire).asUInt
    io.deq.bits.horizontal := dataReg.horizontal
    io.deq.bits.vertical := dataReg.vertical
    */

    io.deq.bits.data := qreg(2*data_width-1)
    io.deq.bits.horizontal := inputreg(2*data_width-1).horizontal
    io.deq.bits.vertical := inputreg(2*data_width-1).vertical

    /*
    BoringUtils.addSource (dataReg.data, "tdata3")
    BoringUtils.addSource (qreg(2*data_width-1), "tdata4")
    BoringUtils.addSource (io.deq.valid, "tvalid3")
    BoringUtils.addSource (io.deq.ready, "tready3")
 
    */
}

class CalculaateGradient (data_width: Int, width: Int, height: Int)
        extends StatusFifo (new SobelGradient(2*data_width), new GradPix) with GradDirDefinition {
    
    val io = IO (
        new FifoAXIStreamDIO(new SobelGradient(2*data_width), new GradPix)
    )

    setStatus (io)

    val pix_sobel = Wire (UInt((2*data_width).W))

    pix_sobel := Mux (dataReg.data > 0xFF.U, 0xFF.U, dataReg.data)

    val t_int = Wire (SInt((4*data_width).W))
    t_int := Mux (dataReg.horizontal === 0.S, 0x7FFFFFFF.S, dataReg.vertical * 0x100.S / dataReg.horizontal)

    val grad_sobel = Wire (UInt(2.W))
    when (-618.S < t_int && t_int <= -106.S) {
        grad_sobel := dir_top_left
    }.elsewhen (-106.S < t_int && t_int <= 106.S) {
        grad_sobel := dir_right
    }.elsewhen (106.S < t_int && t_int <= 618.S) {
        grad_sobel := dir_top_right
    }.otherwise {
        grad_sobel := dir_top
    }

    io.deq.bits.grad_dir := grad_sobel
    io.deq.bits.value := pix_sobel
}

class SobelFilter (data_width: Int, width: Int, height: Int)
        extends StatusFifo(UInt(data_width.W), new GradPix) with GradDirDefinition {
        
    val io = IO (new FifoAXIStreamDIO (UInt(data_width.W), new GradPix))

    val conv = Module (new SobelConvolution (data_width, width, height))
    val sqrtw = Module (new SqrtWrapper (data_width, width, height))
    val cgrad = Module (new CalculaateGradient (data_width, width, height))

    io.enq <> conv.io.enq
    conv.io.deq <> sqrtw.io.enq
    sqrtw.io.deq <> cgrad.io.enq

    cgrad.io.deq <> io.deq
}

// Non Max Supression filter.
class NonMaxSupression (data_width: Int, width: Int, height: Int)
        extends StatusFifo(new GradPix, UInt(data_width.W)) with GradDirDefinition {
    val io = IO (new FifoAXIStreamDIO(new GradPix, UInt(data_width.W)))

   val WINDOW_SIZE = 3
   val WINDOW_CENTER_IDX = WINDOW_SIZE*WINDOW_SIZE/2
  
   val lineBuffer = Reg (Vec (width*WINDOW_SIZE, new GradPix))
   val windowBuffer = Reg (Vec (WINDOW_SIZE*WINDOW_SIZE, new GradPix))
   val sel = Wire (Bool())

   setStatus (io)

   sel := (stateReg===one | stateReg===two) && io.deq.ready

   for (i <- 0 until width*WINDOW_SIZE-1) {
       lineBuffer(i+1) := Mux (sel, lineBuffer(i), lineBuffer(i+1))
   }
   lineBuffer(0) := Mux (sel, dataReg, lineBuffer(0))

   for (yw <- 0 until WINDOW_SIZE; xw <- 0 until (WINDOW_SIZE-1)) {
       windowBuffer (xw+yw*WINDOW_SIZE) := Mux (sel, windowBuffer(xw+yw*WINDOW_SIZE+1), windowBuffer (xw+yw*WINDOW_SIZE))
   }
   for (yw <- 0 until WINDOW_SIZE) {
       windowBuffer ((yw+1)*WINDOW_SIZE-1) := Mux (sel, lineBuffer((yw+1)*width-1), windowBuffer ((yw+1)*WINDOW_SIZE-1))
   }

   val nms = Wire (new GradPix)
   val vnms = WireInit (0.U (data_width.W))
   nms := windowBuffer(WINDOW_CENTER_IDX)

   switch (nms.grad_dir) {
       is (dir_right) {
           // grad 0 -> left. right
            when (nms.value < windowBuffer(WINDOW_CENTER_IDX-1).value || nms.value < windowBuffer(WINDOW_CENTER_IDX+1).value) {
                vnms := 0.U
            }.otherwise {
                vnms := nms.value
            }
       }
       is (dir_top_right) {
           // grad 45 -> upper left, bottom right
           when (nms.value < windowBuffer(0).value || nms.value < windowBuffer(WINDOW_SIZE*WINDOW_SIZE-1).value) {
               vnms := 0.U
           }.otherwise {
               vnms := nms.value
           }
       }
       is (dir_top) {
           // grad 90 -> upper, bottom
           when (nms.value < windowBuffer(WINDOW_CENTER_IDX-WINDOW_SIZE).value || nms.value < windowBuffer(WINDOW_CENTER_IDX+WINDOW_SIZE).value) {
               vnms := 0.U
           }.otherwise {
               vnms := nms.value
           }
       }
       is (dir_top_left) {
           // grad 135 -> bottom left, upper right
           when (nms.value < windowBuffer(WINDOW_SIZE-1).value || nms.value < windowBuffer(WINDOW_SIZE*(WINDOW_SIZE-1)).value) {
               vnms := 0.U
           }.otherwise {
               vnms := nms.value
           }
       }
   }

   io.deq.bits := vnms
}

// Output of Sobel filter and input of Non-max supression filter are different from 8-bit unsigned int data.
// Thus the connection between these cannot be applied in ChiselImProc module.
class SobelAndNonMaxSupressionFilter (data_width: Int, width: Int, height: Int) extends ImageFilter (data_width, width, height) {
    val sobel = Module (new SobelFilter (data_width, width, height))
    val nonmaxSupression = Module (new NonMaxSupression (data_width, width, height))

    io.enq <> sobel.io.enq
    sobel.io.deq <> nonmaxSupression.io.enq
    nonmaxSupression.io.deq <> io.deq
}

// This filter do zero padding.
class ZeroPadding (data_width: Int, width: Int, height: Int) extends ImageFilter(data_width, width, height) {
    val PADDING_SIZE = 5.U

    val xcounter = Reg(UInt((log2Ceil(width)+1).W))
    val ycounter = Reg(UInt((log2Ceil(height)+1).W))

    when (userReg) {
        xcounter := 0.U
        ycounter := 0.U
    }.elsewhen (lastReg && (stateReg === one || stateReg === two) && io.deq.ready) {
        xcounter := 0.U
        ycounter := ycounter + 1.U
    }.elsewhen ((stateReg === one || stateReg === two) && io.deq.ready) {
        xcounter := xcounter + 1.U
    }

    when (PADDING_SIZE < xcounter && xcounter < width.U-PADDING_SIZE &&
            PADDING_SIZE < ycounter && ycounter < height.U-PADDING_SIZE) {
        io.deq.bits := dataReg
    }.otherwise {
        io.deq.bits := 0.U
    }
}

// Threshold filter
class HystThreshold (data_width: Int, width: Int, height: Int) extends ImageFilter(data_width, width, height) {
    val HTHR = 80.U
    val LTHR = 20.U
    when (dataReg < LTHR) {
        io.deq.bits := 0.U
    }.elsewhen (dataReg > HTHR) {
        io.deq.bits := 0xFF.U
    }.otherwise {
        io.deq.bits := 1.U
    }
}

class HystThresholdComp (data_width: Int, width: Int, height: Int) extends ImageFilter(data_width, width, height) {
    val WINDOW_SIZE = 3
    val WINDOW_CENTER_IDX = WINDOW_SIZE*WINDOW_SIZE/2
  
   val lineBuffer = Reg (Vec (width*WINDOW_SIZE, UInt(data_width.W)))
   val windowBuffer = Reg (Vec (WINDOW_SIZE*WINDOW_SIZE, UInt(data_width.W)))
   val sel = Wire (Bool())

   setStatus (io)

   sel := (stateReg===one | stateReg===two) && io.deq.ready

   for (i <- 0 until width*WINDOW_SIZE-1) {
       lineBuffer(i+1) := Mux (sel, lineBuffer(i), lineBuffer(i+1))
   }
   lineBuffer(0) := Mux (sel, dataReg, lineBuffer(0))

   for (yw <- 0 until WINDOW_SIZE; xw <- 0 until (WINDOW_SIZE-1)) {
       windowBuffer (xw+yw*WINDOW_SIZE) := Mux (sel, windowBuffer(xw+yw*WINDOW_SIZE+1), windowBuffer (xw+yw*WINDOW_SIZE))
   }
   for (yw <- 0 until WINDOW_SIZE) {
       windowBuffer ((yw+1)*WINDOW_SIZE-1) := Mux (sel, lineBuffer((yw+1)*width-1), windowBuffer ((yw+1)*WINDOW_SIZE-1))
   }

    val pix_hyst = Wire (UInt(data_width.W)) 
    when (windowBuffer(WINDOW_CENTER_IDX) =/= 0.U){
        val flag = Wire(Vec (WINDOW_SIZE*WINDOW_SIZE, Bool()))
        flag(0) := true.B
        for (i <- 0 until WINDOW_SIZE*WINDOW_SIZE-1) {
            flag(i+1) := flag(i) && (windowBuffer(i) =/= 0xFF.U)
        }
        pix_hyst := Mux (flag(WINDOW_SIZE*WINDOW_SIZE-1), 0.U, 0xFF.U)
    }.otherwise {
        pix_hyst := 0.U
    }
    io.deq.bits := pix_hyst
}

// Top module class
class ChiselImProc (data_width: Int, depth: Int, width: Int, height: Int) extends FifoAXIS (UInt(data_width.W),  depth) {

    val MAX_WIDTH = width
    val MAX_HEIGHT = height

    val buffers = Array (
        // RGB -> GrayScale image
        Module (new RGB2GrayFilter (data_width, width, height)),
        // Gaussian bler
        Module (new GaussianBlurFilter (data_width/3, width, height)),
        // Module (new NothingFilter (data_width/3, width, height)),
        // Sobel filter
        Module (new SobelAndNonMaxSupressionFilter (data_width/3, width, height)),
        // Module (new NothingFilter (data_width/3, width, height)),
        // Non-Maximum suppression
        // Zero padding at boundary pixel
        Module (new ZeroPadding (data_width/3, width, height)),
        // Module (new NothingFilter (data_width/3, width, height)),
        // Hysteresis threshold
        Module (new HystThreshold (data_width/3, width, height)),
        // Module (new NothingFilter (data_width/3, width, height)),
        // Comparison operation
        Module (new HystThresholdComp (data_width/3, width, height)),
        // Module (new NothingFilter (data_width/3, width, height)),
        // GrayScale image -> RGB
        Module (new Gray2RGBFilter (data_width, width, height)),
    )
    
    // Connect each filter
    for (i <- 0 until depth-1) {
        buffers (i+1).io.enq <> buffers(i).io.deq
    }
    // Connect enq of this module and that of first filter
    io.enq <> buffers(0).io.enq
    // Connect deq of this module and that of last filter
    io.deq <> buffers(depth-1).io.deq

    // for debug
    val tvalid = WireInit (false.B)
    val tready = WireInit (false.B)
    val tdata = WireInit (0.U(16.W))
    val tdata2 = WireInit (0.U((8*25).W))
    val tvalid3 = WireInit (false.B)
    val tready3 = WireInit (false.B)
    val tdata3 = WireInit (0.U(32.W))
    val tdata4 = WireInit (0.U(16.W))
    BoringUtils.addSink (tvalid, "tvalid")
    BoringUtils.addSink (tready, "tready")
    BoringUtils.addSink (tdata, "tdata")
    BoringUtils.addSink (tdata2, "tdata2")
    BoringUtils.addSink (tvalid3, "tvalid3")
    BoringUtils.addSink (tready3, "tready3")
    BoringUtils.addSink (tdata3, "tdata3")
    BoringUtils.addSink (tdata4, "tdata4")
    io.tdata := tdata
    io.tvalid := tvalid
    io.tready := tready
    io.tdata2 := tdata2
    io.tdata3 := tdata3
    io.tvalid3 := tvalid3
    io.tready3 := tready3
    io.tdata4 := tdata4
}