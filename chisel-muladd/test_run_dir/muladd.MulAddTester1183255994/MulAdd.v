module MulAdd(
  input         clock,
  input         reset,
  input  [31:0] io_a_0,
  input  [31:0] io_a_1,
  input  [31:0] io_a_2,
  input  [31:0] io_a_3,
  input  [31:0] io_a_4,
  input  [31:0] io_a_5,
  input  [31:0] io_a_6,
  input  [31:0] io_a_7,
  input  [31:0] io_a_8,
  input  [31:0] io_a_9,
  input  [31:0] io_a_10,
  input  [31:0] io_a_11,
  input  [31:0] io_a_12,
  input  [31:0] io_a_13,
  input  [31:0] io_a_14,
  input  [31:0] io_a_15,
  input  [31:0] io_b_0,
  input  [31:0] io_b_1,
  input  [31:0] io_b_2,
  input  [31:0] io_b_3,
  input  [31:0] io_b_4,
  input  [31:0] io_b_5,
  input  [31:0] io_b_6,
  input  [31:0] io_b_7,
  input  [31:0] io_b_8,
  input  [31:0] io_b_9,
  input  [31:0] io_b_10,
  input  [31:0] io_b_11,
  input  [31:0] io_b_12,
  input  [31:0] io_b_13,
  input  [31:0] io_b_14,
  input  [31:0] io_b_15,
  output [31:0] io_output
);
  wire [63:0] _T = io_a_0 * io_b_0; // @[MulAdd.scala 15:24]
  wire [64:0] _T_1 = {{1'd0}, _T}; // @[MulAdd.scala 15:13]
  wire [63:0] _T_3 = io_a_1 * io_b_1; // @[MulAdd.scala 15:24]
  wire [63:0] _T_5 = _T_1[63:0] + _T_3; // @[MulAdd.scala 15:13]
  wire [63:0] _T_6 = io_a_2 * io_b_2; // @[MulAdd.scala 15:24]
  wire [63:0] _T_8 = _T_5 + _T_6; // @[MulAdd.scala 15:13]
  wire [63:0] _T_9 = io_a_3 * io_b_3; // @[MulAdd.scala 15:24]
  wire [63:0] _T_11 = _T_8 + _T_9; // @[MulAdd.scala 15:13]
  wire [63:0] _T_12 = io_a_4 * io_b_4; // @[MulAdd.scala 15:24]
  wire [63:0] _T_14 = _T_11 + _T_12; // @[MulAdd.scala 15:13]
  wire [63:0] _T_15 = io_a_5 * io_b_5; // @[MulAdd.scala 15:24]
  wire [63:0] _T_17 = _T_14 + _T_15; // @[MulAdd.scala 15:13]
  wire [63:0] _T_18 = io_a_6 * io_b_6; // @[MulAdd.scala 15:24]
  wire [63:0] _T_20 = _T_17 + _T_18; // @[MulAdd.scala 15:13]
  wire [63:0] _T_21 = io_a_7 * io_b_7; // @[MulAdd.scala 15:24]
  wire [63:0] _T_23 = _T_20 + _T_21; // @[MulAdd.scala 15:13]
  wire [63:0] _T_24 = io_a_8 * io_b_8; // @[MulAdd.scala 15:24]
  wire [63:0] _T_26 = _T_23 + _T_24; // @[MulAdd.scala 15:13]
  wire [63:0] _T_27 = io_a_9 * io_b_9; // @[MulAdd.scala 15:24]
  wire [63:0] _T_29 = _T_26 + _T_27; // @[MulAdd.scala 15:13]
  wire [63:0] _T_30 = io_a_10 * io_b_10; // @[MulAdd.scala 15:24]
  wire [63:0] _T_32 = _T_29 + _T_30; // @[MulAdd.scala 15:13]
  wire [63:0] _T_33 = io_a_11 * io_b_11; // @[MulAdd.scala 15:24]
  wire [63:0] _T_35 = _T_32 + _T_33; // @[MulAdd.scala 15:13]
  wire [63:0] _T_36 = io_a_12 * io_b_12; // @[MulAdd.scala 15:24]
  wire [63:0] _T_38 = _T_35 + _T_36; // @[MulAdd.scala 15:13]
  wire [63:0] _T_39 = io_a_13 * io_b_13; // @[MulAdd.scala 15:24]
  wire [63:0] _T_41 = _T_38 + _T_39; // @[MulAdd.scala 15:13]
  wire [63:0] _T_42 = io_a_14 * io_b_14; // @[MulAdd.scala 15:24]
  wire [63:0] _T_44 = _T_41 + _T_42; // @[MulAdd.scala 15:13]
  wire [63:0] _T_45 = io_a_15 * io_b_15; // @[MulAdd.scala 15:24]
  wire [63:0] tmp = _T_44 + _T_45; // @[MulAdd.scala 15:13]
  assign io_output = tmp[31:0]; // @[MulAdd.scala 18:15]
endmodule
