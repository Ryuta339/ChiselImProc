// axi4.ImProcMain898522778
// 2020/11/20/ 14:04

module RGB2GrayFilter(
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
`endif // RANDOMIZE_REG_INIT
  reg [1:0] stateReg; // @[ChiselImProc.scala 46:28]
  reg [23:0] dataReg; // @[ChiselImProc.scala 48:23]
  reg [23:0] shadowReg; // @[ChiselImProc.scala 50:25]
  wire  _T = 2'h0 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_1 = 2'h1 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_2 = ~io_enq_valid; // @[ChiselImProc.scala 66:35]
  wire  _T_3 = io_deq_ready & _T_2; // @[ChiselImProc.scala 66:32]
  wire  _T_4 = io_deq_ready & io_enq_valid; // @[ChiselImProc.scala 68:38]
  wire  _T_5 = ~io_deq_ready; // @[ChiselImProc.scala 73:25]
  wire  _T_6 = _T_5 & io_enq_valid; // @[ChiselImProc.scala 73:39]
  wire  _T_7 = 2'h2 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_8 = 2'h3 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_9 = stateReg == 2'h0; // @[ChiselImProc.scala 99:31]
  wire  _T_10 = stateReg == 2'h1; // @[ChiselImProc.scala 99:53]
  wire  _T_11 = _T_9 | _T_10; // @[ChiselImProc.scala 99:41]
  wire  _T_12 = stateReg == 2'h3; // @[ChiselImProc.scala 99:73]
  wire  _T_15 = stateReg == 2'h2; // @[ChiselImProc.scala 100:51]
  wire [23:0] _T_17 = dataReg & 24'hff; // @[ChiselImProc.scala 138:36]
  wire [37:0] _T_18 = 24'h24dd * _T_17; // @[ChiselImProc.scala 138:25]
  wire [23:0] _T_19 = dataReg & 24'hff00; // @[ChiselImProc.scala 139:33]
  wire [23:0] _T_20 = {{8'd0}, _T_19[23:8]}; // @[ChiselImProc.scala 139:47]
  wire [39:0] _T_21 = 24'h9645 * _T_20; // @[ChiselImProc.scala 139:21]
  wire [39:0] _GEN_46 = {{2'd0}, _T_18}; // @[ChiselImProc.scala 138:50]
  wire [39:0] _T_23 = _GEN_46 + _T_21; // @[ChiselImProc.scala 138:50]
  wire [23:0] _T_24 = dataReg & 24'hff0000; // @[ChiselImProc.scala 140:33]
  wire [23:0] _T_25 = {{16'd0}, _T_24[23:16]}; // @[ChiselImProc.scala 140:47]
  wire [38:0] _T_26 = 24'h4c8b * _T_25; // @[ChiselImProc.scala 140:21]
  wire [39:0] _GEN_48 = {{1'd0}, _T_26}; // @[ChiselImProc.scala 139:55]
  wire [39:0] _T_28 = _T_23 + _GEN_48; // @[ChiselImProc.scala 139:55]
  wire [31:0] pixGray = _T_28[31:0]; // @[ChiselImProc.scala 135:24 ChiselImProc.scala 138:13]
  wire [31:0] _T_29 = {{16'd0}, pixGray[31:16]}; // @[ChiselImProc.scala 142:24]
  wire [15:0] rolled = _T_29[15:0]; // @[ChiselImProc.scala 136:23 ChiselImProc.scala 142:12]
  wire  _T_30 = rolled > 16'hff; // @[ChiselImProc.scala 143:32]
  wire [15:0] _T_31 = _T_30 ? 16'hff : rolled; // @[ChiselImProc.scala 143:24]
  assign io_enq_ready = _T_11 | _T_12; // @[ChiselImProc.scala 99:18]
  assign io_deq_valid = _T_10 | _T_15; // @[ChiselImProc.scala 100:18]
  assign io_deq_bits = {{8'd0}, _T_31}; // @[ChiselImProc.scala 116:17 ChiselImProc.scala 143:17]
  assign io_deq_user = io_enq_user; // @[ChiselImProc.scala 41:17 ChiselImProc.scala 114:17]
  assign io_deq_last = io_enq_last; // @[ChiselImProc.scala 40:17 ChiselImProc.scala 113:17]
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
  end
endmodule
module NothingFilter(
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
`endif // RANDOMIZE_REG_INIT
  reg [1:0] stateReg; // @[ChiselImProc.scala 46:28]
  reg [7:0] dataReg; // @[ChiselImProc.scala 48:23]
  reg [7:0] shadowReg; // @[ChiselImProc.scala 50:25]
  wire  _T = 2'h0 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_1 = 2'h1 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_2 = ~io_enq_valid; // @[ChiselImProc.scala 66:35]
  wire  _T_3 = io_deq_ready & _T_2; // @[ChiselImProc.scala 66:32]
  wire  _T_4 = io_deq_ready & io_enq_valid; // @[ChiselImProc.scala 68:38]
  wire  _T_5 = ~io_deq_ready; // @[ChiselImProc.scala 73:25]
  wire  _T_6 = _T_5 & io_enq_valid; // @[ChiselImProc.scala 73:39]
  wire  _T_7 = 2'h2 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_8 = 2'h3 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_9 = stateReg == 2'h0; // @[ChiselImProc.scala 99:31]
  wire  _T_10 = stateReg == 2'h1; // @[ChiselImProc.scala 99:53]
  wire  _T_11 = _T_9 | _T_10; // @[ChiselImProc.scala 99:41]
  wire  _T_12 = stateReg == 2'h3; // @[ChiselImProc.scala 99:73]
  wire  _T_15 = stateReg == 2'h2; // @[ChiselImProc.scala 100:51]
  assign io_enq_ready = _T_11 | _T_12; // @[ChiselImProc.scala 99:18]
  assign io_deq_valid = _T_10 | _T_15; // @[ChiselImProc.scala 100:18]
  assign io_deq_bits = dataReg; // @[ChiselImProc.scala 116:17 ChiselImProc.scala 121:17]
  assign io_deq_user = io_enq_user; // @[ChiselImProc.scala 41:17 ChiselImProc.scala 114:17]
  assign io_deq_last = io_enq_last; // @[ChiselImProc.scala 40:17 ChiselImProc.scala 113:17]
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
  end
endmodule
module Gray2RGBFilter(
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
  reg [1:0] stateReg; // @[ChiselImProc.scala 46:28]
  reg [23:0] dataReg; // @[ChiselImProc.scala 48:23]
  reg [23:0] shadowReg; // @[ChiselImProc.scala 50:25]
  reg  userReg; // @[ChiselImProc.scala 51:23]
  reg  shadowUserReg; // @[ChiselImProc.scala 52:29]
  reg  lastReg; // @[ChiselImProc.scala 53:23]
  reg  shadowLastReg; // @[ChiselImProc.scala 54:29]
  wire  _T = 2'h0 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_1 = 2'h1 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_2 = ~io_enq_valid; // @[ChiselImProc.scala 66:35]
  wire  _T_3 = io_deq_ready & _T_2; // @[ChiselImProc.scala 66:32]
  wire  _T_4 = io_deq_ready & io_enq_valid; // @[ChiselImProc.scala 68:38]
  wire  _T_5 = ~io_deq_ready; // @[ChiselImProc.scala 73:25]
  wire  _T_6 = _T_5 & io_enq_valid; // @[ChiselImProc.scala 73:39]
  wire  _T_7 = 2'h2 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_8 = 2'h3 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_9 = stateReg == 2'h0; // @[ChiselImProc.scala 99:31]
  wire  _T_10 = stateReg == 2'h1; // @[ChiselImProc.scala 99:53]
  wire  _T_11 = _T_9 | _T_10; // @[ChiselImProc.scala 99:41]
  wire  _T_12 = stateReg == 2'h3; // @[ChiselImProc.scala 99:73]
  wire  _T_15 = stateReg == 2'h2; // @[ChiselImProc.scala 100:51]
  wire [39:0] _GEN_45 = {dataReg, 16'h0}; // @[ChiselImProc.scala 149:28]
  wire [54:0] _T_17 = {{15'd0}, _GEN_45}; // @[ChiselImProc.scala 149:28]
  wire [31:0] _GEN_46 = {dataReg, 8'h0}; // @[ChiselImProc.scala 149:46]
  wire [38:0] _T_18 = {{7'd0}, _GEN_46}; // @[ChiselImProc.scala 149:46]
  wire [54:0] _GEN_47 = {{16'd0}, _T_18}; // @[ChiselImProc.scala 149:36]
  wire [54:0] _T_19 = _T_17 | _GEN_47; // @[ChiselImProc.scala 149:36]
  wire [54:0] _GEN_48 = {{31'd0}, dataReg}; // @[ChiselImProc.scala 149:53]
  wire [54:0] _T_20 = _T_19 | _GEN_48; // @[ChiselImProc.scala 149:53]
  assign io_enq_ready = _T_11 | _T_12; // @[ChiselImProc.scala 99:18]
  assign io_deq_valid = _T_10 | _T_15; // @[ChiselImProc.scala 100:18]
  assign io_deq_bits = _T_20[23:0]; // @[ChiselImProc.scala 116:17 ChiselImProc.scala 149:17]
  assign io_deq_user = io_enq_user; // @[ChiselImProc.scala 41:17 ChiselImProc.scala 114:17]
  assign io_deq_last = io_enq_last; // @[ChiselImProc.scala 40:17 ChiselImProc.scala 113:17]
  assign io_state_reg = stateReg; // @[ChiselImProc.scala 102:18]
  assign io_shadow_reg = dataReg; // @[ChiselImProc.scala 108:19]
  assign io_shadow_user = userReg; // @[ChiselImProc.scala 109:20]
  assign io_shadow_last = lastReg; // @[ChiselImProc.scala 110:20]
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
      if (io_enq_valid) begin
        userReg <= io_enq_user;
      end
    end else if (_T_1) begin
      if (!(_T_3)) begin
        if (_T_4) begin
          userReg <= io_enq_user;
        end
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
module ChiselImProc(
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
  wire  RGB2GrayFilter_clock; // @[ChiselImProc.scala 204:16]
  wire  RGB2GrayFilter_reset; // @[ChiselImProc.scala 204:16]
  wire  RGB2GrayFilter_io_enq_ready; // @[ChiselImProc.scala 204:16]
  wire  RGB2GrayFilter_io_enq_valid; // @[ChiselImProc.scala 204:16]
  wire [23:0] RGB2GrayFilter_io_enq_bits; // @[ChiselImProc.scala 204:16]
  wire  RGB2GrayFilter_io_enq_user; // @[ChiselImProc.scala 204:16]
  wire  RGB2GrayFilter_io_enq_last; // @[ChiselImProc.scala 204:16]
  wire  RGB2GrayFilter_io_deq_ready; // @[ChiselImProc.scala 204:16]
  wire  RGB2GrayFilter_io_deq_valid; // @[ChiselImProc.scala 204:16]
  wire [23:0] RGB2GrayFilter_io_deq_bits; // @[ChiselImProc.scala 204:16]
  wire  RGB2GrayFilter_io_deq_user; // @[ChiselImProc.scala 204:16]
  wire  RGB2GrayFilter_io_deq_last; // @[ChiselImProc.scala 204:16]
  wire  NothingFilter_clock; // @[ChiselImProc.scala 207:16]
  wire  NothingFilter_reset; // @[ChiselImProc.scala 207:16]
  wire  NothingFilter_io_enq_ready; // @[ChiselImProc.scala 207:16]
  wire  NothingFilter_io_enq_valid; // @[ChiselImProc.scala 207:16]
  wire [7:0] NothingFilter_io_enq_bits; // @[ChiselImProc.scala 207:16]
  wire  NothingFilter_io_enq_user; // @[ChiselImProc.scala 207:16]
  wire  NothingFilter_io_enq_last; // @[ChiselImProc.scala 207:16]
  wire  NothingFilter_io_deq_ready; // @[ChiselImProc.scala 207:16]
  wire  NothingFilter_io_deq_valid; // @[ChiselImProc.scala 207:16]
  wire [7:0] NothingFilter_io_deq_bits; // @[ChiselImProc.scala 207:16]
  wire  NothingFilter_io_deq_user; // @[ChiselImProc.scala 207:16]
  wire  NothingFilter_io_deq_last; // @[ChiselImProc.scala 207:16]
  wire  NothingFilter_1_clock; // @[ChiselImProc.scala 209:16]
  wire  NothingFilter_1_reset; // @[ChiselImProc.scala 209:16]
  wire  NothingFilter_1_io_enq_ready; // @[ChiselImProc.scala 209:16]
  wire  NothingFilter_1_io_enq_valid; // @[ChiselImProc.scala 209:16]
  wire [7:0] NothingFilter_1_io_enq_bits; // @[ChiselImProc.scala 209:16]
  wire  NothingFilter_1_io_enq_user; // @[ChiselImProc.scala 209:16]
  wire  NothingFilter_1_io_enq_last; // @[ChiselImProc.scala 209:16]
  wire  NothingFilter_1_io_deq_ready; // @[ChiselImProc.scala 209:16]
  wire  NothingFilter_1_io_deq_valid; // @[ChiselImProc.scala 209:16]
  wire [7:0] NothingFilter_1_io_deq_bits; // @[ChiselImProc.scala 209:16]
  wire  NothingFilter_1_io_deq_user; // @[ChiselImProc.scala 209:16]
  wire  NothingFilter_1_io_deq_last; // @[ChiselImProc.scala 209:16]
  wire  NothingFilter_2_clock; // @[ChiselImProc.scala 211:16]
  wire  NothingFilter_2_reset; // @[ChiselImProc.scala 211:16]
  wire  NothingFilter_2_io_enq_ready; // @[ChiselImProc.scala 211:16]
  wire  NothingFilter_2_io_enq_valid; // @[ChiselImProc.scala 211:16]
  wire [7:0] NothingFilter_2_io_enq_bits; // @[ChiselImProc.scala 211:16]
  wire  NothingFilter_2_io_enq_user; // @[ChiselImProc.scala 211:16]
  wire  NothingFilter_2_io_enq_last; // @[ChiselImProc.scala 211:16]
  wire  NothingFilter_2_io_deq_ready; // @[ChiselImProc.scala 211:16]
  wire  NothingFilter_2_io_deq_valid; // @[ChiselImProc.scala 211:16]
  wire [7:0] NothingFilter_2_io_deq_bits; // @[ChiselImProc.scala 211:16]
  wire  NothingFilter_2_io_deq_user; // @[ChiselImProc.scala 211:16]
  wire  NothingFilter_2_io_deq_last; // @[ChiselImProc.scala 211:16]
  wire  NothingFilter_3_clock; // @[ChiselImProc.scala 213:16]
  wire  NothingFilter_3_reset; // @[ChiselImProc.scala 213:16]
  wire  NothingFilter_3_io_enq_ready; // @[ChiselImProc.scala 213:16]
  wire  NothingFilter_3_io_enq_valid; // @[ChiselImProc.scala 213:16]
  wire [7:0] NothingFilter_3_io_enq_bits; // @[ChiselImProc.scala 213:16]
  wire  NothingFilter_3_io_enq_user; // @[ChiselImProc.scala 213:16]
  wire  NothingFilter_3_io_enq_last; // @[ChiselImProc.scala 213:16]
  wire  NothingFilter_3_io_deq_ready; // @[ChiselImProc.scala 213:16]
  wire  NothingFilter_3_io_deq_valid; // @[ChiselImProc.scala 213:16]
  wire [7:0] NothingFilter_3_io_deq_bits; // @[ChiselImProc.scala 213:16]
  wire  NothingFilter_3_io_deq_user; // @[ChiselImProc.scala 213:16]
  wire  NothingFilter_3_io_deq_last; // @[ChiselImProc.scala 213:16]
  wire  NothingFilter_4_clock; // @[ChiselImProc.scala 215:16]
  wire  NothingFilter_4_reset; // @[ChiselImProc.scala 215:16]
  wire  NothingFilter_4_io_enq_ready; // @[ChiselImProc.scala 215:16]
  wire  NothingFilter_4_io_enq_valid; // @[ChiselImProc.scala 215:16]
  wire [7:0] NothingFilter_4_io_enq_bits; // @[ChiselImProc.scala 215:16]
  wire  NothingFilter_4_io_enq_user; // @[ChiselImProc.scala 215:16]
  wire  NothingFilter_4_io_enq_last; // @[ChiselImProc.scala 215:16]
  wire  NothingFilter_4_io_deq_ready; // @[ChiselImProc.scala 215:16]
  wire  NothingFilter_4_io_deq_valid; // @[ChiselImProc.scala 215:16]
  wire [7:0] NothingFilter_4_io_deq_bits; // @[ChiselImProc.scala 215:16]
  wire  NothingFilter_4_io_deq_user; // @[ChiselImProc.scala 215:16]
  wire  NothingFilter_4_io_deq_last; // @[ChiselImProc.scala 215:16]
  wire  NothingFilter_5_clock; // @[ChiselImProc.scala 217:16]
  wire  NothingFilter_5_reset; // @[ChiselImProc.scala 217:16]
  wire  NothingFilter_5_io_enq_ready; // @[ChiselImProc.scala 217:16]
  wire  NothingFilter_5_io_enq_valid; // @[ChiselImProc.scala 217:16]
  wire [7:0] NothingFilter_5_io_enq_bits; // @[ChiselImProc.scala 217:16]
  wire  NothingFilter_5_io_enq_user; // @[ChiselImProc.scala 217:16]
  wire  NothingFilter_5_io_enq_last; // @[ChiselImProc.scala 217:16]
  wire  NothingFilter_5_io_deq_ready; // @[ChiselImProc.scala 217:16]
  wire  NothingFilter_5_io_deq_valid; // @[ChiselImProc.scala 217:16]
  wire [7:0] NothingFilter_5_io_deq_bits; // @[ChiselImProc.scala 217:16]
  wire  NothingFilter_5_io_deq_user; // @[ChiselImProc.scala 217:16]
  wire  NothingFilter_5_io_deq_last; // @[ChiselImProc.scala 217:16]
  wire  Gray2RGBFilter_clock; // @[ChiselImProc.scala 219:16]
  wire  Gray2RGBFilter_reset; // @[ChiselImProc.scala 219:16]
  wire  Gray2RGBFilter_io_enq_ready; // @[ChiselImProc.scala 219:16]
  wire  Gray2RGBFilter_io_enq_valid; // @[ChiselImProc.scala 219:16]
  wire [23:0] Gray2RGBFilter_io_enq_bits; // @[ChiselImProc.scala 219:16]
  wire  Gray2RGBFilter_io_enq_user; // @[ChiselImProc.scala 219:16]
  wire  Gray2RGBFilter_io_enq_last; // @[ChiselImProc.scala 219:16]
  wire  Gray2RGBFilter_io_deq_ready; // @[ChiselImProc.scala 219:16]
  wire  Gray2RGBFilter_io_deq_valid; // @[ChiselImProc.scala 219:16]
  wire [23:0] Gray2RGBFilter_io_deq_bits; // @[ChiselImProc.scala 219:16]
  wire  Gray2RGBFilter_io_deq_user; // @[ChiselImProc.scala 219:16]
  wire  Gray2RGBFilter_io_deq_last; // @[ChiselImProc.scala 219:16]
  wire [1:0] Gray2RGBFilter_io_state_reg; // @[ChiselImProc.scala 219:16]
  wire [23:0] Gray2RGBFilter_io_shadow_reg; // @[ChiselImProc.scala 219:16]
  wire  Gray2RGBFilter_io_shadow_user; // @[ChiselImProc.scala 219:16]
  wire  Gray2RGBFilter_io_shadow_last; // @[ChiselImProc.scala 219:16]
  RGB2GrayFilter RGB2GrayFilter ( // @[ChiselImProc.scala 204:16]
    .clock(RGB2GrayFilter_clock),
    .reset(RGB2GrayFilter_reset),
    .io_enq_ready(RGB2GrayFilter_io_enq_ready),
    .io_enq_valid(RGB2GrayFilter_io_enq_valid),
    .io_enq_bits(RGB2GrayFilter_io_enq_bits),
    .io_enq_user(RGB2GrayFilter_io_enq_user),
    .io_enq_last(RGB2GrayFilter_io_enq_last),
    .io_deq_ready(RGB2GrayFilter_io_deq_ready),
    .io_deq_valid(RGB2GrayFilter_io_deq_valid),
    .io_deq_bits(RGB2GrayFilter_io_deq_bits),
    .io_deq_user(RGB2GrayFilter_io_deq_user),
    .io_deq_last(RGB2GrayFilter_io_deq_last)
  );
  NothingFilter NothingFilter ( // @[ChiselImProc.scala 207:16]
    .clock(NothingFilter_clock),
    .reset(NothingFilter_reset),
    .io_enq_ready(NothingFilter_io_enq_ready),
    .io_enq_valid(NothingFilter_io_enq_valid),
    .io_enq_bits(NothingFilter_io_enq_bits),
    .io_enq_user(NothingFilter_io_enq_user),
    .io_enq_last(NothingFilter_io_enq_last),
    .io_deq_ready(NothingFilter_io_deq_ready),
    .io_deq_valid(NothingFilter_io_deq_valid),
    .io_deq_bits(NothingFilter_io_deq_bits),
    .io_deq_user(NothingFilter_io_deq_user),
    .io_deq_last(NothingFilter_io_deq_last)
  );
  NothingFilter NothingFilter_1 ( // @[ChiselImProc.scala 209:16]
    .clock(NothingFilter_1_clock),
    .reset(NothingFilter_1_reset),
    .io_enq_ready(NothingFilter_1_io_enq_ready),
    .io_enq_valid(NothingFilter_1_io_enq_valid),
    .io_enq_bits(NothingFilter_1_io_enq_bits),
    .io_enq_user(NothingFilter_1_io_enq_user),
    .io_enq_last(NothingFilter_1_io_enq_last),
    .io_deq_ready(NothingFilter_1_io_deq_ready),
    .io_deq_valid(NothingFilter_1_io_deq_valid),
    .io_deq_bits(NothingFilter_1_io_deq_bits),
    .io_deq_user(NothingFilter_1_io_deq_user),
    .io_deq_last(NothingFilter_1_io_deq_last)
  );
  NothingFilter NothingFilter_2 ( // @[ChiselImProc.scala 211:16]
    .clock(NothingFilter_2_clock),
    .reset(NothingFilter_2_reset),
    .io_enq_ready(NothingFilter_2_io_enq_ready),
    .io_enq_valid(NothingFilter_2_io_enq_valid),
    .io_enq_bits(NothingFilter_2_io_enq_bits),
    .io_enq_user(NothingFilter_2_io_enq_user),
    .io_enq_last(NothingFilter_2_io_enq_last),
    .io_deq_ready(NothingFilter_2_io_deq_ready),
    .io_deq_valid(NothingFilter_2_io_deq_valid),
    .io_deq_bits(NothingFilter_2_io_deq_bits),
    .io_deq_user(NothingFilter_2_io_deq_user),
    .io_deq_last(NothingFilter_2_io_deq_last)
  );
  NothingFilter NothingFilter_3 ( // @[ChiselImProc.scala 213:16]
    .clock(NothingFilter_3_clock),
    .reset(NothingFilter_3_reset),
    .io_enq_ready(NothingFilter_3_io_enq_ready),
    .io_enq_valid(NothingFilter_3_io_enq_valid),
    .io_enq_bits(NothingFilter_3_io_enq_bits),
    .io_enq_user(NothingFilter_3_io_enq_user),
    .io_enq_last(NothingFilter_3_io_enq_last),
    .io_deq_ready(NothingFilter_3_io_deq_ready),
    .io_deq_valid(NothingFilter_3_io_deq_valid),
    .io_deq_bits(NothingFilter_3_io_deq_bits),
    .io_deq_user(NothingFilter_3_io_deq_user),
    .io_deq_last(NothingFilter_3_io_deq_last)
  );
  NothingFilter NothingFilter_4 ( // @[ChiselImProc.scala 215:16]
    .clock(NothingFilter_4_clock),
    .reset(NothingFilter_4_reset),
    .io_enq_ready(NothingFilter_4_io_enq_ready),
    .io_enq_valid(NothingFilter_4_io_enq_valid),
    .io_enq_bits(NothingFilter_4_io_enq_bits),
    .io_enq_user(NothingFilter_4_io_enq_user),
    .io_enq_last(NothingFilter_4_io_enq_last),
    .io_deq_ready(NothingFilter_4_io_deq_ready),
    .io_deq_valid(NothingFilter_4_io_deq_valid),
    .io_deq_bits(NothingFilter_4_io_deq_bits),
    .io_deq_user(NothingFilter_4_io_deq_user),
    .io_deq_last(NothingFilter_4_io_deq_last)
  );
  NothingFilter NothingFilter_5 ( // @[ChiselImProc.scala 217:16]
    .clock(NothingFilter_5_clock),
    .reset(NothingFilter_5_reset),
    .io_enq_ready(NothingFilter_5_io_enq_ready),
    .io_enq_valid(NothingFilter_5_io_enq_valid),
    .io_enq_bits(NothingFilter_5_io_enq_bits),
    .io_enq_user(NothingFilter_5_io_enq_user),
    .io_enq_last(NothingFilter_5_io_enq_last),
    .io_deq_ready(NothingFilter_5_io_deq_ready),
    .io_deq_valid(NothingFilter_5_io_deq_valid),
    .io_deq_bits(NothingFilter_5_io_deq_bits),
    .io_deq_user(NothingFilter_5_io_deq_user),
    .io_deq_last(NothingFilter_5_io_deq_last)
  );
  Gray2RGBFilter Gray2RGBFilter ( // @[ChiselImProc.scala 219:16]
    .clock(Gray2RGBFilter_clock),
    .reset(Gray2RGBFilter_reset),
    .io_enq_ready(Gray2RGBFilter_io_enq_ready),
    .io_enq_valid(Gray2RGBFilter_io_enq_valid),
    .io_enq_bits(Gray2RGBFilter_io_enq_bits),
    .io_enq_user(Gray2RGBFilter_io_enq_user),
    .io_enq_last(Gray2RGBFilter_io_enq_last),
    .io_deq_ready(Gray2RGBFilter_io_deq_ready),
    .io_deq_valid(Gray2RGBFilter_io_deq_valid),
    .io_deq_bits(Gray2RGBFilter_io_deq_bits),
    .io_deq_user(Gray2RGBFilter_io_deq_user),
    .io_deq_last(Gray2RGBFilter_io_deq_last),
    .io_state_reg(Gray2RGBFilter_io_state_reg),
    .io_shadow_reg(Gray2RGBFilter_io_shadow_reg),
    .io_shadow_user(Gray2RGBFilter_io_shadow_user),
    .io_shadow_last(Gray2RGBFilter_io_shadow_last)
  );
  assign io_enq_ready = RGB2GrayFilter_io_enq_ready; // @[ChiselImProc.scala 230:12]
  assign io_deq_valid = Gray2RGBFilter_io_deq_valid; // @[ChiselImProc.scala 232:12]
  assign io_deq_bits = Gray2RGBFilter_io_deq_bits; // @[ChiselImProc.scala 232:12]
  assign io_deq_user = Gray2RGBFilter_io_deq_user; // @[ChiselImProc.scala 232:12]
  assign io_deq_last = Gray2RGBFilter_io_deq_last; // @[ChiselImProc.scala 232:12]
  assign io_state_reg = Gray2RGBFilter_io_state_reg; // @[ChiselImProc.scala 234:18]
  assign io_shadow_reg = Gray2RGBFilter_io_shadow_reg; // @[ChiselImProc.scala 235:19]
  assign io_shadow_user = Gray2RGBFilter_io_shadow_user; // @[ChiselImProc.scala 236:20]
  assign io_shadow_last = Gray2RGBFilter_io_shadow_last; // @[ChiselImProc.scala 237:20]
  assign RGB2GrayFilter_clock = clock;
  assign RGB2GrayFilter_reset = reset;
  assign RGB2GrayFilter_io_enq_valid = io_enq_valid; // @[ChiselImProc.scala 230:12]
  assign RGB2GrayFilter_io_enq_bits = io_enq_bits; // @[ChiselImProc.scala 230:12]
  assign RGB2GrayFilter_io_enq_user = io_enq_user; // @[ChiselImProc.scala 230:12]
  assign RGB2GrayFilter_io_enq_last = io_enq_last; // @[ChiselImProc.scala 230:12]
  assign RGB2GrayFilter_io_deq_ready = NothingFilter_io_enq_ready; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_clock = clock;
  assign NothingFilter_reset = reset;
  assign NothingFilter_io_enq_valid = RGB2GrayFilter_io_deq_valid; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_io_enq_bits = RGB2GrayFilter_io_deq_bits[7:0]; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_io_enq_user = RGB2GrayFilter_io_deq_user; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_io_enq_last = RGB2GrayFilter_io_deq_last; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_io_deq_ready = NothingFilter_1_io_enq_ready; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_1_clock = clock;
  assign NothingFilter_1_reset = reset;
  assign NothingFilter_1_io_enq_valid = NothingFilter_io_deq_valid; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_1_io_enq_bits = NothingFilter_io_deq_bits; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_1_io_enq_user = NothingFilter_io_deq_user; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_1_io_enq_last = NothingFilter_io_deq_last; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_1_io_deq_ready = NothingFilter_2_io_enq_ready; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_2_clock = clock;
  assign NothingFilter_2_reset = reset;
  assign NothingFilter_2_io_enq_valid = NothingFilter_1_io_deq_valid; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_2_io_enq_bits = NothingFilter_1_io_deq_bits; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_2_io_enq_user = NothingFilter_1_io_deq_user; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_2_io_enq_last = NothingFilter_1_io_deq_last; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_2_io_deq_ready = NothingFilter_3_io_enq_ready; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_3_clock = clock;
  assign NothingFilter_3_reset = reset;
  assign NothingFilter_3_io_enq_valid = NothingFilter_2_io_deq_valid; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_3_io_enq_bits = NothingFilter_2_io_deq_bits; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_3_io_enq_user = NothingFilter_2_io_deq_user; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_3_io_enq_last = NothingFilter_2_io_deq_last; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_3_io_deq_ready = NothingFilter_4_io_enq_ready; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_4_clock = clock;
  assign NothingFilter_4_reset = reset;
  assign NothingFilter_4_io_enq_valid = NothingFilter_3_io_deq_valid; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_4_io_enq_bits = NothingFilter_3_io_deq_bits; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_4_io_enq_user = NothingFilter_3_io_deq_user; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_4_io_enq_last = NothingFilter_3_io_deq_last; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_4_io_deq_ready = NothingFilter_5_io_enq_ready; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_5_clock = clock;
  assign NothingFilter_5_reset = reset;
  assign NothingFilter_5_io_enq_valid = NothingFilter_4_io_deq_valid; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_5_io_enq_bits = NothingFilter_4_io_deq_bits; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_5_io_enq_user = NothingFilter_4_io_deq_user; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_5_io_enq_last = NothingFilter_4_io_deq_last; // @[ChiselImProc.scala 227:30]
  assign NothingFilter_5_io_deq_ready = Gray2RGBFilter_io_enq_ready; // @[ChiselImProc.scala 227:30]
  assign Gray2RGBFilter_clock = clock;
  assign Gray2RGBFilter_reset = reset;
  assign Gray2RGBFilter_io_enq_valid = NothingFilter_5_io_deq_valid; // @[ChiselImProc.scala 227:30]
  assign Gray2RGBFilter_io_enq_bits = {{16'd0}, NothingFilter_5_io_deq_bits}; // @[ChiselImProc.scala 227:30]
  assign Gray2RGBFilter_io_enq_user = NothingFilter_5_io_deq_user; // @[ChiselImProc.scala 227:30]
  assign Gray2RGBFilter_io_enq_last = NothingFilter_5_io_deq_last; // @[ChiselImProc.scala 227:30]
  assign Gray2RGBFilter_io_deq_ready = io_deq_ready; // @[ChiselImProc.scala 232:12]
endmodule
