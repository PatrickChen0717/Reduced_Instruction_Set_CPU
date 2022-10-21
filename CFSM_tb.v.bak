module CFSM_tb ();
 wire loada,loadb,loadc,asel,bsel,write,w;
 wire [2:0] nsel;
 wire [1:0] vsel;
 
 reg s;
  reg clk,reset;
  reg  [2:0] opcode;
 reg [1:0] op;

 CFSM  DUT1(clk,s,reset,opcode,op,nsel,w,loada,loadb,write,loadc,vsel,asel,bsel);

   initial begin
    clk = 0; #15;
    forever begin
      clk = 1; #5;
      clk = 0; #5;
    end
  end

  initial begin
    reset=1'b1;
    #5;
    reset=1'b0;
    #5;
    s=1'b1;
    opcode=3'b110;
    op=2'b10;
    #15;
    s=1'b0;
    #200;
    $stop;

  end
  /*
  initial begin
      s=1'b0;
      opcode=3'b110;
      op=2'b10;
      reset=1'b1;
      #20; 
      s=1'b1;
      #10;
      reset=1'b0;
      s=1'b1;
      #15;
      s=1'b0;
      #20;
      s=1'b1;

      opcode=3'b101;
      op=11;
      #50;
      s=1'b0;
      #10;

      s=1'b1;
      opcode=3'b110;
      op=10;
      #50;


      $stop;

  end
  */

endmodule
