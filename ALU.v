
module ALU(Ain,Bin,ALUop,out,Z,ovf,N);//2
 input [1:0] ALUop;
 input [15:0] Ain, Bin;
 output reg [15:0] out;
 output reg Z, N;
 output reg ovf;
 
 always @(*) begin
  out=16'bxxxxxxxxxxxxxxxx;
  if(ALUop==2'b00) begin
   out=Ain+Bin;
  end
  else if(ALUop==2'b01)
   out=Ain-Bin;
  else if(ALUop==2'b10) 
   out=Ain&Bin;
  else if(ALUop==2'b11) 
   out=~Bin;
 end
 always @(out) begin
  if(out==16'b0000000000000000)
   Z=1'b1;
  else 
   Z=1'b0;
 end

 always @(out) begin
  if(ALUop==2'b00&&Ain[15]==1'b0&&Bin[15]==1'b0&&out[15]==1'b1)
   ovf=1'b1;
  else if(ALUop==2'b00&&Ain[15]==1'b1&&Bin[15]==1'b1&&out[15]==1'b0)
   ovf=1'b1;
  else if(ALUop==2'b01&&Ain[15]==1'b0&&Bin[15]==1'b1&&out[15]==1'b1)
   ovf=1'b1;
  else if(ALUop==2'b01&&Ain[15]==1'b1&&Bin[15]==1'b0&&out[15]==1'b0)
   ovf=1'b1;
  else
   ovf=1'b0;
 end
 
 always @(out) begin
  if(out[15]==1'b1)
   N=1'b1;
  else 
   N=1'b0;
 end


endmodule