`timescale 1ns / 1ps
module Pcounter(
    input logic clk,rst,
    input logic StallF,
    input logic PCSrcA_E, PCSrcB_E,
    input logic [31:0]  PCPlus8F,PCTargetA_E,  PCTargetB_E,
    output logic [31:0] PCF 
    );
    logic [31:0] PCFirst;
    logic [1:0] PCSrcE;
    assign PCSrcE = {PCSrcA_E,PCSrcB_E};
    
                 
    always_comb begin
		
    	if (PCSrcE == 2'b10) begin PCFirst = PCSrcA_E ; end
        else if  (PCSrcE == 2'b01) begin PCFirst = PCSrcB_E;  end 
    	else begin PCFirst = PCPlus8F; end
	end
         
    always_ff @(posedge clk or negedge rst) begin
	 if (!rst)   PCF <= 32'd0;
	 else if(StallF) PCF <= PCF;
	 else            PCF <= PCFirst;
	end
endmodule
