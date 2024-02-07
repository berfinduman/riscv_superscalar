`timescale 1ns / 1ps

module data_memory  #(
  parameter DMemInitFile ="dmem.mem")
  (
  input  logic        clk, rst, MemWriteB_E,
  input  logic [1:0]  mem_mode,
  input  logic [31:0] WriteDataB_E,
  input  logic [31:0] ALUResultB_E,
  output logic [31:0] ReadData_B);

  parameter Byte = 2'b00;
  parameter HalfWord = 2'b01;
  parameter Word = 2'b10;

  logic [7:0] Data_Mem [1023:0];    //Byte addressable of 1kb Data Memory

  initial begin
	$readmemh(DMemInitFile, Data_Mem);
  end

  // Asynchronus Read
  always_comb begin
    case (mem_mode)
    Byte:     ReadData_B = $signed(Data_Mem[ALUResultB_E]);
    HalfWord: ReadData_B = $signed({Data_Mem[ALUResultB_E+1], Data_Mem[ALUResultB_E]});
    Word:     ReadData_B = ({Data_Mem[ALUResultB_E+3], Data_Mem[ALUResultB_E+2], Data_Mem[ALUResultB_E+1], Data_Mem[ALUResultB_E]});
    endcase
  end

  // Synchronous Write
  integer i;

  always_ff @( posedge clk or negedge rst) begin
    if (!rst) begin
      for(i = 0; i < 1024; i = i + 1)
        Data_Mem[i] <= 32'd0;
      end else if (MemWriteB_E) begin
      case (mem_mode)
      2'b00: begin
        Data_Mem[ALUResultB_E]   <= WriteDataB_E[7:0];
      end
      HalfWord: begin
        Data_Mem[ALUResultB_E]   <= WriteDataB_E[7:0];
        Data_Mem[ALUResultB_E+1] <= WriteDataB_E[15:8];
      end
      Word: begin
        Data_Mem[ALUResultB_E]   <= WriteDataB_E[7:0];
        Data_Mem[ALUResultB_E+1] <= WriteDataB_E[15:8];
        Data_Mem[ALUResultB_E+2] <= WriteDataB_E[23:16];
        Data_Mem[ALUResultB_E+3] <= WriteDataB_E[31:24]; 
      end
      default:
      Data_Mem[ALUResultB_E]   <= WriteDataB_E[7:0];
      endcase
      end
  end



endmodule

