module regfile (
    data_in,
    writenum,
    write,
    readnum,
    clk,
    data_out
);

input [15:0] data_in;
input [2:0] writenum;
input [2:0] readnum;
input write;
input clk;
output [15:0] data_out;
reg [15:0] data_out;
wire [7:0] decodingwrite;
wire [7:0] decodingread;
wire [15:0] R0;
wire [15:0] R1;
wire [15:0] R2;
wire [15:0] R3;
wire [15:0] R4;
wire [15:0] R5;
wire [15:0] R6;
wire [15:0] R7;
reg writeforVDFF0;
reg writeforVDFF1;
reg writeforVDFF2;
reg writeforVDFF3;
reg writeforVDFF4;
reg writeforVDFF5;
reg writeforVDFF6;
reg writeforVDFF7;

vDFF1 #(16) DFF0(clk,writeforVDFF0,data_in,R0);
vDFF1 #(16) DFF1(clk,writeforVDFF1,data_in,R1);
vDFF1 #(16) DFF2(clk,writeforVDFF2,data_in,R2);
vDFF1 #(16) DFF3(clk,writeforVDFF3,data_in,R3);
vDFF1 #(16) DFF4(clk,writeforVDFF4,data_in,R4);
vDFF1 #(16) DFF5(clk,writeforVDFF5,data_in,R5);
vDFF1 #(16) DFF6(clk,writeforVDFF6,data_in,R6);
vDFF1 #(16) DFF7(clk,writeforVDFF7,data_in,R7);

