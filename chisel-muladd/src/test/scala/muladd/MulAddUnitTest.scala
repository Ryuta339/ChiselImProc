package muladd

import java.io.File
import java.util.Random
import chisel3._
import chisel3.iotesters
import chisel3.iotesters.{ChiselFlatSpec, Driver, PeekPokeTester}

class MulAddUnitTester[T <: Data] (gen: T, c: MulAdd[T]) extends PeekPokeTester(c) {
    /**
     * compute the cumulative sum
     * 
     * @param a UInt array
     * @param b UInt array
     * @return the cumulative sum
     **/
    def computeMulAdd (a: Array[Int], b: Array[Int]): Int = {
        var tmp = 0
        for (i <- 0 until a.length) {
            tmp += a(i) * b(i)
        }
        tmp
    }

    private var a, b = new Array[Int](16)
    private val ma = c
    private val rand = new Random()
    for (i <- 0 until a.length) {
        a(i) = rand.nextInt () & 0xffff
        b(i) = rand.nextInt () & 0xffff
        poke (ma.io.a(i), a(i))
        poke (ma.io.b(i), b(i))
    }

    val expected = computeMulAdd(a, b)
    val result = ma.io.output
    expect (ma.io.output, expected)

}

class MulAddTester extends ChiselFlatSpec {
    private val backendNames = if (firrtl.FileUtils.isCommandAvailable(Seq("verilator", "--version"))) {
        Array("firrtl", "verilator")
    }
    else {
        Array("firrtl")
    }
    for ( backendName <- backendNames) {
        "MulAdd" should s"calculate cumulative sum" in {
            Driver(() => new MulAdd(SInt(32.W), 16), backendName) {
                c => new MulAddUnitTester(SInt(32.W), c)
            } should be (true)
        }
    }

    "Basic test using Driver.execute" should  "be used as an alternative way to run specification" in {
        iotesters.Driver.execute (Array(), () => new MulAdd(SInt(32.W), 16)) {
            c => new MulAddUnitTester (SInt(32.W), c)
        } should be (true)
    }

    if (backendNames.contains ("verilator")) {
        "using --backend-name verilator" should "be an alternative way to run using verilator" in {
            iotesters.Driver.execute (Array("--backend-name", "verilator"), () => new MulAdd(SInt(32.W), 16)) {
                c => new MulAddUnitTester(SInt(32.W), c)
            } should be(true)
        }
    }

    "running with --is-verbose" should "show more about what's going on in your tester" in {
        iotesters.Driver.execute(Array("--is-verbose"), () => new MulAdd(SInt(32.W), 16)) {
            c => new MulAddUnitTester(SInt(32.W), c)
        } should be (true)
    }

    /**
     * By default validator backend produces vcd files, and firrtl and treadle backends do not.
     * Following examples show you how to turn on vcd for firrtl and treadle and how to turn it off for verilator
     **/
    "runnung with --generate-vcd-output on" should "create a vcd file from your test" in {
        iotesters.Driver.execute (
            Array("--generate-vcd-output", "on", "--target-dir", "test_run_dir/make_a_vcd", "--top-name", "make_a_vcd"),
            () => new MulAdd(SInt(32.W), 16)
        ) {
            c => new MulAddUnitTester(SInt(32.W), c)
        } should be (true)

        new File ("test_run_dir/make_a_vcd/MulAdd.vcd").exists should be (true)
    }

    "running with --generate-vcd-output off" should "not create a vcd file from your test" in {
        iotesters.Driver.execute(
            Array("--generate-vcd-output", "off", "--target-dir", "test_run_dir/make_no_vcd", "--top-name", "make_no_vcd",
            "--backend-name", "verilator"),
            () => new MulAdd(SInt(32.W), 16)
        ) {
            c => new MulAddUnitTester(SInt(32.W), c)
        } should be (true)
        
        new File("test_run_dir/make_no_vcd/make_a_vcd.vcd").exists should be (false)
    }
}