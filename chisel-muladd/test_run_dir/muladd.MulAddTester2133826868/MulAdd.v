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
  wire [63:0] _T = $signed(io_a_0) * $signed(io_b_0); // @[MulAdd.scala 15:24]
  wire [64:0] _T_1 = {{1{_T[63]}},_T}; // @[MulAdd.scala 15:13]
  wire [63:0] _T_3 = _T_1[63:0]; // @[MulAdd.scala 15:13]
  wire [63:0] _T_4 = $signed(io_a_1) * $signed(io_b_1); // @[MulAdd.scala 15:24]
  wire [63:0] _T_7 = $signed(_T_3) + $signed(_T_4); // @[MulAdd.scala 15:13]
  wire [63:0] _T_8 = $signed(io_a_2) * $signed(io_b_2); // @[MulAdd.scala 15:24]
  wire [63:0] _T_11 = $signed(_T_7) + $signed(_T_8); // @[MulAdd.scala 15:13]
  wire [63:0] _T_12 = $signed(io_a_3) * $signed(io_b_3); // @[MulAdd.scala 15:24]
  wire [63:0] _T_15 = $signed(_T_11) + $signed(_T_12); // @[MulAdd.scala 15:13]
  wire [63:0] _T_16 = $signed(io_a_4) * $signed(io_b_4); // @[MulAdd.scala 15:24]
  wire [63:0] _T_19 = $signed(_T_15) + $signed(_T_16); // @[MulAdd.scala 15:13]
  wire [63:0] _T_20 = $signed(io_a_5) * $signed(io_b_5); // @[MulAdd.scala 15:24]
  wire [63:0] _T_23 = $signed(_T_19) + $signed(_T_20); // @[MulAdd.scala 15:13]
  wire [63:0] _T_24 = $signed(io_a_6) * $signed(io_b_6); // @[MulAdd.scala 15:24]
  wire [63:0] _T_27 = $signed(_T_23) + $signed(_T_24); // @[MulAdd.scala 15:13]
  wire [63:0] _T_28 = $signed(io_a_7) * $signed(io_b_7); // @[MulAdd.scala 15:24]
  wire [63:0] _T_31 = $signed(_T_27) + $signed(_T_28); // @[MulAdd.scala 15:13]
  wire [63:0] _T_32 = $signed(io_a_8) * $signed(io_b_8); // @[MulAdd.scala 15:24]
  wire [63:0] _T_35 = $signed(_T_31) + $signed(_T_32); // @[MulAdd.scala 15:13]
  wire [63:0] _T_36 = $signed(io_a_9) * $signed(io_b_9); // @[MulAdd.scala 15:24]
  wire [63:0] _T_39 = $signed(_T_35) + $signed(_T_36); // @[MulAdd.scala 15:13]
  wire [63:0] _T_40 = $signed(io_a_10) * $signed(io_b_10); // @[MulAdd.scala 15:24]
  wire [63:0] _T_43 = $signed(_T_39) + $signed(_T_40); // @[MulAdd.scala 15:13]
  wire [63:0] _T_44 = $signed(io_a_11) * $signed(io_b_11); // @[MulAdd.scala 15:24]
  wire [63:0] _T_47 = $signed(_T_43) + $signed(_T_44); // @[MulAdd.scala 15:13]
  wire [63:0] _T_48 = $signed(io_a_12) * $signed(io_b_12); // @[MulAdd.scala 15:24]
  wire [63:0] _T_51 = $signed(_T_47) + $signed(_T_48); // @[MulAdd.scala 15:13]
  wire [63:0] _T_52 = $signed(io_a_13) * $signed(io_b_13); // @[MulAdd.scala 15:24]
  wire [63:0] _T_55 = $signed(_T_51) + $signed(_T_52); // @[MulAdd.scala 15:13]
  wire [63:0] _T_56 = $signed(io_a_14) * $signed(io_b_14); // @[MulAdd.scala 15:24]
  wire [63:0] _T_59 = $signed(_T_55) + $signed(_T_56); // @[MulAdd.scala 15:13]
  wire [63:0] _T_60 = $signed(io_a_15) * $signed(io_b_15); // @[MulAdd.scala 15:24]
  wire [63:0] tmp = $signed(_T_59) + $signed(_T_60); // @[MulAdd.scala 15:13]
  assign io_output = tmp[31:0]; // @[MulAdd.scala 18:15]
endmodule
