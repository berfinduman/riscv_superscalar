`timescale 1ns / 1ps


module mux_A_imm(input  logic ALUSrcA_E,
  input  logic [31:0] WriteDataA_E, ImmExtA_E,
  output logic [31:0] SrcA2E
  );

  assign SrcA2E = ALUSrcA_E ?  ImmExtA_E:WriteDataA_E;

endmodule