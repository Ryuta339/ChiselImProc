;buildInfoPackage: chisel3, version: 3.3.1, scalaVersion: 2.12.11, sbtVersion: 1.3.10
circuit RVCounter : 
  module RVCounter : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip ready : UInt<1>, flip valid : UInt<1>, flip user : UInt<1>, flip last : UInt<1>, xoutput : UInt<16>, youtput : UInt<16>}
    
    reg xcnt : UInt<16>, clock with : (reset => (reset, UInt<16>("h00"))) @[RVCounter.scala 16:24]
    reg ycnt : UInt<16>, clock with : (reset => (reset, UInt<16>("h00"))) @[RVCounter.scala 17:24]
    when io.user : @[RVCounter.scala 19:20]
      xcnt <= UInt<1>("h01") @[RVCounter.scala 20:14]
      ycnt <= UInt<1>("h00") @[RVCounter.scala 21:14]
      skip @[RVCounter.scala 19:20]
    else : @[RVCounter.scala 22:39]
      node _T = and(io.ready, io.valid) @[RVCounter.scala 22:26]
      when _T : @[RVCounter.scala 22:39]
        when io.last : @[RVCounter.scala 23:24]
          xcnt <= UInt<1>("h00") @[RVCounter.scala 24:18]
          node _T_1 = add(ycnt, UInt<1>("h01")) @[RVCounter.scala 25:26]
          node _T_2 = tail(_T_1, 1) @[RVCounter.scala 25:26]
          ycnt <= _T_2 @[RVCounter.scala 25:18]
          skip @[RVCounter.scala 23:24]
        else : @[RVCounter.scala 26:22]
          node _T_3 = add(xcnt, UInt<1>("h01")) @[RVCounter.scala 27:26]
          node _T_4 = tail(_T_3, 1) @[RVCounter.scala 27:26]
          xcnt <= _T_4 @[RVCounter.scala 27:18]
          skip @[RVCounter.scala 26:22]
        skip @[RVCounter.scala 22:39]
    io.xoutput <= xcnt @[RVCounter.scala 31:16]
    io.youtput <= ycnt @[RVCounter.scala 32:16]
    
