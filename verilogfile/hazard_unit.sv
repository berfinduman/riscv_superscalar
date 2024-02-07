module hazard_unit (
input logic [31:0] ResultA_W, ResultB_W,
input logic [1:0]  order_W,
input logic hazard_flag,  PCSrcA_E, PCSrcB_E,RegWriteA_W, RegWriteB_W, 
input logic [4:0]  RdA_E, Rs1A_E, Rs2A_E, RdB_E, Rs1B_E, Rs2B_E,RdA_W,RdB_W,
output logic [1:0] ForwardA1E,ForwardA2E, ForwardB1E,ForwardB2E,
output logic       StallF,stallonly, FlushE, FlushD,
output logic [31:0] ResultA_WH, ResultB_WH
);


  logic lwStall;

  always_comb begin
    if (RegWriteA_W==RegWriteB_W && RdA_W==RdB_W)
    begin
        if (order_W==10)
        begin
        ResultA_WH<=ResultA_W;
        ResultB_WH<=ResultA_W;
        end
        else
        ResultA_WH<=ResultB_W;
        ResultB_WH<=ResultB_W;
        begin
        end
    end
    else
    begin
        ResultA_WH<=ResultA_W;
        ResultB_WH<=ResultB_W; 
    end
    
    end 
    
    always_comb begin 
    //RAW HAZARD CONTROL PIPELINING
    if (((Rs1A_E == RdA_W) && RegWriteA_W) && (Rs1A_E != 0) ) begin
      ForwardA1E <= 2'b01;
    end
    else if (((Rs1A_E == RdB_W) && RegWriteB_W) && (Rs1A_E != 0) ) begin
      ForwardA1E <= 2'b10;
    end
    else 
    begin
      ForwardA1E <= 2'b00;
    end 
    if (((Rs2A_E == RdA_W) && RegWriteA_W) && (Rs2A_E != 0) ) begin
      ForwardA2E <= 2'b01;
    end
    else if (((Rs2A_E == RdB_W) && RegWriteB_W) && (Rs2A_E != 0) ) begin
      ForwardA2E <= 2'b10;
    end
    else 
    begin
      ForwardA2E <= 2'b00;
    end

    if (((Rs1B_E == RdA_W) && RegWriteA_W) && (Rs1B_E != 0) )  begin
      ForwardB1E <= 2'b01;
    end

    else if (((Rs1B_E == RdB_W) && RegWriteB_W) && (Rs1B_E != 0) ) begin
      ForwardB1E <= 2'b10;
    end
    else 
    begin
      ForwardB1E <= 2'b00;
    end
    if (((Rs2B_E == RdA_W) && RegWriteA_W) && (Rs2B_E != 0) ) begin
      ForwardB2E <= 2'b01;
    end
    else if (((Rs2B_E == RdB_W) && RegWriteB_W) && (Rs2B_E != 0) ) 
    begin
      ForwardB2E <= 2'b10;
    end
    else begin 
        ForwardB2E <= 2'b00;
    end
  end

  always_comb begin
    if (hazard_flag) begin
      stallonly <= 1'b1;
      StallF<=1'b1; 
    end
    else 
    begin 
    stallonly <= 1'b0;
    StallF<=1'b0; 
    end
    
    FlushE <= (PCSrcA_E ||PCSrcB_E);
    FlushD <= (PCSrcA_E ||PCSrcB_E);

  end
endmodule
