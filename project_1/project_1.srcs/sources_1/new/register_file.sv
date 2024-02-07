module register_file (
  input  logic clk, rst, RegWriteA_W,RegWriteB_W,
  input  logic [4:0]  A1, A2, RdA_W, B1,B2, RdB_W,
  input  logic [31:0] ResultA_WH,ResultB_WH,
  output logic [31:0] RDA1, RDA2, RDB1, RDB2
);
logic [31:0] register_file[31:0];

integer  j;
initial 
begin
  register_file[0] <= 32'h0;
 for(j = 1; j <= 31; j = j + 1)
        register_file[j] <= 32'h0;
end  
//Asynchronous Read 
    always_comb begin
        RDA1 = (|A1) ? register_file[A1] : 32'b0 ;
        RDA2 = (|A2) ? register_file[A2] : 32'b0 ;
        RDB1 = (|B1) ? register_file[B1] : 32'b0 ;
        RDB2 = (|B2) ? register_file[B2] : 32'b0 ;
    end

  // Synchronous Write
  integer i;
  always_ff @(negedge clk or negedge rst) begin //maybe posedge?? 
     if (!rst) begin
     for(i = 1; i <= 31; i = i + 1)
        register_file[i] <= 32'd0;
    end   
    //DEFAULTTA 00 OLMA DURUMU ordera göre ekleenecekk ? 
    if (RegWriteA_W) begin
        register_file[RdA_W] = ResultA_WH;
    end
    if (RegWriteB_W) begin
        register_file[RdB_W] = ResultB_WH;
    end
   
  end

endmodule

