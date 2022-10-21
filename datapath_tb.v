module datapath_tb ();
    
 
 /*reg [15:0] datapath_in;
 reg [1:0] vsel;
 reg [2:0] writenum;
 reg write,clk,loada,loadb,loadc,loads,asel,bsel;
 reg [1:0]shift;
 reg [1:0]ALUop;
 reg [2:0]readnum;
 reg err;
 */

 reg [15:0] datapath_in;
 reg [1:0] vsel;
 reg [2:0] writenum;
 reg write;
 reg [2:0] readnum;
 reg clk;
 reg loada;
 reg loadb;
 reg [1:0] shift;
 reg asel;
 reg bsel;
 reg [1:0] ALUop;
 reg loadc;
 reg loads;
  reg err;
 




datapath DUT(datapath_in,vsel,writenum,write,readnum,clk,loada,loadb,loadc,
                loads,shift,asel,bsel,ALUop,datapath_out,Z_out,V_out,N_out);


    initial begin
        clk = 1'b0; #5;
        forever begin
            clk = 1'b1; #5;
            clk = 1'b0; #5;
        end
    end



    initial begin
       //datain=-170
       //wrire in the R7
       //select the data in 
        err=1'b0;
        datapath_in=16'b1111111111111111;                  
        writenum=3'b111;
        write=1'b1;
        vsel=2'b01;
        #10;
        //check whether the R7 has been write -170
        if(datapath_tb.DUT.REGFILE.R7 !==16'b1111111111111111) begin  
            err=1'b1;
            $stop;
        end
       //datain=-0
       //wrire in the R0
       //select the data in 
        #10;
        datapath_in=16'b1000000000000000;
        writenum=3'b000;
        write=1'b1;
        #10;
        //check whether the R7 has been write -0
        if(datapath_tb.DUT.REGFILE.R0 !==16'b1000000000000000) begin
             err=1'b1;
            $stop;
        end
        //load the -170 into B
        #10;
        writenum=1'b0;
        readnum=3'b111;
        loadb=1'b1;
        loada=1'b0;
        #10;
        //check the data out of  B
        if(datapath_tb.DUT.wire1_3_4 !==16'b1111111111111111)begin
                err=1'b1;
            $stop;
        end
        if(datapath_tb.DUT.wire4_8 !==16'b1111111111111111)begin
                            err=1'b1;
            $stop;
        end
        //load the -0 into A
        #10;
        readnum=3'b000;
        loadb=1'b0;
        loada=1'b1;
        #10;
        //check the data out of A
         if(datapath_tb.DUT.wire1_3_4 !==16'b1000000000000000)begin
                err=1'b1;
            $stop;
        end
        if(datapath_tb.DUT.wire3_6 !==16'b1000000000000000)begin
            err=1'b1;
            $stop;
        end
        //no shift in the value in B
        //select the data both from the A and B
        //add instruction for the data from A and B 
        //loadc and loads set to 1
        #10;
        shift=2'b00;
        asel=1'b0;
        bsel=1'b0;
        ALUop=2'b00;
        loadc=1'b1;
        loads=1'b1;
        #10;
        //check whether the output after add is correct 
        //check whether have overflow

        if(datapath_tb.DUT.wire5_9!==16'b0111111111111111)begin
                            err=1'b1;
            $stop;
        end
        if(datapath_tb.DUT.wire2_10!==1'b0)begin
                err=1'b1;
            $stop;            
        end
        if(datapath_tb.DUT.wire2_11!==1'b1)begin
                err=1'b1;
            $stop;               
        end
        if(datapath_tb.DUT.wire2_12!==1'b0)begin
                err=1'b1;
            $stop;               
        end  
        //write the output back to the R2
        #10;
        write=1'b1;
        writenum=3'b010;
        vsel=2'b11;
        #10;
        if(datapath_tb.DUT.REGFILE.R2 !==16'b0111111111111111)begin
                err=1'b1;
            $stop;            
        end
        #10;
        //load the value in R7 both to A and B
        loada=1'b1;
        readnum=3'b111;
        loadb=1'b1;
        #10;
        //check whether the value in R7 has been load in the A and B 
    if(datapath_tb.DUT.wire1_3_4 !==16'b1111111111111111)begin
                err=1'b1;
            $stop;
        end
        if(datapath_tb.DUT.wire3_6 !==16'b1111111111111111)begin
            err=1'b1;
            $stop;
        end
        if(datapath_tb.DUT.wire4_8 !==16'b1111111111111111)begin
            err=1'b1;
            $stop;
        end
        #10;
        // check the sub of two same numbers 
        //check the Z_out should be 1
        ALUop=2'b01;
        asel=1'b0;
        bsel=1'b0;
        loadc=1'b1;
        loads=1'b1;
        #10;
       if(datapath_tb.DUT.wire5_9!==16'b0000000000000000)begin
                            err=1'b1;
            $stop;
        end
        if(datapath_tb.DUT.Z_out!==1'b1)begin
                err=1'b1;
            $stop;            
        end
        if(datapath_tb.DUT.V_out!==1'b0)begin
                err=1'b1;
            $stop;               
        end
        if(datapath_tb.DUT.N_out!==1'b0)begin
                err=1'b1;
            $stop;               
        end  
        #10;
        // write the output back to the R1
        vsel=2'b11;
        write=1'b1;
        writenum=3'b001;
    #10;
    if(datapath_tb.DUT.REGFILE.R1 !==16'b00000000000000000)begin
                err=1'b1;
            $stop;          
    end
    #10;
    //load the number in R7 int  B
    write=1'b0;
    readnum=3'b111;
    loadb=1'b1;
    loada=1'b0;
    #10;
        if(datapath_tb.DUT.wire1_3_4 !==16'b1111111111111111)begin
                err=1'b1;
            $stop;
        end
        if(datapath_tb.DUT.wire4_8 !==16'b1111111111111111)begin
                            err=1'b1;
            $stop;
        end
    #10;
    //load the value in R1 into A
    readnum=3'b001;
    loada=1'b1;
    loadb=1'b0;
    #10;
        if(datapath_tb.DUT.wire1_3_4 !==16'b00000000000000000)begin
                err=1'b1;
            $stop;
        end
        if(datapath_tb.DUT.wire3_6 !==16'b00000000000000000)begin
                            err=1'b1;
            $stop;
        end
    #10;
    //check the bitwise AND opration 
    asel=1'b0;
    bsel=1'b0;
    ALUop=2'b10;
    shift=2'b00;
    loadc=1'b1;
    loads=1'b1;
    #10;
    if(datapath_tb.DUT.wire5_9 !==16'b00000000000000000)begin
                err=1'b1;
            $stop;
        end
     if(datapath_tb.DUT.Z_out!==1'b1)begin
                err=1'b1;
            $stop;            
        end
        if(datapath_tb.DUT.V_out!==1'b0)begin
                err=1'b1;
            $stop;               
        end
        if(datapath_tb.DUT.N_out!==1'b0)begin
                err=1'b1;
            $stop;               
        end  
        #10;

        $stop;      
        
        



    end








endmodule
