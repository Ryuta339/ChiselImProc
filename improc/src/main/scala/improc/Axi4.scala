package improc

import chisel3._
import chisel3.util._

class AXI4LiteMasterIO (addr_width: Int = 32, data_width: Int = 32) extends Bundle {
    val write_address = new WriteAddressChannel (addr_width)
    val write_data = new WriteDataChannel (data_width)
    val write_response = new WriteResponseChannel ()
    val read_addr = new ReadAddressChannel (addr_width)
    val read_data = new ReadDataChannel (data_width)
}

class AXI4LiteSlaveIO (addr_width: Int, data_width: Int) extends Bundle {
     
    val write_address = Flipped (new WriteAddressChannel (addr_width))
    val write_data = Flipped (new WriteDataChannel (data_width))
    val write_response = Flipped (new WriteResponseChannel ())
    val read_addr = Flipped (new ReadAddressChannel (addr_width))
    val read_data = Flipped (new ReadDataChannel (data_width))
}


class AXI4Channel (direction: Chisel.Direction = Chisel.OUTPUT) extends Bundle {
    /*
    val valid = Bool (direction)
    val ready = Bool (direction).flip
    */
    val valid: Bool = direction match {
        case Chisel.INPUT => Input(Bool())
        case Chisel.OUTPUT => Output(Bool())
        //case Chisel.NODIR => Bool
    }
    val ready: Bool = Flipped (direction match {
        case Chisel.INPUT => Input(Bool())
        case Chisel.OUTPUT => Output(Bool())
        // case Chisel.NODIR => Bool
    })    
}

class AXI4StreamMasterChannel (data_width: Int) extends AXI4Channel {
    val data = Output (UInt(data_width.W))
    val user = Output (Bool())
    val last = Output (Bool())
}

class AXI4StreamSlaveChannel (data_width: Int) extends AXI4Channel(Chisel.INPUT) {
    val data = Input (UInt(data_width.W))
    val user = Input (Bool())
    val last = Input (Bool())
}

class WriteAddressChannel (addr_width: Int) extends AXI4Channel {
    val addr = Output (UInt(addr_width.W))
    val prot = Output (UInt(3.W))

    override def cloneType: this.type =
        new WriteAddressChannel(addr_width).asInstanceOf[this.type]
}

class WriteDataChannel (data_width: Int) extends AXI4Channel {
    val data = Output (UInt(data_width.W))
    val strb = Output (UInt((data_width/8).W))

    override def cloneType: this.type =
        new WriteDataChannel(data_width).asInstanceOf[this.type]
}

class WriteResponseChannel extends AXI4Channel(Chisel.INPUT) {
    val resp = Input (UInt(2.W))
}

class ReadAddressChannel (addr_width: Int) extends AXI4Channel {
    val addr = Output (UInt(addr_width.W))
    val prot = Output (UInt(3.W))

    override def cloneType: this.type =
        new ReadAddressChannel(addr_width).asInstanceOf[this.type]
}

class ReadDataChannel (data_width: Int) extends AXI4Channel (Chisel.INPUT) {
    val data = Input (UInt(data_width.W))
    val resp = Input (UInt(2.W))

    override def cloneType: this.type =
        new ReadDataChannel(data_width).asInstanceOf[this.type]
}

class AXI4LiteSlave (addr_width: Int, data_width: Int) extends Module {
    val io = IO (new Bundle {
        val host_data = new Bundle {
            val valid = Output (Bool())
            val data = Output (UInt(data_width.W))
            val ready = Input (Bool())
        }
        val slave = new AXI4LiteSlaveIO(addr_width, data_width)
    })

    // default output value
    io.slave.write_address.ready := false.B    
    io.slave.write_data.ready := false.B
    io.slave.write_response.valid := false.B
    io.slave.write_response.resp := 0.U(2.W)
    io.slave.read_addr.ready := false.B
    io.slave.read_data.valid := false.B
    io.slave.read_data.data := 0.U(data_width.W)
    io.slave.read_data.resp := 0.U(2.W)

    io.host_data.data := 0.U(data_width.W)
    io.host_data.valid := false.B

    val s_wait_host_ready :: s_wait_write_addr_valid :: s_wait_write_data_valid :: s_wait_write_response_ready  :: Nil = Enum(4)
    val w_state = RegInit (s_wait_write_addr_valid)

    val write_addr = RegInit (0.U(addr_width.W))
    val write_data = RegInit (0.U(data_width.W))

