// axi4.ImProcMain1218694666
// 2020/11/25 17:25

module RGB2GrayFilterGray(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [23:0] io_enq_bits,
  input         io_enq_user,
  input         io_enq_last,
  input         io_deq_ready,
  output        io_deq_valid,
  output [23:0] io_deq_bits,
  output        io_deq_user,
  output        io_deq_last
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] stateReg; // @[ChiselImProc.scala 49:28]
  reg [23:0] dataReg; // @[ChiselImProc.scala 51:23]
  reg [23:0] shadowReg; // @[ChiselImProc.scala 53:25]
  reg  userReg; // @[ChiselImProc.scala 54:23]
  reg  shadowUserReg; // @[ChiselImProc.scala 55:29]
  reg  lastReg; // @[ChiselImProc.scala 56:23]
  reg  shadowLastReg; // @[ChiselImProc.scala 57:29]
  wire  _T = 2'h0 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_1 = 2'h1 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_2 = ~io_enq_valid; // @[ChiselImProc.scala 69:35]
  wire  _T_3 = io_deq_ready & _T_2; // @[ChiselImProc.scala 69:32]
  wire  _T_4 = io_deq_ready & io_enq_valid; // @[ChiselImProc.scala 72:38]
  wire  _T_5 = ~io_deq_ready; // @[ChiselImProc.scala 77:25]
  wire  _T_6 = _T_5 & io_enq_valid; // @[ChiselImProc.scala 77:39]
  wire  _T_7 = 2'h2 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_8 = 2'h3 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_9 = stateReg == 2'h0; // @[ChiselImProc.scala 101:31]
  wire  _T_10 = stateReg == 2'h1; // @[ChiselImProc.scala 101:53]
  wire  _T_11 = _T_9 | _T_10; // @[ChiselImProc.scala 101:41]
  wire  _T_12 = stateReg == 2'h3; // @[ChiselImProc.scala 101:73]
  wire  _T_15 = stateReg == 2'h2; // @[ChiselImProc.scala 102:51]
  wire [23:0] _T_17 = dataReg & 24'hff; // @[ChiselImProc.scala 139:36]
  wire [37:0] _T_18 = 24'h24dd * _T_17; // @[ChiselImProc.scala 139:25]
  wire [23:0] _T_19 = dataReg & 24'hff00; // @[ChiselImProc.scala 140:33]
  wire [23:0] _T_20 = {{8'd0}, _T_19[23:8]}; // @[ChiselImProc.scala 140:47]
  wire [39:0] _T_21 = 24'h9645 * _T_20; // @[ChiselImProc.scala 140:21]
  wire [39:0] _GEN_45 = {{2'd0}, _T_18}; // @[ChiselImProc.scala 139:50]
  wire [39:0] _T_23 = _GEN_45 + _T_21; // @[ChiselImProc.scala 139:50]
  wire [23:0] _T_24 = dataReg & 24'hff0000; // @[ChiselImProc.scala 141:33]
  wire [23:0] _T_25 = {{16'd0}, _T_24[23:16]}; // @[ChiselImProc.scala 141:47]
  wire [38:0] _T_26 = 24'h4c8b * _T_25; // @[ChiselImProc.scala 141:21]
  wire [39:0] _GEN_47 = {{1'd0}, _T_26}; // @[ChiselImProc.scala 140:55]
  wire [39:0] _T_28 = _T_23 + _GEN_47; // @[ChiselImProc.scala 140:55]
  wire [31:0] pixGray = _T_28[31:0]; // @[ChiselImProc.scala 136:24 ChiselImProc.scala 139:13]
  wire [31:0] _T_29 = {{16'd0}, pixGray[31:16]}; // @[ChiselImProc.scala 143:24]
  wire [15:0] rolled = _T_29[15:0]; // @[ChiselImProc.scala 137:23 ChiselImProc.scala 143:12]
  wire  _T_30 = rolled > 16'hff; // @[ChiselImProc.scala 144:32]
  wire [15:0] _T_31 = _T_30 ? 16'hff : rolled; // @[ChiselImProc.scala 144:24]
  assign io_enq_ready = _T_11 | _T_12; // @[ChiselImProc.scala 101:18]
  assign io_deq_valid = _T_10 | _T_15; // @[ChiselImProc.scala 102:18]
  assign io_deq_bits = {{8'd0}, _T_31}; // @[ChiselImProc.scala 144:17]
  assign io_deq_user = userReg; // @[ChiselImProc.scala 37:17 ChiselImProc.scala 99:17]
  assign io_deq_last = lastReg; // @[ChiselImProc.scala 36:17 ChiselImProc.scala 98:17]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  stateReg = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  dataReg = _RAND_1[23:0];
  _RAND_2 = {1{`RANDOM}};
  shadowReg = _RAND_2[23:0];
  _RAND_3 = {1{`RANDOM}};
  userReg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  shadowUserReg = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  lastReg = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  shadowLastReg = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      stateReg <= 2'h0;
    end else if (_T) begin
      if (io_enq_valid) begin
        stateReg <= 2'h1;
      end
    end else if (_T_1) begin
      if (_T_3) begin
        stateReg <= 2'h0;
      end else if (_T_4) begin
        stateReg <= 2'h1;
      end else if (_T_6) begin
        stateReg <= 2'h2;
      end
    end else if (_T_7) begin
      if (io_deq_ready) begin
        stateReg <= 2'h1;
      end
    end else if (_T_8) begin
      stateReg <= 2'h0;
    end
    if (_T) begin
      if (io_enq_valid) begin
        dataReg <= io_enq_bits;
      end
    end else if (_T_1) begin
      if (!(_T_3)) begin
        if (_T_4) begin
          dataReg <= io_enq_bits;
        end
      end
    end else if (_T_7) begin
      if (io_deq_ready) begin
        dataReg <= shadowReg;
      end
    end
    if (!(_T)) begin
      if (_T_1) begin
        if (!(_T_3)) begin
          if (!(_T_4)) begin
            if (_T_6) begin
              shadowReg <= io_enq_bits;
            end
          end
        end
      end
    end
    if (_T) begin
      userReg <= io_enq_user;
    end else if (_T_1) begin
      if (_T_3) begin
        userReg <= io_enq_user;
      end else if (_T_4) begin
        userReg <= io_enq_user;
      end
    end else if (_T_7) begin
      if (io_deq_ready) begin
        userReg <= shadowUserReg;
      end
    end
    if (!(_T)) begin
      if (_T_1) begin
        if (!(_T_3)) begin
          if (!(_T_4)) begin
            if (_T_6) begin
              shadowUserReg <= io_enq_user;
            end
          end
        end
      end
    end
    if (_T) begin
      if (io_enq_valid) begin
        lastReg <= io_enq_last;
      end
    end else if (_T_1) begin
      if (!(_T_3)) begin
        if (_T_4) begin
          lastReg <= io_enq_last;
        end
      end
    end else if (_T_7) begin
      if (io_deq_ready) begin
        lastReg <= shadowLastReg;
      end
    end
    if (!(_T)) begin
      if (_T_1) begin
        if (!(_T_3)) begin
          if (!(_T_4)) begin
            if (_T_6) begin
              shadowLastReg <= io_enq_last;
            end
          end
        end
      end
    end
  end
endmodule
module NothingFilterGray(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_enq_user,
  input        io_enq_last,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits,
  output       io_deq_user,
  output       io_deq_last
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] stateReg; // @[ChiselImProc.scala 49:28]
  reg [7:0] dataReg; // @[ChiselImProc.scala 51:23]
  reg [7:0] shadowReg; // @[ChiselImProc.scala 53:25]
  reg  userReg; // @[ChiselImProc.scala 54:23]
  reg  shadowUserReg; // @[ChiselImProc.scala 55:29]
  reg  lastReg; // @[ChiselImProc.scala 56:23]
  reg  shadowLastReg; // @[ChiselImProc.scala 57:29]
  wire  _T = 2'h0 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_1 = 2'h1 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_2 = ~io_enq_valid; // @[ChiselImProc.scala 69:35]
  wire  _T_3 = io_deq_ready & _T_2; // @[ChiselImProc.scala 69:32]
  wire  _T_4 = io_deq_ready & io_enq_valid; // @[ChiselImProc.scala 72:38]
  wire  _T_5 = ~io_deq_ready; // @[ChiselImProc.scala 77:25]
  wire  _T_6 = _T_5 & io_enq_valid; // @[ChiselImProc.scala 77:39]
  wire  _T_7 = 2'h2 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_8 = 2'h3 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_9 = stateReg == 2'h0; // @[ChiselImProc.scala 101:31]
  wire  _T_10 = stateReg == 2'h1; // @[ChiselImProc.scala 101:53]
  wire  _T_11 = _T_9 | _T_10; // @[ChiselImProc.scala 101:41]
  wire  _T_12 = stateReg == 2'h3; // @[ChiselImProc.scala 101:73]
  wire  _T_15 = stateReg == 2'h2; // @[ChiselImProc.scala 102:51]
  assign io_enq_ready = _T_11 | _T_12; // @[ChiselImProc.scala 101:18]
  assign io_deq_valid = _T_10 | _T_15; // @[ChiselImProc.scala 102:18]
  assign io_deq_bits = dataReg; // @[ChiselImProc.scala 122:17]
  assign io_deq_user = userReg; // @[ChiselImProc.scala 37:17 ChiselImProc.scala 99:17]
  assign io_deq_last = lastReg; // @[ChiselImProc.scala 36:17 ChiselImProc.scala 98:17]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  stateReg = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  dataReg = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  shadowReg = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  userReg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  shadowUserReg = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  lastReg = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  shadowLastReg = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      stateReg <= 2'h0;
    end else if (_T) begin
      if (io_enq_valid) begin
        stateReg <= 2'h1;
      end
    end else if (_T_1) begin
      if (_T_3) begin
        stateReg <= 2'h0;
      end else if (_T_4) begin
        stateReg <= 2'h1;
      end else if (_T_6) begin
        stateReg <= 2'h2;
      end
    end else if (_T_7) begin
      if (io_deq_ready) begin
        stateReg <= 2'h1;
      end
    end else if (_T_8) begin
      stateReg <= 2'h0;
    end
    if (_T) begin
      if (io_enq_valid) begin
        dataReg <= io_enq_bits;
      end
    end else if (_T_1) begin
      if (!(_T_3)) begin
        if (_T_4) begin
          dataReg <= io_enq_bits;
        end
      end
    end else if (_T_7) begin
      if (io_deq_ready) begin
        dataReg <= shadowReg;
      end
    end
    if (!(_T)) begin
      if (_T_1) begin
        if (!(_T_3)) begin
          if (!(_T_4)) begin
            if (_T_6) begin
              shadowReg <= io_enq_bits;
            end
          end
        end
      end
    end
    if (_T) begin
      userReg <= io_enq_user;
    end else if (_T_1) begin
      if (_T_3) begin
        userReg <= io_enq_user;
      end else if (_T_4) begin
        userReg <= io_enq_user;
      end
    end else if (_T_7) begin
      if (io_deq_ready) begin
        userReg <= shadowUserReg;
      end
    end
    if (!(_T)) begin
      if (_T_1) begin
        if (!(_T_3)) begin
          if (!(_T_4)) begin
            if (_T_6) begin
              shadowUserReg <= io_enq_user;
            end
          end
        end
      end
    end
    if (_T) begin
      if (io_enq_valid) begin
        lastReg <= io_enq_last;
      end
    end else if (_T_1) begin
      if (!(_T_3)) begin
        if (_T_4) begin
          lastReg <= io_enq_last;
        end
      end
    end else if (_T_7) begin
      if (io_deq_ready) begin
        lastReg <= shadowLastReg;
      end
    end
    if (!(_T)) begin
      if (_T_1) begin
        if (!(_T_3)) begin
          if (!(_T_4)) begin
            if (_T_6) begin
              shadowLastReg <= io_enq_last;
            end
          end
        end
      end
    end
  end
endmodule
module Gray2RGBFilterGray(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [23:0] io_enq_bits,
  input         io_enq_user,
  input         io_enq_last,
  input         io_deq_ready,
  output        io_deq_valid,
  output [23:0] io_deq_bits,
  output        io_deq_user,
  output        io_deq_last,
  output [1:0]  io_state_reg,
  output [23:0] io_shadow_reg,
  output        io_shadow_user,
  output        io_shadow_last
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] stateReg; // @[ChiselImProc.scala 49:28]
  reg [23:0] dataReg; // @[ChiselImProc.scala 51:23]
  reg [23:0] shadowReg; // @[ChiselImProc.scala 53:25]
  reg  userReg; // @[ChiselImProc.scala 54:23]
  reg  shadowUserReg; // @[ChiselImProc.scala 55:29]
  reg  lastReg; // @[ChiselImProc.scala 56:23]
  reg  shadowLastReg; // @[ChiselImProc.scala 57:29]
  wire  _T = 2'h0 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_1 = 2'h1 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_2 = ~io_enq_valid; // @[ChiselImProc.scala 69:35]
  wire  _T_3 = io_deq_ready & _T_2; // @[ChiselImProc.scala 69:32]
  wire  _T_4 = io_deq_ready & io_enq_valid; // @[ChiselImProc.scala 72:38]
  wire  _T_5 = ~io_deq_ready; // @[ChiselImProc.scala 77:25]
  wire  _T_6 = _T_5 & io_enq_valid; // @[ChiselImProc.scala 77:39]
  wire  _T_7 = 2'h2 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_8 = 2'h3 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_9 = stateReg == 2'h0; // @[ChiselImProc.scala 101:31]
  wire  _T_10 = stateReg == 2'h1; // @[ChiselImProc.scala 101:53]
  wire  _T_11 = _T_9 | _T_10; // @[ChiselImProc.scala 101:41]
  wire  _T_12 = stateReg == 2'h3; // @[ChiselImProc.scala 101:73]
  wire  _T_15 = stateReg == 2'h2; // @[ChiselImProc.scala 102:51]
  wire [39:0] _GEN_44 = {dataReg, 16'h0}; // @[ChiselImProc.scala 150:28]
  wire [54:0] _T_17 = {{15'd0}, _GEN_44}; // @[ChiselImProc.scala 150:28]
  wire [31:0] _GEN_45 = {dataReg, 8'h0}; // @[ChiselImProc.scala 150:46]
  wire [38:0] _T_18 = {{7'd0}, _GEN_45}; // @[ChiselImProc.scala 150:46]
  wire [54:0] _GEN_46 = {{16'd0}, _T_18}; // @[ChiselImProc.scala 150:36]
  wire [54:0] _T_19 = _T_17 | _GEN_46; // @[ChiselImProc.scala 150:36]
  wire [54:0] _GEN_47 = {{31'd0}, dataReg}; // @[ChiselImProc.scala 150:53]
  wire [54:0] _T_20 = _T_19 | _GEN_47; // @[ChiselImProc.scala 150:53]
  assign io_enq_ready = _T_11 | _T_12; // @[ChiselImProc.scala 101:18]
  assign io_deq_valid = _T_10 | _T_15; // @[ChiselImProc.scala 102:18]
  assign io_deq_bits = _T_20[23:0]; // @[ChiselImProc.scala 150:17]
  assign io_deq_user = userReg; // @[ChiselImProc.scala 37:17 ChiselImProc.scala 99:17]
  assign io_deq_last = lastReg; // @[ChiselImProc.scala 36:17 ChiselImProc.scala 98:17]
  assign io_state_reg = stateReg; // @[ChiselImProc.scala 104:18]
  assign io_shadow_reg = shadowReg; // @[ChiselImProc.scala 105:19]
  assign io_shadow_user = shadowUserReg; // @[ChiselImProc.scala 106:20]
  assign io_shadow_last = shadowLastReg; // @[ChiselImProc.scala 107:20]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  stateReg = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  dataReg = _RAND_1[23:0];
  _RAND_2 = {1{`RANDOM}};
  shadowReg = _RAND_2[23:0];
  _RAND_3 = {1{`RANDOM}};
  userReg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  shadowUserReg = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  lastReg = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  shadowLastReg = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      stateReg <= 2'h0;
    end else if (_T) begin
      if (io_enq_valid) begin
        stateReg <= 2'h1;
      end
    end else if (_T_1) begin
      if (_T_3) begin
        stateReg <= 2'h0;
      end else if (_T_4) begin
        stateReg <= 2'h1;
      end else if (_T_6) begin
        stateReg <= 2'h2;
      end
    end else if (_T_7) begin
      if (io_deq_ready) begin
        stateReg <= 2'h1;
      end
    end else if (_T_8) begin
      stateReg <= 2'h0;
    end
    if (_T) begin
      if (io_enq_valid) begin
        dataReg <= io_enq_bits;
      end
    end else if (_T_1) begin
      if (!(_T_3)) begin
        if (_T_4) begin
          dataReg <= io_enq_bits;
        end
      end
    end else if (_T_7) begin
      if (io_deq_ready) begin
        dataReg <= shadowReg;
      end
    end
    if (!(_T)) begin
      if (_T_1) begin
        if (!(_T_3)) begin
          if (!(_T_4)) begin
            if (_T_6) begin
              shadowReg <= io_enq_bits;
            end
          end
        end
      end
    end
    if (_T) begin
      userReg <= io_enq_user;
    end else if (_T_1) begin
      if (_T_3) begin
        userReg <= io_enq_user;
      end else if (_T_4) begin
        userReg <= io_enq_user;
      end
    end else if (_T_7) begin
      if (io_deq_ready) begin
        userReg <= shadowUserReg;
      end
    end
    if (!(_T)) begin
      if (_T_1) begin
        if (!(_T_3)) begin
          if (!(_T_4)) begin
            if (_T_6) begin
              shadowUserReg <= io_enq_user;
            end
          end
        end
      end
    end
    if (_T) begin
      if (io_enq_valid) begin
        lastReg <= io_enq_last;
      end
    end else if (_T_1) begin
      if (!(_T_3)) begin
        if (_T_4) begin
          lastReg <= io_enq_last;
        end
      end
    end else if (_T_7) begin
      if (io_deq_ready) begin
        lastReg <= shadowLastReg;
      end
    end
    if (!(_T)) begin
      if (_T_1) begin
        if (!(_T_3)) begin
          if (!(_T_4)) begin
            if (_T_6) begin
              shadowLastReg <= io_enq_last;
            end
          end
        end
      end
    end
  end
endmodule
module ChiselImProcGrayFilter(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [23:0] io_enq_bits,
  input         io_enq_user,
  input         io_enq_last,
  input         io_deq_ready,
  output        io_deq_valid,
  output [23:0] io_deq_bits,
  output        io_deq_user,
  output        io_deq_last,
  output [1:0]  io_state_reg,
  output [23:0] io_shadow_reg,
  output        io_shadow_user,
  output        io_shadow_last
);
  wire  RGB2GrayFilterGray_clock; // @[ChiselImProc.scala 261:16]
  wire  RGB2GrayFilterGray_reset; // @[ChiselImProc.scala 261:16]
  wire  RGB2GrayFilterGray_io_enq_ready; // @[ChiselImProc.scala 261:16]
  wire  RGB2GrayFilterGray_io_enq_valid; // @[ChiselImProc.scala 261:16]
  wire [23:0] RGB2GrayFilterGray_io_enq_bits; // @[ChiselImProc.scala 261:16]
  wire  RGB2GrayFilterGray_io_enq_user; // @[ChiselImProc.scala 261:16]
  wire  RGB2GrayFilterGray_io_enq_last; // @[ChiselImProc.scala 261:16]
  wire  RGB2GrayFilterGray_io_deq_ready; // @[ChiselImProc.scala 261:16]
  wire  RGB2GrayFilterGray_io_deq_valid; // @[ChiselImProc.scala 261:16]
  wire [23:0] RGB2GrayFilterGray_io_deq_bits; // @[ChiselImProc.scala 261:16]
  wire  RGB2GrayFilterGray_io_deq_user; // @[ChiselImProc.scala 261:16]
  wire  RGB2GrayFilterGray_io_deq_last; // @[ChiselImProc.scala 261:16]
  wire  NothingFilterGray_clock; // @[ChiselImProc.scala 264:16]
  wire  NothingFilterGray_reset; // @[ChiselImProc.scala 264:16]
  wire  NothingFilterGray_io_enq_ready; // @[ChiselImProc.scala 264:16]
  wire  NothingFilterGray_io_enq_valid; // @[ChiselImProc.scala 264:16]
  wire [7:0] NothingFilterGray_io_enq_bits; // @[ChiselImProc.scala 264:16]
  wire  NothingFilterGray_io_enq_user; // @[ChiselImProc.scala 264:16]
  wire  NothingFilterGray_io_enq_last; // @[ChiselImProc.scala 264:16]
  wire  NothingFilterGray_io_deq_ready; // @[ChiselImProc.scala 264:16]
  wire  NothingFilterGray_io_deq_valid; // @[ChiselImProc.scala 264:16]
  wire [7:0] NothingFilterGray_io_deq_bits; // @[ChiselImProc.scala 264:16]
  wire  NothingFilterGray_io_deq_user; // @[ChiselImProc.scala 264:16]
  wire  NothingFilterGray_io_deq_last; // @[ChiselImProc.scala 264:16]
  wire  NothingFilterGray_1_clock; // @[ChiselImProc.scala 266:16]
  wire  NothingFilterGray_1_reset; // @[ChiselImProc.scala 266:16]
  wire  NothingFilterGray_1_io_enq_ready; // @[ChiselImProc.scala 266:16]
  wire  NothingFilterGray_1_io_enq_valid; // @[ChiselImProc.scala 266:16]
  wire [7:0] NothingFilterGray_1_io_enq_bits; // @[ChiselImProc.scala 266:16]
  wire  NothingFilterGray_1_io_enq_user; // @[ChiselImProc.scala 266:16]
  wire  NothingFilterGray_1_io_enq_last; // @[ChiselImProc.scala 266:16]
  wire  NothingFilterGray_1_io_deq_ready; // @[ChiselImProc.scala 266:16]
  wire  NothingFilterGray_1_io_deq_valid; // @[ChiselImProc.scala 266:16]
  wire [7:0] NothingFilterGray_1_io_deq_bits; // @[ChiselImProc.scala 266:16]
  wire  NothingFilterGray_1_io_deq_user; // @[ChiselImProc.scala 266:16]
  wire  NothingFilterGray_1_io_deq_last; // @[ChiselImProc.scala 266:16]
  wire  NothingFilterGray_2_clock; // @[ChiselImProc.scala 268:16]
  wire  NothingFilterGray_2_reset; // @[ChiselImProc.scala 268:16]
  wire  NothingFilterGray_2_io_enq_ready; // @[ChiselImProc.scala 268:16]
  wire  NothingFilterGray_2_io_enq_valid; // @[ChiselImProc.scala 268:16]
  wire [7:0] NothingFilterGray_2_io_enq_bits; // @[ChiselImProc.scala 268:16]
  wire  NothingFilterGray_2_io_enq_user; // @[ChiselImProc.scala 268:16]
  wire  NothingFilterGray_2_io_enq_last; // @[ChiselImProc.scala 268:16]
  wire  NothingFilterGray_2_io_deq_ready; // @[ChiselImProc.scala 268:16]
  wire  NothingFilterGray_2_io_deq_valid; // @[ChiselImProc.scala 268:16]
  wire [7:0] NothingFilterGray_2_io_deq_bits; // @[ChiselImProc.scala 268:16]
  wire  NothingFilterGray_2_io_deq_user; // @[ChiselImProc.scala 268:16]
  wire  NothingFilterGray_2_io_deq_last; // @[ChiselImProc.scala 268:16]
  wire  NothingFilterGray_3_clock; // @[ChiselImProc.scala 270:16]
  wire  NothingFilterGray_3_reset; // @[ChiselImProc.scala 270:16]
  wire  NothingFilterGray_3_io_enq_ready; // @[ChiselImProc.scala 270:16]
  wire  NothingFilterGray_3_io_enq_valid; // @[ChiselImProc.scala 270:16]
  wire [7:0] NothingFilterGray_3_io_enq_bits; // @[ChiselImProc.scala 270:16]
  wire  NothingFilterGray_3_io_enq_user; // @[ChiselImProc.scala 270:16]
  wire  NothingFilterGray_3_io_enq_last; // @[ChiselImProc.scala 270:16]
  wire  NothingFilterGray_3_io_deq_ready; // @[ChiselImProc.scala 270:16]
  wire  NothingFilterGray_3_io_deq_valid; // @[ChiselImProc.scala 270:16]
  wire [7:0] NothingFilterGray_3_io_deq_bits; // @[ChiselImProc.scala 270:16]
  wire  NothingFilterGray_3_io_deq_user; // @[ChiselImProc.scala 270:16]
  wire  NothingFilterGray_3_io_deq_last; // @[ChiselImProc.scala 270:16]
  wire  NothingFilterGray_4_clock; // @[ChiselImProc.scala 272:16]
  wire  NothingFilterGray_4_reset; // @[ChiselImProc.scala 272:16]
  wire  NothingFilterGray_4_io_enq_ready; // @[ChiselImProc.scala 272:16]
  wire  NothingFilterGray_4_io_enq_valid; // @[ChiselImProc.scala 272:16]
  wire [7:0] NothingFilterGray_4_io_enq_bits; // @[ChiselImProc.scala 272:16]
  wire  NothingFilterGray_4_io_enq_user; // @[ChiselImProc.scala 272:16]
  wire  NothingFilterGray_4_io_enq_last; // @[ChiselImProc.scala 272:16]
  wire  NothingFilterGray_4_io_deq_ready; // @[ChiselImProc.scala 272:16]
  wire  NothingFilterGray_4_io_deq_valid; // @[ChiselImProc.scala 272:16]
  wire [7:0] NothingFilterGray_4_io_deq_bits; // @[ChiselImProc.scala 272:16]
  wire  NothingFilterGray_4_io_deq_user; // @[ChiselImProc.scala 272:16]
  wire  NothingFilterGray_4_io_deq_last; // @[ChiselImProc.scala 272:16]
  wire  NothingFilterGray_5_clock; // @[ChiselImProc.scala 274:16]
  wire  NothingFilterGray_5_reset; // @[ChiselImProc.scala 274:16]
  wire  NothingFilterGray_5_io_enq_ready; // @[ChiselImProc.scala 274:16]
  wire  NothingFilterGray_5_io_enq_valid; // @[ChiselImProc.scala 274:16]
  wire [7:0] NothingFilterGray_5_io_enq_bits; // @[ChiselImProc.scala 274:16]
  wire  NothingFilterGray_5_io_enq_user; // @[ChiselImProc.scala 274:16]
  wire  NothingFilterGray_5_io_enq_last; // @[ChiselImProc.scala 274:16]
  wire  NothingFilterGray_5_io_deq_ready; // @[ChiselImProc.scala 274:16]
  wire  NothingFilterGray_5_io_deq_valid; // @[ChiselImProc.scala 274:16]
  wire [7:0] NothingFilterGray_5_io_deq_bits; // @[ChiselImProc.scala 274:16]
  wire  NothingFilterGray_5_io_deq_user; // @[ChiselImProc.scala 274:16]
  wire  NothingFilterGray_5_io_deq_last; // @[ChiselImProc.scala 274:16]
  wire  Gray2RGBFilterGray_clock; // @[ChiselImProc.scala 276:16]
  wire  Gray2RGBFilterGray_reset; // @[ChiselImProc.scala 276:16]
  wire  Gray2RGBFilterGray_io_enq_ready; // @[ChiselImProc.scala 276:16]
  wire  Gray2RGBFilterGray_io_enq_valid; // @[ChiselImProc.scala 276:16]
  wire [23:0] Gray2RGBFilterGray_io_enq_bits; // @[ChiselImProc.scala 276:16]
  wire  Gray2RGBFilterGray_io_enq_user; // @[ChiselImProc.scala 276:16]
  wire  Gray2RGBFilterGray_io_enq_last; // @[ChiselImProc.scala 276:16]
  wire  Gray2RGBFilterGray_io_deq_ready; // @[ChiselImProc.scala 276:16]
  wire  Gray2RGBFilterGray_io_deq_valid; // @[ChiselImProc.scala 276:16]
  wire [23:0] Gray2RGBFilterGray_io_deq_bits; // @[ChiselImProc.scala 276:16]
  wire  Gray2RGBFilterGray_io_deq_user; // @[ChiselImProc.scala 276:16]
  wire  Gray2RGBFilterGray_io_deq_last; // @[ChiselImProc.scala 276:16]
  wire [1:0] Gray2RGBFilterGray_io_state_reg; // @[ChiselImProc.scala 276:16]
  wire [23:0] Gray2RGBFilterGray_io_shadow_reg; // @[ChiselImProc.scala 276:16]
  wire  Gray2RGBFilterGray_io_shadow_user; // @[ChiselImProc.scala 276:16]
  wire  Gray2RGBFilterGray_io_shadow_last; // @[ChiselImProc.scala 276:16]
  RGB2GrayFilterGray RGB2GrayFilterGray ( // @[ChiselImProc.scala 261:16]
    .clock(RGB2GrayFilterGray_clock),
    .reset(RGB2GrayFilterGray_reset),
    .io_enq_ready(RGB2GrayFilterGray_io_enq_ready),
    .io_enq_valid(RGB2GrayFilterGray_io_enq_valid),
    .io_enq_bits(RGB2GrayFilterGray_io_enq_bits),
    .io_enq_user(RGB2GrayFilterGray_io_enq_user),
    .io_enq_last(RGB2GrayFilterGray_io_enq_last),
    .io_deq_ready(RGB2GrayFilterGray_io_deq_ready),
    .io_deq_valid(RGB2GrayFilterGray_io_deq_valid),
    .io_deq_bits(RGB2GrayFilterGray_io_deq_bits),
    .io_deq_user(RGB2GrayFilterGray_io_deq_user),
    .io_deq_last(RGB2GrayFilterGray_io_deq_last)
  );
  NothingFilterGray NothingFilterGray ( // @[ChiselImProc.scala 264:16]
    .clock(NothingFilterGray_clock),
    .reset(NothingFilterGray_reset),
    .io_enq_ready(NothingFilterGray_io_enq_ready),
    .io_enq_valid(NothingFilterGray_io_enq_valid),
    .io_enq_bits(NothingFilterGray_io_enq_bits),
    .io_enq_user(NothingFilterGray_io_enq_user),
    .io_enq_last(NothingFilterGray_io_enq_last),
    .io_deq_ready(NothingFilterGray_io_deq_ready),
    .io_deq_valid(NothingFilterGray_io_deq_valid),
    .io_deq_bits(NothingFilterGray_io_deq_bits),
    .io_deq_user(NothingFilterGray_io_deq_user),
    .io_deq_last(NothingFilterGray_io_deq_last)
  );
  NothingFilterGray NothingFilterGray_1 ( // @[ChiselImProc.scala 266:16]
    .clock(NothingFilterGray_1_clock),
    .reset(NothingFilterGray_1_reset),
    .io_enq_ready(NothingFilterGray_1_io_enq_ready),
    .io_enq_valid(NothingFilterGray_1_io_enq_valid),
    .io_enq_bits(NothingFilterGray_1_io_enq_bits),
    .io_enq_user(NothingFilterGray_1_io_enq_user),
    .io_enq_last(NothingFilterGray_1_io_enq_last),
    .io_deq_ready(NothingFilterGray_1_io_deq_ready),
    .io_deq_valid(NothingFilterGray_1_io_deq_valid),
    .io_deq_bits(NothingFilterGray_1_io_deq_bits),
    .io_deq_user(NothingFilterGray_1_io_deq_user),
    .io_deq_last(NothingFilterGray_1_io_deq_last)
  );
  NothingFilterGray NothingFilterGray_2 ( // @[ChiselImProc.scala 268:16]
    .clock(NothingFilterGray_2_clock),
    .reset(NothingFilterGray_2_reset),
    .io_enq_ready(NothingFilterGray_2_io_enq_ready),
    .io_enq_valid(NothingFilterGray_2_io_enq_valid),
    .io_enq_bits(NothingFilterGray_2_io_enq_bits),
    .io_enq_user(NothingFilterGray_2_io_enq_user),
    .io_enq_last(NothingFilterGray_2_io_enq_last),
    .io_deq_ready(NothingFilterGray_2_io_deq_ready),
    .io_deq_valid(NothingFilterGray_2_io_deq_valid),
    .io_deq_bits(NothingFilterGray_2_io_deq_bits),
    .io_deq_user(NothingFilterGray_2_io_deq_user),
    .io_deq_last(NothingFilterGray_2_io_deq_last)
  );
  NothingFilterGray NothingFilterGray_3 ( // @[ChiselImProc.scala 270:16]
    .clock(NothingFilterGray_3_clock),
    .reset(NothingFilterGray_3_reset),
    .io_enq_ready(NothingFilterGray_3_io_enq_ready),
    .io_enq_valid(NothingFilterGray_3_io_enq_valid),
    .io_enq_bits(NothingFilterGray_3_io_enq_bits),
    .io_enq_user(NothingFilterGray_3_io_enq_user),
    .io_enq_last(NothingFilterGray_3_io_enq_last),
    .io_deq_ready(NothingFilterGray_3_io_deq_ready),
    .io_deq_valid(NothingFilterGray_3_io_deq_valid),
    .io_deq_bits(NothingFilterGray_3_io_deq_bits),
    .io_deq_user(NothingFilterGray_3_io_deq_user),
    .io_deq_last(NothingFilterGray_3_io_deq_last)
  );
  NothingFilterGray NothingFilterGray_4 ( // @[ChiselImProc.scala 272:16]
    .clock(NothingFilterGray_4_clock),
    .reset(NothingFilterGray_4_reset),
    .io_enq_ready(NothingFilterGray_4_io_enq_ready),
    .io_enq_valid(NothingFilterGray_4_io_enq_valid),
    .io_enq_bits(NothingFilterGray_4_io_enq_bits),
    .io_enq_user(NothingFilterGray_4_io_enq_user),
    .io_enq_last(NothingFilterGray_4_io_enq_last),
    .io_deq_ready(NothingFilterGray_4_io_deq_ready),
    .io_deq_valid(NothingFilterGray_4_io_deq_valid),
    .io_deq_bits(NothingFilterGray_4_io_deq_bits),
    .io_deq_user(NothingFilterGray_4_io_deq_user),
    .io_deq_last(NothingFilterGray_4_io_deq_last)
  );
  NothingFilterGray NothingFilterGray_5 ( // @[ChiselImProc.scala 274:16]
    .clock(NothingFilterGray_5_clock),
    .reset(NothingFilterGray_5_reset),
    .io_enq_ready(NothingFilterGray_5_io_enq_ready),
    .io_enq_valid(NothingFilterGray_5_io_enq_valid),
    .io_enq_bits(NothingFilterGray_5_io_enq_bits),
    .io_enq_user(NothingFilterGray_5_io_enq_user),
    .io_enq_last(NothingFilterGray_5_io_enq_last),
    .io_deq_ready(NothingFilterGray_5_io_deq_ready),
    .io_deq_valid(NothingFilterGray_5_io_deq_valid),
    .io_deq_bits(NothingFilterGray_5_io_deq_bits),
    .io_deq_user(NothingFilterGray_5_io_deq_user),
    .io_deq_last(NothingFilterGray_5_io_deq_last)
  );
  Gray2RGBFilterGray Gray2RGBFilterGray ( // @[ChiselImProc.scala 276:16]
    .clock(Gray2RGBFilterGray_clock),
    .reset(Gray2RGBFilterGray_reset),
    .io_enq_ready(Gray2RGBFilterGray_io_enq_ready),
    .io_enq_valid(Gray2RGBFilterGray_io_enq_valid),
    .io_enq_bits(Gray2RGBFilterGray_io_enq_bits),
    .io_enq_user(Gray2RGBFilterGray_io_enq_user),
    .io_enq_last(Gray2RGBFilterGray_io_enq_last),
    .io_deq_ready(Gray2RGBFilterGray_io_deq_ready),
    .io_deq_valid(Gray2RGBFilterGray_io_deq_valid),
    .io_deq_bits(Gray2RGBFilterGray_io_deq_bits),
    .io_deq_user(Gray2RGBFilterGray_io_deq_user),
    .io_deq_last(Gray2RGBFilterGray_io_deq_last),
    .io_state_reg(Gray2RGBFilterGray_io_state_reg),
    .io_shadow_reg(Gray2RGBFilterGray_io_shadow_reg),
    .io_shadow_user(Gray2RGBFilterGray_io_shadow_user),
    .io_shadow_last(Gray2RGBFilterGray_io_shadow_last)
  );
  assign io_enq_ready = RGB2GrayFilterGray_io_enq_ready; // @[ChiselImProc.scala 287:12]
  assign io_deq_valid = Gray2RGBFilterGray_io_deq_valid; // @[ChiselImProc.scala 289:12]
  assign io_deq_bits = Gray2RGBFilterGray_io_deq_bits; // @[ChiselImProc.scala 289:12]
  assign io_deq_user = Gray2RGBFilterGray_io_deq_user; // @[ChiselImProc.scala 289:12]
  assign io_deq_last = Gray2RGBFilterGray_io_deq_last; // @[ChiselImProc.scala 289:12]
  assign io_state_reg = Gray2RGBFilterGray_io_state_reg; // @[ChiselImProc.scala 291:18]
  assign io_shadow_reg = Gray2RGBFilterGray_io_shadow_reg; // @[ChiselImProc.scala 292:19]
  assign io_shadow_user = Gray2RGBFilterGray_io_shadow_user; // @[ChiselImProc.scala 293:20]
  assign io_shadow_last = Gray2RGBFilterGray_io_shadow_last; // @[ChiselImProc.scala 294:20]
  assign RGB2GrayFilterGray_clock = clock;
  assign RGB2GrayFilterGray_reset = reset;
  assign RGB2GrayFilterGray_io_enq_valid = io_enq_valid; // @[ChiselImProc.scala 287:12]
  assign RGB2GrayFilterGray_io_enq_bits = io_enq_bits; // @[ChiselImProc.scala 287:12]
  assign RGB2GrayFilterGray_io_enq_user = io_enq_user; // @[ChiselImProc.scala 287:12]
  assign RGB2GrayFilterGray_io_enq_last = io_enq_last; // @[ChiselImProc.scala 287:12]
  assign RGB2GrayFilterGray_io_deq_ready = NothingFilterGray_io_enq_ready; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_clock = clock;
  assign NothingFilterGray_reset = reset;
  assign NothingFilterGray_io_enq_valid = RGB2GrayFilterGray_io_deq_valid; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_io_enq_bits = RGB2GrayFilterGray_io_deq_bits[7:0]; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_io_enq_user = RGB2GrayFilterGray_io_deq_user; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_io_enq_last = RGB2GrayFilterGray_io_deq_last; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_io_deq_ready = NothingFilterGray_1_io_enq_ready; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_1_clock = clock;
  assign NothingFilterGray_1_reset = reset;
  assign NothingFilterGray_1_io_enq_valid = NothingFilterGray_io_deq_valid; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_1_io_enq_bits = NothingFilterGray_io_deq_bits; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_1_io_enq_user = NothingFilterGray_io_deq_user; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_1_io_enq_last = NothingFilterGray_io_deq_last; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_1_io_deq_ready = NothingFilterGray_2_io_enq_ready; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_2_clock = clock;
  assign NothingFilterGray_2_reset = reset;
  assign NothingFilterGray_2_io_enq_valid = NothingFilterGray_1_io_deq_valid; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_2_io_enq_bits = NothingFilterGray_1_io_deq_bits; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_2_io_enq_user = NothingFilterGray_1_io_deq_user; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_2_io_enq_last = NothingFilterGray_1_io_deq_last; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_2_io_deq_ready = NothingFilterGray_3_io_enq_ready; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_3_clock = clock;
  assign NothingFilterGray_3_reset = reset;
  assign NothingFilterGray_3_io_enq_valid = NothingFilterGray_2_io_deq_valid; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_3_io_enq_bits = NothingFilterGray_2_io_deq_bits; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_3_io_enq_user = NothingFilterGray_2_io_deq_user; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_3_io_enq_last = NothingFilterGray_2_io_deq_last; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_3_io_deq_ready = NothingFilterGray_4_io_enq_ready; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_4_clock = clock;
  assign NothingFilterGray_4_reset = reset;
  assign NothingFilterGray_4_io_enq_valid = NothingFilterGray_3_io_deq_valid; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_4_io_enq_bits = NothingFilterGray_3_io_deq_bits; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_4_io_enq_user = NothingFilterGray_3_io_deq_user; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_4_io_enq_last = NothingFilterGray_3_io_deq_last; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_4_io_deq_ready = NothingFilterGray_5_io_enq_ready; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_5_clock = clock;
  assign NothingFilterGray_5_reset = reset;
  assign NothingFilterGray_5_io_enq_valid = NothingFilterGray_4_io_deq_valid; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_5_io_enq_bits = NothingFilterGray_4_io_deq_bits; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_5_io_enq_user = NothingFilterGray_4_io_deq_user; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_5_io_enq_last = NothingFilterGray_4_io_deq_last; // @[ChiselImProc.scala 284:30]
  assign NothingFilterGray_5_io_deq_ready = Gray2RGBFilterGray_io_enq_ready; // @[ChiselImProc.scala 284:30]
  assign Gray2RGBFilterGray_clock = clock;
  assign Gray2RGBFilterGray_reset = reset;
  assign Gray2RGBFilterGray_io_enq_valid = NothingFilterGray_5_io_deq_valid; // @[ChiselImProc.scala 284:30]
  assign Gray2RGBFilterGray_io_enq_bits = {{16'd0}, NothingFilterGray_5_io_deq_bits}; // @[ChiselImProc.scala 284:30]
  assign Gray2RGBFilterGray_io_enq_user = NothingFilterGray_5_io_deq_user; // @[ChiselImProc.scala 284:30]
  assign Gray2RGBFilterGray_io_enq_last = NothingFilterGray_5_io_deq_last; // @[ChiselImProc.scala 284:30]
  assign Gray2RGBFilterGray_io_deq_ready = io_deq_ready; // @[ChiselImProc.scala 289:12]
endmodule
