// axi4.ImProcMain1025428811
// 2020/11/20 18:55

module NothingOneFilter(
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
`endif // RANDOMIZE_REG_INIT
  reg [1:0] stateReg; // @[ChiselImProc.scala 49:28]
  reg [23:0] dataReg; // @[ChiselImProc.scala 51:23]
  reg [23:0] shadowReg; // @[ChiselImProc.scala 53:25]
  reg  shadowUserReg; // @[ChiselImProc.scala 55:29]
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
  assign io_deq_user = io_enq_user; // @[ChiselImProc.scala 37:17 ChiselImProc.scala 116:17]
  assign io_deq_last = io_enq_last; // @[ChiselImProc.scala 36:17 ChiselImProc.scala 115:17]
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
  shadowUserReg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  shadowLastReg = _RAND_4[0:0];
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
  wire  NothingOneFilter_clock; // @[ChiselImProc.scala 242:47]
  wire  NothingOneFilter_reset; // @[ChiselImProc.scala 242:47]
  wire  NothingOneFilter_io_enq_ready; // @[ChiselImProc.scala 242:47]
  wire  NothingOneFilter_io_enq_valid; // @[ChiselImProc.scala 242:47]
  wire [23:0] NothingOneFilter_io_enq_bits; // @[ChiselImProc.scala 242:47]
  wire  NothingOneFilter_io_enq_user; // @[ChiselImProc.scala 242:47]
  wire  NothingOneFilter_io_enq_last; // @[ChiselImProc.scala 242:47]
  wire  NothingOneFilter_io_deq_ready; // @[ChiselImProc.scala 242:47]
  wire  NothingOneFilter_io_deq_valid; // @[ChiselImProc.scala 242:47]
  wire [23:0] NothingOneFilter_io_deq_bits; // @[ChiselImProc.scala 242:47]
  wire  NothingOneFilter_io_deq_user; // @[ChiselImProc.scala 242:47]
  wire  NothingOneFilter_io_deq_last; // @[ChiselImProc.scala 242:47]
  wire [1:0] NothingOneFilter_io_state_reg; // @[ChiselImProc.scala 242:47]
  wire [23:0] NothingOneFilter_io_shadow_reg; // @[ChiselImProc.scala 242:47]
  wire  NothingOneFilter_io_shadow_user; // @[ChiselImProc.scala 242:47]
  wire  NothingOneFilter_io_shadow_last; // @[ChiselImProc.scala 242:47]
  NothingOneFilter NothingOneFilter ( // @[ChiselImProc.scala 242:47]
    .clock(NothingOneFilter_clock),
    .reset(NothingOneFilter_reset),
    .io_enq_ready(NothingOneFilter_io_enq_ready),
    .io_enq_valid(NothingOneFilter_io_enq_valid),
    .io_enq_bits(NothingOneFilter_io_enq_bits),
    .io_enq_user(NothingOneFilter_io_enq_user),
    .io_enq_last(NothingOneFilter_io_enq_last),
    .io_deq_ready(NothingOneFilter_io_deq_ready),
    .io_deq_valid(NothingOneFilter_io_deq_valid),
    .io_deq_bits(NothingOneFilter_io_deq_bits),
    .io_deq_user(NothingOneFilter_io_deq_user),
    .io_deq_last(NothingOneFilter_io_deq_last),
    .io_state_reg(NothingOneFilter_io_state_reg),
    .io_shadow_reg(NothingOneFilter_io_shadow_reg),
    .io_shadow_user(NothingOneFilter_io_shadow_user),
    .io_shadow_last(NothingOneFilter_io_shadow_last)
  );
  assign io_enq_ready = NothingOneFilter_io_enq_ready; // @[ChiselImProc.scala 249:12]
  assign io_deq_valid = NothingOneFilter_io_deq_valid; // @[ChiselImProc.scala 251:12]
  assign io_deq_bits = NothingOneFilter_io_deq_bits; // @[ChiselImProc.scala 251:12]
  assign io_deq_user = NothingOneFilter_io_deq_user; // @[ChiselImProc.scala 251:12]
  assign io_deq_last = NothingOneFilter_io_deq_last; // @[ChiselImProc.scala 251:12]
  assign io_state_reg = NothingOneFilter_io_state_reg; // @[ChiselImProc.scala 253:18]
  assign io_shadow_reg = NothingOneFilter_io_shadow_reg; // @[ChiselImProc.scala 254:19]
  assign io_shadow_user = NothingOneFilter_io_shadow_user; // @[ChiselImProc.scala 255:20]
  assign io_shadow_last = NothingOneFilter_io_shadow_last; // @[ChiselImProc.scala 256:20]
  assign NothingOneFilter_clock = clock;
  assign NothingOneFilter_reset = reset;
  assign NothingOneFilter_io_enq_valid = io_enq_valid; // @[ChiselImProc.scala 249:12]
  assign NothingOneFilter_io_enq_bits = io_enq_bits; // @[ChiselImProc.scala 249:12]
  assign NothingOneFilter_io_enq_user = io_enq_user; // @[ChiselImProc.scala 249:12]
  assign NothingOneFilter_io_enq_last = io_enq_last; // @[ChiselImProc.scala 249:12]
  assign NothingOneFilter_io_deq_ready = io_deq_ready; // @[ChiselImProc.scala 251:12]
endmodule
