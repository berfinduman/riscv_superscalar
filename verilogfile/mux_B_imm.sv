`timescale 1ns / 1ps


module mux_B_imm(input  logic ALUSrcB_E,
  input  logic [31:0] WriteDataB_E, ImmExtB_E,
  output logic [31:0] SrcB2E
  );

  assign SrcB2E = ALUSrcB_E ?  ImmExtB_E:WriteDataB_E;

endmodule