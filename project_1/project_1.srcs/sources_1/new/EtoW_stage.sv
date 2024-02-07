`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module EtoW_stage(
input logic clk,rst,RegWriteA_E, RegWriteB_E,
input logic [1:0] ResultSrcA_E,ResultSrcB_E,order_E,
input logic [31:0] ALUResultA_E, ALUResultB_E, ReadDataB_E, PCPlus8E,
input logic [4:0] RdA_E,RdB_E,
output logic [4:0] RdA_W, RdB_W,
output logic [31:0] ALUResultA_W, ALUResultB_W,ReadDataB_W, PCPlus8W,
output logic [1:0] ResultSrcA_W,ResultSrcB_W,order_W,
output logic RegWriteA_W,RegWriteB_W);

always_ff @( posedge clk or negedge rst) begin
    if(!rst) begin
      ALUResultA_W <= 32'd0; ALUResultB_W <= 32'd0;
      ReadDataB_W <= 32'd0;
      PCPlus8W <= 32'd0;
      RdA_W <= 5'd0;  RdB_W<= 5'd0; 
      ResultSrcA_W <= 2'd0; ResultSrcB_W <= 2'd0;
      RegWriteA_W <= 0; RegWriteB_W <= 0;
      order_W<=2'b0;
    end else begin
      ALUResultA_W <= ALUResultA_E; ALUResultB_W <= ALUResultB_E;
      ReadDataB_W <= ReadDataB_E;
      PCPlus8W <= PCPlus8E;
      RdA_W <= RdA_E;  RdB_W<=RdB_E; 
      ResultSrcA_W <=ResultSrcA_E; ResultSrcB_W <= ResultSrcB_E;
      RegWriteA_W <= RegWriteA_E; RegWriteB_W <= RegWriteB_E;
      order_W<=order_E;
    end

  end

endmodule


