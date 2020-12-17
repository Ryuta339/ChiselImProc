// axi4.RVCounter
// 16 bit counter
// 2020/11/20 15:31

module RVCounter(
  input         clock,
  input         reset,
  input         io_ready,
  input         io_valid,
  input         io_user,
  input         io_last,
  output [15:0] io_xoutput,
  output [15:0] io_youtput
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [15:0] xcnt; // @[RVCounter.scala 16:24]
  reg [15:0] ycnt; // @[RVCounter.scala 17:24]
  wire  _T = io_ready & io_valid; // @[RVCounter.scala 22:26]
  wire [15:0] _T_2 = ycnt + 16'h1; // @[RVCounter.scala 25:26]
  wire [15:0] _T_4 = xcnt + 16'h1; // @[RVCounter.scala 27:26]
  assign io_xoutput = xcnt; // @[RVCounter.scala 31:16]
  assign io_youtput = ycnt; // @[RVCounter.scala 32:16]
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
  xcnt = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  ycnt = _RAND_1[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      xcnt <= 16'h0;
    end else if (io_user) begin
      xcnt <= 16'h1;
    end else if (_T) begin
      if (io_last) begin
        xcnt <= 16'h0;
      end else begin
        xcnt <= _T_4;
      end
    end
    if (reset) begin
      ycnt <= 16'h0;
    end else if (io_user) begin
      ycnt <= 16'h0;
    end else if (_T) begin
      if (io_last) begin
        ycnt <= _T_2;
      end
    end
  end
endmodule
