module extendB (
  input  logic [24:0] ImmB,
  input  logic [2:0]  ImmSrcB_D,
  output logic [31:0] ImmExtB_D
);

  always_comb begin
    casex(ImmSrcB_D)
    // I Type
    3'b000:   ImmExtB_D = {{20{ImmB[24]}}, ImmB[24:13]};
    // S Type
    3'b001:   ImmExtB_D = {{20{ImmB[24]}}, ImmB[24:18], ImmB[4:0]};
    // B Type
    3'b010:   ImmExtB_D = {{20{ImmB[24]}}, ImmB[0],  ImmB[23:18], ImmB[4:1], 1'b0};
    // J Type
    3'b011:   ImmExtB_D = {{12{ImmB[24]}}, ImmB[12:5],  ImmB[13], ImmB[23:14], 1'b0};
    // U Type
    3'b100:   ImmExtB_D = {ImmB[24:5],12'b000000000000};
    default: 	ImmExtB_D = 32'dx; // undefined
    endcase
  end

endmodule