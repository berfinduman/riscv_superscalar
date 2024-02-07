module Main_tb ();
logic clk, rst; 
TOP_mod uut(clk,rst);

 initial begin    
    clk<= 0;
    rst<=0;
    forever #5 clk <=~ clk;  
  end
  initial begin
  #5
  rst<=1;

  #100

  $stop;
end
endmodule

