`timescale 1ns / 1ps
module FtoD_stage (
	input  logic        clk,
	input  logic        rst,
	input  logic         stallonly,
	input  logic        FlushD, 
    input  logic [31:0] instr1,instr2, PCF, PCPlus8F,
	output logic stallonlyD , 
	output logic [31:0] instr1D, instr2D, PCD ,PCPlus8D
);

	always_ff @(posedge clk or negedge rst) begin
		if (!rst) begin
			instr1D <= 32'd0;
			instr2D <= 32'd0;
			PCD <= 32'd0;
			PCPlus8D <= 32'd0;
			stallonlyD<= 1'b0; 
		end

		else if (stallonly) begin
			instr1D <= instr1D;
			instr2D <= instr2D;
			PCD <= PCD;
			PCPlus8D <= PCPlus8D;
			stallonlyD<= stallonly; 
			
		end

		else if (FlushD) begin
			instr1D <= 32'd0;
			instr2D <= 32'd0;
		    PCD <= 32'd0;
			PCPlus8D <= 32'd0;
			stallonlyD<= 1'b0;
		end

		else begin
			instr1D <= instr1;
			instr2D <= instr2;
			PCD <= PCF;
			PCPlus8D <= PCPlus8F;
		    stallonlyD<= stallonly; 

		end
	end

endmodule

