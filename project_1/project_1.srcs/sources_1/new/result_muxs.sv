`timescale 1ns / 1ps
module mux_resultA(
  input  logic [31:0] ALUResultA_W, PCPlus8W,
  input  logic [1:0]       ResultSrcA_W,
  output logic [31:0] ResultA_W
  );

always_comb begin

  case(ResultSrcA_W)

  2'b00:  ResultA_W =ALUResultA_W;
  2'b10:  ResultA_W =PCPlus8W;

  default: ResultA_W = ALUResultA_W;
endcase
end

endmodule

module mux_resultB (
  input  logic [31:0] ALUResultB_W, ReadDataB_W, PCPlus8W,
  input  logic [1:0]       ResultSrcB_W,
  output logic [31:0] ResultB_W
  );

 // assign ResultW = ResultSrcW[1] ? PCPlus4W : (ResultSrcW[0] ? ReadDataW : ALUResultW);
always_comb begin

  case(ResultSrcB_W)

  2'b00:  ResultB_W =ALUResultB_W;
  2'b01:  ResultB_W =ReadDataB_W;
  2'b10:  ResultB_W =PCPlus8W;

  default: ResultB_W = ReadDataB_W;
endcase
end

endmodule

