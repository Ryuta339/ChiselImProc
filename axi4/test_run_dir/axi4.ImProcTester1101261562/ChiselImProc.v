module ImageFilter(
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
  wire  _T_4 = io_deq_ready & io_enq_valid; // @[ChiselImProc.scala 71:38]
  wire  _T_5 = ~io_deq_ready; // @[ChiselImProc.scala 76:25]
  wire  _T_6 = _T_5 & io_enq_valid; // @[ChiselImProc.scala 76:39]
  wire  _T_7 = 2'h2 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_8 = 2'h3 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_9 = stateReg == 2'h0; // @[ChiselImProc.scala 100:31]
  wire  _T_10 = stateReg == 2'h1; // @[ChiselImProc.scala 100:53]
  wire  _T_11 = _T_9 | _T_10; // @[ChiselImProc.scala 100:41]
  wire  _T_12 = stateReg == 2'h3; // @[ChiselImProc.scala 100:73]
  wire  _T_15 = stateReg == 2'h2; // @[ChiselImProc.scala 101:51]
  assign io_enq_ready = _T_11 | _T_12; // @[ChiselImProc.scala 100:18]
  assign io_deq_valid = _T_10 | _T_15; // @[ChiselImProc.scala 101:18]
  assign io_deq_bits = dataReg; // @[ChiselImProc.scala 117:17]
  assign io_deq_user = userReg; // @[ChiselImProc.scala 37:17 ChiselImProc.scala 98:17]
  assign io_deq_last = lastReg; // @[ChiselImProc.scala 36:17 ChiselImProc.scala 97:17]
  assign io_state_reg = stateReg; // @[ChiselImProc.scala 103:18]
  assign io_shadow_reg = shadowReg; // @[ChiselImProc.scala 104:19]
  assign io_shadow_user = shadowUserReg; // @[ChiselImProc.scala 105:20]
  assign io_shadow_last = shadowLastReg; // @[ChiselImProc.scala 106:20]
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
  wire  ImageFilter_clock; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_reset; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_io_enq_ready; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_io_enq_valid; // @[ChiselImProc.scala 242:47]
  wire [23:0] ImageFilter_io_enq_bits; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_io_enq_user; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_io_enq_last; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_io_deq_ready; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_io_deq_valid; // @[ChiselImProc.scala 242:47]
  wire [23:0] ImageFilter_io_deq_bits; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_io_deq_user; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_io_deq_last; // @[ChiselImProc.scala 242:47]
  wire [1:0] ImageFilter_io_state_reg; // @[ChiselImProc.scala 242:47]
  wire [23:0] ImageFilter_io_shadow_reg; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_io_shadow_user; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_io_shadow_last; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_1_clock; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_1_reset; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_1_io_enq_ready; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_1_io_enq_valid; // @[ChiselImProc.scala 242:47]
  wire [23:0] ImageFilter_1_io_enq_bits; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_1_io_enq_user; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_1_io_enq_last; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_1_io_deq_ready; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_1_io_deq_valid; // @[ChiselImProc.scala 242:47]
  wire [23:0] ImageFilter_1_io_deq_bits; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_1_io_deq_user; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_1_io_deq_last; // @[ChiselImProc.scala 242:47]
  wire [1:0] ImageFilter_1_io_state_reg; // @[ChiselImProc.scala 242:47]
  wire [23:0] ImageFilter_1_io_shadow_reg; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_1_io_shadow_user; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_1_io_shadow_last; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_2_clock; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_2_reset; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_2_io_enq_ready; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_2_io_enq_valid; // @[ChiselImProc.scala 242:47]
  wire [23:0] ImageFilter_2_io_enq_bits; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_2_io_enq_user; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_2_io_enq_last; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_2_io_deq_ready; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_2_io_deq_valid; // @[ChiselImProc.scala 242:47]
  wire [23:0] ImageFilter_2_io_deq_bits; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_2_io_deq_user; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_2_io_deq_last; // @[ChiselImProc.scala 242:47]
  wire [1:0] ImageFilter_2_io_state_reg; // @[ChiselImProc.scala 242:47]
  wire [23:0] ImageFilter_2_io_shadow_reg; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_2_io_shadow_user; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_2_io_shadow_last; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_3_clock; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_3_reset; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_3_io_enq_ready; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_3_io_enq_valid; // @[ChiselImProc.scala 242:47]
  wire [23:0] ImageFilter_3_io_enq_bits; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_3_io_enq_user; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_3_io_enq_last; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_3_io_deq_ready; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_3_io_deq_valid; // @[ChiselImProc.scala 242:47]
  wire [23:0] ImageFilter_3_io_deq_bits; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_3_io_deq_user; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_3_io_deq_last; // @[ChiselImProc.scala 242:47]
  wire [1:0] ImageFilter_3_io_state_reg; // @[ChiselImProc.scala 242:47]
  wire [23:0] ImageFilter_3_io_shadow_reg; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_3_io_shadow_user; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_3_io_shadow_last; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_4_clock; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_4_reset; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_4_io_enq_ready; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_4_io_enq_valid; // @[ChiselImProc.scala 242:47]
  wire [23:0] ImageFilter_4_io_enq_bits; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_4_io_enq_user; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_4_io_enq_last; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_4_io_deq_ready; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_4_io_deq_valid; // @[ChiselImProc.scala 242:47]
  wire [23:0] ImageFilter_4_io_deq_bits; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_4_io_deq_user; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_4_io_deq_last; // @[ChiselImProc.scala 242:47]
  wire [1:0] ImageFilter_4_io_state_reg; // @[ChiselImProc.scala 242:47]
  wire [23:0] ImageFilter_4_io_shadow_reg; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_4_io_shadow_user; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_4_io_shadow_last; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_5_clock; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_5_reset; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_5_io_enq_ready; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_5_io_enq_valid; // @[ChiselImProc.scala 242:47]
  wire [23:0] ImageFilter_5_io_enq_bits; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_5_io_enq_user; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_5_io_enq_last; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_5_io_deq_ready; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_5_io_deq_valid; // @[ChiselImProc.scala 242:47]
  wire [23:0] ImageFilter_5_io_deq_bits; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_5_io_deq_user; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_5_io_deq_last; // @[ChiselImProc.scala 242:47]
  wire [1:0] ImageFilter_5_io_state_reg; // @[ChiselImProc.scala 242:47]
  wire [23:0] ImageFilter_5_io_shadow_reg; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_5_io_shadow_user; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_5_io_shadow_last; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_6_clock; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_6_reset; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_6_io_enq_ready; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_6_io_enq_valid; // @[ChiselImProc.scala 242:47]
  wire [23:0] ImageFilter_6_io_enq_bits; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_6_io_enq_user; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_6_io_enq_last; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_6_io_deq_ready; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_6_io_deq_valid; // @[ChiselImProc.scala 242:47]
  wire [23:0] ImageFilter_6_io_deq_bits; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_6_io_deq_user; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_6_io_deq_last; // @[ChiselImProc.scala 242:47]
  wire [1:0] ImageFilter_6_io_state_reg; // @[ChiselImProc.scala 242:47]
  wire [23:0] ImageFilter_6_io_shadow_reg; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_6_io_shadow_user; // @[ChiselImProc.scala 242:47]
  wire  ImageFilter_6_io_shadow_last; // @[ChiselImProc.scala 242:47]
  ImageFilter ImageFilter ( // @[ChiselImProc.scala 242:47]
    .clock(ImageFilter_clock),
    .reset(ImageFilter_reset),
    .io_enq_ready(ImageFilter_io_enq_ready),
    .io_enq_valid(ImageFilter_io_enq_valid),
    .io_enq_bits(ImageFilter_io_enq_bits),
    .io_enq_user(ImageFilter_io_enq_user),
    .io_enq_last(ImageFilter_io_enq_last),
    .io_deq_ready(ImageFilter_io_deq_ready),
    .io_deq_valid(ImageFilter_io_deq_valid),
    .io_deq_bits(ImageFilter_io_deq_bits),
    .io_deq_user(ImageFilter_io_deq_user),
    .io_deq_last(ImageFilter_io_deq_last),
    .io_state_reg(ImageFilter_io_state_reg),
    .io_shadow_reg(ImageFilter_io_shadow_reg),
    .io_shadow_user(ImageFilter_io_shadow_user),
    .io_shadow_last(ImageFilter_io_shadow_last)
  );
  ImageFilter ImageFilter_1 ( // @[ChiselImProc.scala 242:47]
    .clock(ImageFilter_1_clock),
    .reset(ImageFilter_1_reset),
    .io_enq_ready(ImageFilter_1_io_enq_ready),
    .io_enq_valid(ImageFilter_1_io_enq_valid),
    .io_enq_bits(ImageFilter_1_io_enq_bits),
    .io_enq_user(ImageFilter_1_io_enq_user),
    .io_enq_last(ImageFilter_1_io_enq_last),
    .io_deq_ready(ImageFilter_1_io_deq_ready),
    .io_deq_valid(ImageFilter_1_io_deq_valid),
    .io_deq_bits(ImageFilter_1_io_deq_bits),
    .io_deq_user(ImageFilter_1_io_deq_user),
    .io_deq_last(ImageFilter_1_io_deq_last),
    .io_state_reg(ImageFilter_1_io_state_reg),
    .io_shadow_reg(ImageFilter_1_io_shadow_reg),
    .io_shadow_user(ImageFilter_1_io_shadow_user),
    .io_shadow_last(ImageFilter_1_io_shadow_last)
  );
  ImageFilter ImageFilter_2 ( // @[ChiselImProc.scala 242:47]
    .clock(ImageFilter_2_clock),
    .reset(ImageFilter_2_reset),
    .io_enq_ready(ImageFilter_2_io_enq_ready),
    .io_enq_valid(ImageFilter_2_io_enq_valid),
    .io_enq_bits(ImageFilter_2_io_enq_bits),
    .io_enq_user(ImageFilter_2_io_enq_user),
    .io_enq_last(ImageFilter_2_io_enq_last),
    .io_deq_ready(ImageFilter_2_io_deq_ready),
    .io_deq_valid(ImageFilter_2_io_deq_valid),
    .io_deq_bits(ImageFilter_2_io_deq_bits),
    .io_deq_user(ImageFilter_2_io_deq_user),
    .io_deq_last(ImageFilter_2_io_deq_last),
    .io_state_reg(ImageFilter_2_io_state_reg),
    .io_shadow_reg(ImageFilter_2_io_shadow_reg),
    .io_shadow_user(ImageFilter_2_io_shadow_user),
    .io_shadow_last(ImageFilter_2_io_shadow_last)
  );
  ImageFilter ImageFilter_3 ( // @[ChiselImProc.scala 242:47]
    .clock(ImageFilter_3_clock),
    .reset(ImageFilter_3_reset),
    .io_enq_ready(ImageFilter_3_io_enq_ready),
    .io_enq_valid(ImageFilter_3_io_enq_valid),
    .io_enq_bits(ImageFilter_3_io_enq_bits),
    .io_enq_user(ImageFilter_3_io_enq_user),
    .io_enq_last(ImageFilter_3_io_enq_last),
    .io_deq_ready(ImageFilter_3_io_deq_ready),
    .io_deq_valid(ImageFilter_3_io_deq_valid),
    .io_deq_bits(ImageFilter_3_io_deq_bits),
    .io_deq_user(ImageFilter_3_io_deq_user),
    .io_deq_last(ImageFilter_3_io_deq_last),
    .io_state_reg(ImageFilter_3_io_state_reg),
    .io_shadow_reg(ImageFilter_3_io_shadow_reg),
    .io_shadow_user(ImageFilter_3_io_shadow_user),
    .io_shadow_last(ImageFilter_3_io_shadow_last)
  );
  ImageFilter ImageFilter_4 ( // @[ChiselImProc.scala 242:47]
    .clock(ImageFilter_4_clock),
    .reset(ImageFilter_4_reset),
    .io_enq_ready(ImageFilter_4_io_enq_ready),
    .io_enq_valid(ImageFilter_4_io_enq_valid),
    .io_enq_bits(ImageFilter_4_io_enq_bits),
    .io_enq_user(ImageFilter_4_io_enq_user),
    .io_enq_last(ImageFilter_4_io_enq_last),
    .io_deq_ready(ImageFilter_4_io_deq_ready),
    .io_deq_valid(ImageFilter_4_io_deq_valid),
    .io_deq_bits(ImageFilter_4_io_deq_bits),
    .io_deq_user(ImageFilter_4_io_deq_user),
    .io_deq_last(ImageFilter_4_io_deq_last),
    .io_state_reg(ImageFilter_4_io_state_reg),
    .io_shadow_reg(ImageFilter_4_io_shadow_reg),
    .io_shadow_user(ImageFilter_4_io_shadow_user),
    .io_shadow_last(ImageFilter_4_io_shadow_last)
  );
  ImageFilter ImageFilter_5 ( // @[ChiselImProc.scala 242:47]
    .clock(ImageFilter_5_clock),
    .reset(ImageFilter_5_reset),
    .io_enq_ready(ImageFilter_5_io_enq_ready),
    .io_enq_valid(ImageFilter_5_io_enq_valid),
    .io_enq_bits(ImageFilter_5_io_enq_bits),
    .io_enq_user(ImageFilter_5_io_enq_user),
    .io_enq_last(ImageFilter_5_io_enq_last),
    .io_deq_ready(ImageFilter_5_io_deq_ready),
    .io_deq_valid(ImageFilter_5_io_deq_valid),
    .io_deq_bits(ImageFilter_5_io_deq_bits),
    .io_deq_user(ImageFilter_5_io_deq_user),
    .io_deq_last(ImageFilter_5_io_deq_last),
    .io_state_reg(ImageFilter_5_io_state_reg),
    .io_shadow_reg(ImageFilter_5_io_shadow_reg),
    .io_shadow_user(ImageFilter_5_io_shadow_user),
    .io_shadow_last(ImageFilter_5_io_shadow_last)
  );
  ImageFilter ImageFilter_6 ( // @[ChiselImProc.scala 242:47]
    .clock(ImageFilter_6_clock),
    .reset(ImageFilter_6_reset),
    .io_enq_ready(ImageFilter_6_io_enq_ready),
    .io_enq_valid(ImageFilter_6_io_enq_valid),
    .io_enq_bits(ImageFilter_6_io_enq_bits),
    .io_enq_user(ImageFilter_6_io_enq_user),
    .io_enq_last(ImageFilter_6_io_enq_last),
    .io_deq_ready(ImageFilter_6_io_deq_ready),
    .io_deq_valid(ImageFilter_6_io_deq_valid),
    .io_deq_bits(ImageFilter_6_io_deq_bits),
    .io_deq_user(ImageFilter_6_io_deq_user),
    .io_deq_last(ImageFilter_6_io_deq_last),
    .io_state_reg(ImageFilter_6_io_state_reg),
    .io_shadow_reg(ImageFilter_6_io_shadow_reg),
    .io_shadow_user(ImageFilter_6_io_shadow_user),
    .io_shadow_last(ImageFilter_6_io_shadow_last)
  );
  assign io_enq_ready = ImageFilter_io_enq_ready; // @[ChiselImProc.scala 249:12]
  assign io_deq_valid = ImageFilter_6_io_deq_valid; // @[ChiselImProc.scala 251:12]
  assign io_deq_bits = ImageFilter_6_io_deq_bits; // @[ChiselImProc.scala 251:12]
  assign io_deq_user = ImageFilter_6_io_deq_user; // @[ChiselImProc.scala 251:12]
  assign io_deq_last = ImageFilter_6_io_deq_last; // @[ChiselImProc.scala 251:12]
  assign io_state_reg = ImageFilter_6_io_state_reg; // @[ChiselImProc.scala 253:18]
  assign io_shadow_reg = ImageFilter_6_io_shadow_reg; // @[ChiselImProc.scala 254:19]
  assign io_shadow_user = ImageFilter_6_io_shadow_user; // @[ChiselImProc.scala 255:20]
  assign io_shadow_last = ImageFilter_6_io_shadow_last; // @[ChiselImProc.scala 256:20]
  assign ImageFilter_clock = clock;
  assign ImageFilter_reset = reset;
  assign ImageFilter_io_enq_valid = io_enq_valid; // @[ChiselImProc.scala 249:12]
  assign ImageFilter_io_enq_bits = io_enq_bits; // @[ChiselImProc.scala 249:12]
  assign ImageFilter_io_enq_user = io_enq_user; // @[ChiselImProc.scala 249:12]
  assign ImageFilter_io_enq_last = io_enq_last; // @[ChiselImProc.scala 249:12]
  assign ImageFilter_io_deq_ready = ImageFilter_1_io_enq_ready; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_1_clock = clock;
  assign ImageFilter_1_reset = reset;
  assign ImageFilter_1_io_enq_valid = ImageFilter_io_deq_valid; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_1_io_enq_bits = ImageFilter_io_deq_bits; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_1_io_enq_user = ImageFilter_io_deq_user; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_1_io_enq_last = ImageFilter_io_deq_last; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_1_io_deq_ready = ImageFilter_2_io_enq_ready; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_2_clock = clock;
  assign ImageFilter_2_reset = reset;
  assign ImageFilter_2_io_enq_valid = ImageFilter_1_io_deq_valid; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_2_io_enq_bits = ImageFilter_1_io_deq_bits; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_2_io_enq_user = ImageFilter_1_io_deq_user; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_2_io_enq_last = ImageFilter_1_io_deq_last; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_2_io_deq_ready = ImageFilter_3_io_enq_ready; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_3_clock = clock;
  assign ImageFilter_3_reset = reset;
  assign ImageFilter_3_io_enq_valid = ImageFilter_2_io_deq_valid; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_3_io_enq_bits = ImageFilter_2_io_deq_bits; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_3_io_enq_user = ImageFilter_2_io_deq_user; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_3_io_enq_last = ImageFilter_2_io_deq_last; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_3_io_deq_ready = ImageFilter_4_io_enq_ready; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_4_clock = clock;
  assign ImageFilter_4_reset = reset;
  assign ImageFilter_4_io_enq_valid = ImageFilter_3_io_deq_valid; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_4_io_enq_bits = ImageFilter_3_io_deq_bits; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_4_io_enq_user = ImageFilter_3_io_deq_user; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_4_io_enq_last = ImageFilter_3_io_deq_last; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_4_io_deq_ready = ImageFilter_5_io_enq_ready; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_5_clock = clock;
  assign ImageFilter_5_reset = reset;
  assign ImageFilter_5_io_enq_valid = ImageFilter_4_io_deq_valid; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_5_io_enq_bits = ImageFilter_4_io_deq_bits; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_5_io_enq_user = ImageFilter_4_io_deq_user; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_5_io_enq_last = ImageFilter_4_io_deq_last; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_5_io_deq_ready = ImageFilter_6_io_enq_ready; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_6_clock = clock;
  assign ImageFilter_6_reset = reset;
  assign ImageFilter_6_io_enq_valid = ImageFilter_5_io_deq_valid; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_6_io_enq_bits = ImageFilter_5_io_deq_bits; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_6_io_enq_user = ImageFilter_5_io_deq_user; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_6_io_enq_last = ImageFilter_5_io_deq_last; // @[ChiselImProc.scala 246:30]
  assign ImageFilter_6_io_deq_ready = io_deq_ready; // @[ChiselImProc.scala 251:12]
endmodule