    when (w_state === s_wait_host_ready) {
        io.host_data.data := write_data
        io.host_data.valid := true.B
        when (io.host_data.ready) {
            w_state := s_wait_write_addr_valid
        }
    }.elsewhen (w_state === s_wait_write_addr_valid) {
        // Assert awready, and wait awvalid
        io.slave.write_address.ready := true.B
        
        when (io.slave.write_address.valid) {
            write_addr := io.slave.write_address.addr
            w_state := s_wait_write_data_valid
        }
    }.elsewhen (w_state === s_wait_write_data_valid) {
        // Assert wraedy, and wait wvalid 
        io.slave.write_data.ready := true.B
        when (io.slave.write_data.valid) {
            // TODO strb
            write_data := io.slave.write_data.data
            w_state := s_wait_write_response_ready
        }
    }.elsewhen (w_state === s_wait_write_response_ready) {
        // Write bresp, assert bvalid, and waot bready
        io.slave.write_response.resp := 0.U(2.W)
        io.slave.write_response.valid := true.B
        when (io.slave.write_response.ready) {
            w_state := s_wait_host_ready
        }
    }
}



// for test

class AXI4LiteSlaveTestModule extends Module {
    val addr_width = 4
    val data_width = 4

    val io = new Bundle {
        val axi4_lite_slave = new AXI4LiteSlaveIO (addr_width, data_width)
    }

    // default value
    
    io.axi4_lite_slave.write_address.ready := false.B
    io.axi4_lite_slave.write_data.ready := false.B
    io.axi4_lite_slave.write_response.valid := false.B
    io.axi4_lite_slave.write_response.resp := 0.U(2.W)
    io.axi4_lite_slave.read_addr.ready := false.B
    io.axi4_lite_slave.read_data.valid := false.B
    io.axi4_lite_slave.read_data.data := 0.U(data_width.W)
    io.axi4_lite_slave.read_data.resp := 0.U(2.W)

    val s_wait_write_addr :: s_wait_write_data :: s_wait_read_write_response :: Nil = Enum(3)
    val w_state = RegInit (s_wait_write_addr)

    val write_addr = RegInit (0.U (addr_width.W))
    val write_data = RegInit (0.U (data_width.W))
    
    // write value
    when (w_state === s_wait_write_addr) {
        io.axi4_lite_slave.write_address.ready := true.B

        when (io.axi4_lite_slave.write_address.valid) {
            write_addr := io.axi4_lite_slave.write_address.addr
            w_state := s_wait_write_data
        }
    } .elsewhen (w_state === s_wait_write_data) {
        io.axi4_lite_slave.write_data.ready := true.B
        
        when (io.axi4_lite_slave.write_data.valid) {
            write_data := io.axi4_lite_slave.write_data.data
            w_state := s_wait_read_write_response
        }
    }
    

    // read value
    val s_wait_read_addr :: s_wait_read_data :: Nil = Enum (2)
    val r_state = RegInit (s_wait_read_addr)

    val read_addr = RegInit (0.U(addr_width.W))
    val read_data = 0.U(data_width.W)

    read_data := write_data

    when (r_state === s_wait_read_addr) {
        io.axi4_lite_slave.read_addr.ready := true.B

        when (io.axi4_lite_slave.read_addr.valid) {
            read_addr := io.axi4_lite_slave.read_addr.addr
            r_state := s_wait_read_data
        }
    } .elsewhen (r_state === s_wait_read_data) {
        io.axi4_lite_slave.read_data.data := read_data
        io.axi4_lite_slave.read_data.valid := true.B
        
        // response OK
        io.axi4_lite_slave.read_data.resp := 0.U(2.W)

        when (io.axi4_lite_slave.read_data.ready) {
            r_state := s_wait_read_addr
        }
    }
}


class LiteSlaveTest extends Module {
    val addr_width = 4
    val data_width = 32

    val io = new Bundle {
        val LEDG = Output (UInt (4.W))
        val slave = new AXI4LiteSlaveIO (addr_width, data_width)
    }

    val slave = Module (new AXI4LiteSlave (addr_width, data_width))

    val slave_data_valid = Bool ()
    val slave_data_data = RegInit (UInt(data_width.W))
    val slave_data_ready = false.B

    slave_data_valid := slave.io.host_data.valid
    slave.io.host_data.ready := false.B
    io.slave <> slave.io.slave

    when (slave.io.host_data.valid) {
        slave_data_data := slave.io.host_data.data
        slave.io.host_data.ready := true.B
    }

    io.LEDG := slave_data_data
}

