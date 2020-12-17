package improc

import java.io.File
import chisel3._
import chisel3.util._
import chisel3.iotesters
import chisel3.iotesters.{ChiselFlatSpec, Driver, PeekPokeTester}

class AXI4LiteSlaveUnitTester (c: AXI4LiteSlave) extends PeekPokeTester(c) {

    private val s = c

    reset (10)

    // write address
    poke (s.io.slave.write_address.valid, true)
    poke (s.io.slave.write_address.addr, 0x00000000)

    Thread.sleep (100)
    //println (s.w_state)
    poke (s.io.slave.write_address.valid, false)

    poke (s.io.slave.write_data.valid, true)
    poke (s.io.slave.write_data.data, 0xF)

    Thread.sleep (100)
    poke (s.io.slave.write_data.valid, false)

    poke (s.io.slave.write_response.ready, true)
    /*
    expect (s.io.slave.write_response.resp, 0)
    expect (s.io.slave.write_response.valid, true)
    */
}

class AXI4LiteSlaveTester extends ChiselFlatSpec {
    private val addr_width = 4
    private val data_width = 32

    private val backendNames = if (firrtl.FileUtils.isCommandAvailable(Seq("verilator", "--version"))) {
        Array("firrtl", "verilator")
    }
    else {
        Array("firrtl")
    }
    for ( backendName <- backendNames) {
        "AXI4LiteSlave" should s"calculate cumulative sum" in {
            Driver(() => new AXI4LiteSlave (addr_width, data_width), backendName) {
                c => new AXI4LiteSlaveUnitTester(c)
            } should be (true)
        }
    }

    "Basic test using Driver.execute" should  "be used as an alternative way to run specification" in {
        iotesters.Driver.execute (Array(), () => new AXI4LiteSlave(addr_width, data_width)) {
            c => new AXI4LiteSlaveUnitTester (c)
        } should be (true)
    }

    if (backendNames.contains ("verilator")) {
        "using --backend-name verilator" should "be an alternative way to run using verilator" in {
            iotesters.Driver.execute (Array("--backend-name", "verilator"), () => new AXI4LiteSlave (addr_width, data_width)) {
                c => new AXI4LiteSlaveUnitTester(c)
            } should be(true)
        }
    }

    "running with --is-verbose" should "show more about what's going on in your tester" in {
        iotesters.Driver.execute(Array("--is-verbose"), () => new AXI4LiteSlave (addr_width, data_width)) {
            c => new AXI4LiteSlaveUnitTester(c)
        } should be (true)
    }

    /**
     * By default validator backend produces vcd files, and firrtl and treadle backends do not.
     * Following examples show you how to turn on vcd for firrtl and treadle and how to turn it off for verilator
     **/
    "runnung with --generate-vcd-output on" should "create a vcd file from your test" in {
        iotesters.Driver.execute (
            Array("--generate-vcd-output", "on", "--target-dir", "test_run_dir/make_a_vcd", "--top-name", "make_a_vcd"),
            () => new AXI4LiteSlave (addr_width, data_width),
            //() => new AXI4LiteSlaveTestModule (),
            //() => new LiteSlaveTest()
        ) {
            c => new AXI4LiteSlaveUnitTester(c)
        } should be (true)

        new File ("test_run_dir/make_a_vcd/AXI4LiteSlave.vcd").exists should be (true)
    }

    "running with --generate-vcd-output off" should "not create a vcd file from your test" in {
        iotesters.Driver.execute(
            Array("--generate-vcd-output", "off", "--target-dir", "test_run_dir/make_no_vcd", "--top-name", "make_no_vcd",
            "--backend-name", "verilator"),
            () => new AXI4LiteSlave (addr_width, data_width)
        ) {
            c => new AXI4LiteSlaveUnitTester(c)
        } should be (true)
        
        new File("test_run_dir/make_no_vcd/make_a_vcd.vcd").exists should be (false)
    }
}