DEC #(3,8) dcoder(writenum,decodingwrite);
DEC #(3,8) readdcoder(readnum,decodingread);
always @(*) begin
   if(write==1'b0) begin
    writeforVDFF0=1'b0;
    writeforVDFF1=1'b0;
    writeforVDFF2=1'b0;
    writeforVDFF3=1'b0;
    writeforVDFF4=1'b0;
    writeforVDFF5=1'b0;
    writeforVDFF6=1'b0;
    writeforVDFF7=1'b0;
end
else if({write,decodingwrite}== 9'b100000001) begin
    writeforVDFF0=1'b1;
    writeforVDFF1=1'b0;
    writeforVDFF2=1'b0;
    writeforVDFF3=1'b0;
    writeforVDFF4=1'b0;
    writeforVDFF5=1'b0;
    writeforVDFF6=1'b0;
    writeforVDFF7=1'b0;
end
else if({write,decodingwrite}==9'b100000010)begin
    writeforVDFF0=1'b0;
        writeforVDFF1=1'b1;
    writeforVDFF2=1'b0;
    writeforVDFF3=1'b0;
    writeforVDFF4=1'b0;
    writeforVDFF5=1'b0;
    writeforVDFF6=1'b0;
    writeforVDFF7=1'b0;
end
else if({write,decodingwrite}==9'b100000100) begin
    writeforVDFF0=1'b0;
    writeforVDFF1=1'b0;
    writeforVDFF2=1'b1;
    writeforVDFF3=1'b0;
    writeforVDFF4=1'b0;
    writeforVDFF5=1'b0;
    writeforVDFF6=1'b0;
    writeforVDFF7=1'b0;
end
else if({write,decodingwrite}==9'b100001000) begin
    writeforVDFF0=1'b0;
    writeforVDFF1=1'b0;
    writeforVDFF2=1'b0;
    writeforVDFF3=1'b1;
    writeforVDFF4=1'b0;
    writeforVDFF5=1'b0;
    writeforVDFF6=1'b0;
    writeforVDFF7=1'b0;
end
else if({write,decodingwrite}==9'b100010000)begin
    writeforVDFF0=1'b0;
    writeforVDFF1=1'b0;
    writeforVDFF2=1'b0;
    writeforVDFF3=1'b0;
    writeforVDFF4=1'b1;
    writeforVDFF5=1'b0;
    writeforVDFF6=1'b0;
    writeforVDFF7=1'b0;
end
else if({write,decodingwrite}==9'b100100000) begin
    writeforVDFF0=1'b0;
    writeforVDFF1=1'b0;
    writeforVDFF2=1'b0;
    writeforVDFF3=1'b0;
    writeforVDFF4=1'b0;
    writeforVDFF5=1'b1;
    writeforVDFF6=1'b0;
    writeforVDFF7=1'b0;
end
else if({write,decodingwrite}==9'b101000000)begin
    writeforVDFF0=1'b0;
    writeforVDFF1=1'b0;
    writeforVDFF2=1'b0;
    writeforVDFF3=1'b0;
    writeforVDFF4=1'b0;
    writeforVDFF5=1'b0;
    writeforVDFF6=1'b1;
    writeforVDFF7=1'b0;
end
else if({write,decodingwrite}==9'b110000000)begin
     writeforVDFF0=1'b0;
    writeforVDFF1=1'b0;
    writeforVDFF2=1'b0;
    writeforVDFF3=1'b0;
    writeforVDFF4=1'b0;
    writeforVDFF5=1'b0;
    writeforVDFF6=1'b0;
    writeforVDFF7=1'b1;
end
else begin
    {writeforVDFF0,writeforVDFF1,writeforVDFF2,writeforVDFF3,writeforVDFF4,writeforVDFF5,writeforVDFF6,writeforVDFF7}={8{1'bx}};
end
    
    
end
always @(*) begin
    case (decodingread)

    8'b00000001:data_out=R0;
    8'b00000010:data_out=R1;
    8'b00000100:data_out=R2;
    8'b00001000:data_out=R3;
    8'b00010000:data_out=R4;
    8'b00100000:data_out=R5;
    8'b01000000:data_out=R6;
    8'b10000000:data_out=R7;
        default: data_out={16{1'bx}};
    endcase
end
    
endmodule

module vDFF1 (
    clk,
    en,
    in,
    out
);
parameter n = 16;
    input [n-1:0] in;
    input clk,en;
    output [n-1:0] out;
    reg [n-1:0] out;
    wire [n-1:0] next_out;
    assign next_out= en ? in : out;
    always @(posedge clk) begin
        out=next_out;
    end

endmodule


module DEC (in,out);
parameter n = 3;
parameter m = 8;
    input [n-1:0] in;
    output [m-1:0] out;
    wire [m-1:0] out=1<<in;
endmodule







/*
module shifter (in,shift,sout);
 input [1:0] shift;
 input [15:0] in;
 output [15:0] sout;
 reg [15:0] sout;
 always @(*) begin
     case (shift)
         2'b00 : sout=in; 
         2'b01 : sout=in<<1;
         2'b10 : sout={1'b0,in[n-2:0]};
         2'b11 : sout={1'b1,in[n-2:0]};
         default: sout={16{1'bx}};
     endcase
     
 end

    
endmodule
*/


/*
if({write,decoding}==9'b0xxxxxxxx) begin
    {writeforVDFF0,writeforVDFF1,writeforVDFF2,writeforVDFF3,writeforVDFF4,writeforVDFF5,writeforVDFF6,writeforVDFF7}={8{1'b0}};
end
else if({write,decoding}== 9'b100000001) begin
    writeforVDFF0=1'b1;
    writeforVDFF1=1'b0;
    writeforVDFF2=1'b0;
    writeforVDFF3=1'b0;
    writeforVDFF4=1'b0;
    writeforVDFF5=1'b0;
    writeforVDFF6=1'b0;
    writeforVDFF7=1'b0;
end
else if({write,decoding}==9'b100000010)begin
    writeforVDFF1=1'b0;
        writeforVDFF1=1'b1;
    writeforVDFF2=1'b0;
    writeforVDFF3=1'b0;
    writeforVDFF4=1'b0;
    writeforVDFF5=1'b0;
    writeforVDFF6=1'b0;
    writeforVDFF7=1'b0;
end
else if({write,decoding}==9'b100000100) begin
    writeforVDFF2=1'b0;
    writeforVDFF1=1'b0;
    writeforVDFF2=1'b1;
    writeforVDFF3=1'b0;
    writeforVDFF4=1'b0;
    writeforVDFF5=1'b0;
    writeforVDFF6=1'b0;
    writeforVDFF7=1'b0;
end
else if({write,decoding}==9'b100001000) begin
    writeforVDFF3=1'b0;
    writeforVDFF1=1'b0;
    writeforVDFF2=1'b0;
    writeforVDFF3=1'b1;
    writeforVDFF4=1'b0;
    writeforVDFF5=1'b0;
    writeforVDFF6=1'b0;
    writeforVDFF7=1'b0;
end
else if({write,decoding}==9'b100010000)begin
    writeforVDFF4=1'b0;
    writeforVDFF1=1'b0;
    writeforVDFF2=1'b0;
    writeforVDFF3=1'b0;
    writeforVDFF4=1'b1;
    writeforVDFF5=1'b0;
    writeforVDFF6=1'b0;
    writeforVDFF7=1'b0;
end
else if({write,decoding}==9'b100100000) begin
    writeforVDFF5=1'b0;
    writeforVDFF1=1'b0;
    writeforVDFF2=1'b0;
    writeforVDFF3=1'b0;
    writeforVDFF4=1'b0;
    writeforVDFF5=1'b1;
    writeforVDFF6=1'b0;
    writeforVDFF7=1'b0;
end
else if({write,decoding}==9'b101000000)begin
    writeforVDFF6=1'b0;
    writeforVDFF1=1'b0;
    writeforVDFF2=1'b0;
    writeforVDFF3=1'b0;
    writeforVDFF4=1'b0;
    writeforVDFF5=1'b0;
    writeforVDFF6=1'b1;
    writeforVDFF7=1'b0;
end
else if({write,decoding}==9'b110000000)begin
     writeforVDFF7=1'b0;
    writeforVDFF1=1'b0;
    writeforVDFF2=1'b0;
    writeforVDFF3=1'b0;
    writeforVDFF4=1'b0;
    writeforVDFF5=1'b0;
    writeforVDFF6=1'b0;
    writeforVDFF7=1'b1;
end
else begin
    {writeforVDFF0,writeforVDFF1,writeforVDFF2,writeforVDFF3,writeforVDFF4,writeforVDFF5,writeforVDFF6,writeforVDFF7}={8{1'bx}};
end

















 casex ({write,decoding})
        
    
    9'b0xxxxxxxx:{writeforVDFF0,writeforVDFF1,writeforVDFF2,writeforVDFF3,writeforVDFF4,writeforVDFF5,writeforVDFF6,writeforVDFF7}={8{1'b0}};
                
    9'b100000001  : writeforVDFF0=1'b1;
    9'b100000010  : writeforVDFF1=1'b1;
    9'b100000100  : writeforVDFF2=1'b1;
    9'b100001000  : writeforVDFF3=1'b1;
    9'b100010000  : writeforVDFF4=1'b1;
    9'b100100000  : writeforVDFF5=1'b1;
    9'b101000000  : writeforVDFF6=1'b1;
    9'b110000000  : writeforVDFF7=1'b1;
       default   :{writeforVDFF0,writeforVDFF1,writeforVDFF2,writeforVDFF3,writeforVDFF4,writeforVDFF5,writeforVDFF6,writeforVDFF7}={8{1'bx}};
                    
    endcase
    */