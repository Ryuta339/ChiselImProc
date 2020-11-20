;buildInfoPackage: chisel3, version: 3.3.1, scalaVersion: 2.12.11, sbtVersion: 1.3.10
circuit RVCounter : 
  module RVCounter : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip ready : UInt<1>, flip valid : UInt<1>, flip user : UInt<1>, output : UInt<12>}
    
    reg cnt : UInt<12>, clock with : (reset => (reset, UInt<12>("h00"))) @[RVCounter.scala 14:23]
    node _T = and(io.ready, io.valid) @[RVCounter.scala 16:20]
    when _T : @[RVCounter.scala 16:33]
      when io.user : @[RVCounter.scala 17:24]
        cnt <= UInt<1>("h01") @[RVCounter.scala 18:17]
        skip @[RVCounter.scala 17:24]
      else : @[RVCounter.scala 19:21]
        node _T_1 = add(cnt, UInt<1>("h01")) @[RVCounter.scala 20:24]
        node _T_2 = tail(_T_1, 1) @[RVCounter.scala 20:24]
        cnt <= _T_2 @[RVCounter.scala 20:17]
        skip @[RVCounter.scala 19:21]
      skip @[RVCounter.scala 16:33]
    io.output <= cnt @[RVCounter.scala 24:15]
    
