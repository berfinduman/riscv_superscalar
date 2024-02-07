`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module extendA(

  input  logic [24:0] ImmA,
  input  logic [2:0]  ImmSrcA_D,
  output logic [31:0] ImmExtA_D
);

  always_comb begin
    casex(ImmSrcA_D)
    // I Type
    3'b000:   ImmExtA_D = {{20{ImmA[24]}}, ImmA[24:13]};
    // S Type
    3'b001:   ImmExtA_D = {{20{ImmA[24]}}, ImmA[24:18], ImmA[4:0]};
    // B Type
    3'b010:   ImmExtA_D = {{20{ImmA[24]}}, ImmA[0],  ImmA[23:18], ImmA[4:1], 1'b0};
    // J Type
    3'b011:   ImmExtA_D = {{12{ImmA[24]}}, ImmA[12:5],  ImmA[13], ImmA[23:14], 1'b0};
    // U Type
    3'b100:   ImmExtA_D = {ImmA[24:5],12'b000000000000};
    default: 	ImmExtA_D = 32'dx; // undefined
    endcase
  end

endmodule
