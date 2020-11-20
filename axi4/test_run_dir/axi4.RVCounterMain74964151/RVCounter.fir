;buildInfoPackage: chisel3, version: 3.3.1, scalaVersion: 2.12.11, sbtVersion: 1.3.10
circuit RVCounter : 
  module RVCounter : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip ready : UInt<1>, flip valid : UInt<1>, flip user : UInt<1>, flip last : UInt<1>, xoutput : UInt<12>, youtput : UInt<12>}
    
    reg xcnt : UInt<12>, clock with : (reset => (reset, UInt<12>("h00"))) @[RVCounter.scala 16:24]
    reg ycnt : UInt<12>, clock with : (reset => (reset, UInt<12>("h00"))) @[RVCounter.scala 17:24]
    node _T = and(io.ready, io.valid) @[RVCounter.scala 19:20]
    when _T : @[RVCounter.scala 19:33]
      when io.user : @[RVCounter.scala 20:24]
        xcnt <= UInt<1>("h01") @[RVCounter.scala 21:18]
        skip @[RVCounter.scala 20:24]
      else : @[RVCounter.scala 22:30]
        when io.last : @[RVCounter.scala 22:30]
          xcnt <= UInt<1>("h00") @[RVCounter.scala 23:18]
          node _T_1 = add(ycnt, UInt<1>("h01")) @[RVCounter.scala 24:26]
          node _T_2 = tail(_T_1, 1) @[RVCounter.scala 24:26]
          ycnt <= _T_2 @[RVCounter.scala 24:18]
          skip @[RVCounter.scala 22:30]
        else : @[RVCounter.scala 25:22]
          node _T_3 = add(xcnt, UInt<1>("h01")) @[RVCounter.scala 26:26]
          node _T_4 = tail(_T_3, 1) @[RVCounter.scala 26:26]
          xcnt <= _T_4 @[RVCounter.scala 26:18]
          skip @[RVCounter.scala 25:22]
      skip @[RVCounter.scala 19:33]
    io.xoutput <= xcnt @[RVCounter.scala 30:16]
    io.youtput <= ycnt @[RVCounter.scala 31:16]
    
