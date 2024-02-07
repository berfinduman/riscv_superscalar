`timescale 1ns / 1ps

module PcPlus8(
    input logic [31:0] PCF,
    output logic  [31:0] PCPlus8F
    );
    assign PCPlus8F= PCF+8; 
endmodule
