module cpu_tb ();
    

    reg [15:0] in;
    reg load,s,clk,reset,err;
cpu  CPUDUT1(
    clk,
    reset,
    s,
    load,
    in,out,N,V,Z,w
);
   
/*
    initial begin
        forever begin
            clk = 1'b1; #2;
            clk = 1'b0; #2;
        end
    end

    initial begin
       s = 1'b1; #10;
       s = 1'b0; #89;
  	forever begin
           s = 1'b1; #10;
           s = 1'b0; #90;
        end
    end

    initial begin
        reset=1'b1;
	#2;
	reset=1'b0;
	#20;
    end


    initial begin
      in=16'b1101000000000010;//store in rn 000
      load=1'b1;
      reset=1'b1;
      #100;


      in=16'b1101000100000001;//store in rn 001
      load=1'b1; 
      #100;



      in=16'b1010000001000001;//add and put in rn000+rm001=rd010
      load=1'b1;
      #100;

      in=16'b1011000001101010;//and reg 010 left shit 1 and reg 000 store into reg 011
      load=1'b1;
      #100;

    
      in=16'b1100000001101010;//store reg 010 left shit 1 into reg 011
      load=1'b1;
      #100;

      	

	#50;

      $stop;
    end
*/
initial begin
    clk = 0; #5;
    forever begin
      clk = 1; #5;
      clk = 0; #5;
    end

end

initial begin
	err = 0;
    	reset = 1; s = 0; load = 0; in = 16'b0;
	#10;
    	reset = 0; 
    	#10;


	//test1

    	@(negedge clk);
    	in = 16'b1101000000000010;//store in rn 000
    	load = 1;
    	#10;
    	load = 0;
    	s = 1;
    	#10
    	s = 0;
    	@(posedge w); 
    	#10;
	if(cpu_tb.CPUDUT1.DP.REGFILE.R0!==16'b0000000000000010)begin
		err=1'b1;
		$stop;
	end
	#10;

	//test2

   	@(negedge clk); 
    	in = 16'b1101000100000001;//store in rn 001
    	load = 1;
    	#10;
    	load = 0;
    	s = 1;
    	#10
    	s = 0;
    	@(posedge w);
    	#10;
	if(cpu_tb.CPUDUT1.DP.REGFILE.R1!==16'b0000000000000001)begin
		err=1'b1;
		$stop;
	end
	#10;

	//test3

	@(negedge clk); 
  	in = 16'b1010000001000001;//add and put in rn000+rm001=rd010
    	load = 1;
    	#10;
    	load = 0;
    	s = 1;
    	#10
    	s = 0;
    	@(posedge w);
    	#10;
	if(cpu_tb.CPUDUT1.DP.REGFILE.R2!==16'b0000000000000011||cpu_tb.CPUDUT1.DP.Z_out!==1'b0||cpu_tb.CPUDUT1.DP.V_out!==1'b0||cpu_tb.CPUDUT1.DP.N_out!==1'b0)begin
		err=1'b1;
		$stop;
	end
	#10;

        //test4

	@(negedge clk); 
	in = 16'b1011000001101010;//and reg 010 left shit 1 and reg 000 store into reg 011
	load = 1;
    	#10;
    	load = 0;
    	s = 1;
    	#10
	s = 0;
	@(posedge w);
	#10;
	if(cpu_tb.CPUDUT1.DP.REGFILE.R3!==16'b0000000000000010||cpu_tb.CPUDUT1.DP.Z_out!==1'b0||cpu_tb.CPUDUT1.DP.V_out!==1'b0||cpu_tb.CPUDUT1.DP.N_out!==1'b0)begin
		err=1'b1;
		$stop;
	end
	#10;

	//test5

	@(negedge clk); 
    	in = 16'b1100000001101010;//store reg 010 left shit 1 into reg 011
    	load = 1;
    	#10;
    	load = 0;
    	s = 1;
    	#10
    	s = 0;
    	@(posedge w);
    	#10;
	if(cpu_tb.CPUDUT1.DP.REGFILE.R3!==16'b0000000000000110)begin
		err=1'b1;
		$stop;
	end
	#10;

	//test6

	@(negedge clk); 
    	in = 16'b1011100010000000;//negate rm=000 and store in rd=100 
    	load = 1;
    	#10;
    	load = 0;
    	s = 1;
    	#10
    	s = 0;
    	@(posedge w);
    	#20;
	if(cpu_tb.CPUDUT1.DP.REGFILE.R4!==16'b1111111111111101)begin
		err=1'b1;
		$stop;
	end
	#10;
	

	//test7
	@(negedge clk); 
    	in = 16'b1010101000000010;//compare register2-register2
    	load = 1;
    	#10;
    	load = 0;
    	s = 1;
    	#10
    	s = 0;
    	@(posedge w);
    	#10;
	if(cpu_tb.CPUDUT1.DP.Z_out!==1'b1||cpu_tb.CPUDUT1.DP.V_out!==1'b0||cpu_tb.CPUDUT1.DP.N_out!==1'b0)begin
		err=1'b1;
		$stop;
	end
	#10;
	

	//test8
	@(negedge clk); 
    	in = 16'b1010101000000010;//compare register2-register2
    	load = 1;
    	#10;
    	load = 0;
    	s = 1;
    	#10
    	s = 0;
    	@(posedge w);
    	#10;
	if(cpu_tb.CPUDUT1.DP.Z_out!==1'b1||cpu_tb.CPUDUT1.DP.V_out!==1'b0||cpu_tb.CPUDUT1.DP.N_out!==1'b0)begin
		err=1'b1;
		$stop;
	end
	#10;
	
	//test9
	@(negedge clk); 
    	in = 16'b1101010111111111;//move 11111111 into reg 101
    	load = 1;
    	#10;
    	load = 0;
    	s = 1;
    	#10
    	s = 0;
    	@(posedge w);
    	#10;
	if(cpu_tb.CPUDUT1.DP.REGFILE.R5!==16'b1111111111111111)begin
		err=1'b1;
		$stop;
	end
	#10;


	//test10
	@(negedge clk); 
    	in = 16'b1101011010000000;//move 10000000 into reg 110
    	load = 1;
    	#10;
    	load = 0;
    	s = 1;
    	#10
    	s = 0;
    	@(posedge w);
    	#10;
	if(cpu_tb.CPUDUT1.DP.REGFILE.R6!==16'b1111111110000000)begin
		err=1'b1;
		$stop;
	end
	#10;

	//test11
	@(negedge clk); 
    	in = 16'b1010011011100101;//add reg 101 and reg 110 and store in 111
    	load = 1;
    	#10;
    	load = 0;
    	s = 1;
    	#10
    	s = 0;
    	@(posedge w);
    	#10;

	if(cpu_tb.CPUDUT1.DP.REGFILE.R7!==16'b1111111101111111||cpu_tb.CPUDUT1.DP.Z_out!==1'b0||cpu_tb.CPUDUT1.DP.V_out!==1'b0||cpu_tb.CPUDUT1.DP.N_out!==1'b1)begin
		err=1'b1;
		$stop;
	end

	#10;

	//test12
	@(negedge clk); 
    	in = 16'b1011100011101101;//negate shift left by 1 rm=101 and store in rd=111
    	load = 1;
    	#10;
    	load = 0;
    	s = 1;
    	#10
    	s = 0;
    	@(posedge w);
    	#10;

	if(cpu_tb.CPUDUT1.DP.REGFILE.R7!==16'b0000000000000001)begin
		err=1'b1;
		$stop;
	end

	#10;


	//test13
	@(negedge clk); 
    	in = 16'b1100000011101101;//shift 101 left by 1 and store into 111
    	load = 1;
    	#10;
    	load = 0;
    	s = 1;
    	#10
    	s = 0;
    	@(posedge w);
    	#10;

	if(cpu_tb.CPUDUT1.DP.REGFILE.R7!==16'b1111111111111110)begin
		err=1'b1;
		$stop;
	end

	#10;

	//test14
	@(negedge clk); 
    	in = 16'b1100000000101111;//shift 111 right by 1 and store into 001
    	load = 1;
    	#10;
    	load = 0;
    	s = 1;
    	#10
    	s = 0;
    	@(posedge w);
    	#10;

	if(cpu_tb.CPUDUT1.DP.REGFILE.R1!==16'b1111111111111100||cpu_tb.CPUDUT1.DP.Z_out!==1'b0||cpu_tb.CPUDUT1.DP.V_out!==1'b0||cpu_tb.CPUDUT1.DP.N_out!==1'b1)begin
		err=1'b1;
		$stop;
	end

	#10;

	//test15
	@(negedge clk); 
    	in = 16'b1010100011101000;//compare left shift 1 bit 000 and 111 
    	load = 1;
    	#10;
    	load = 0;
    	s = 1;
    	#10
    	s = 0;
    	@(posedge w);
    	#10;

	if(cpu_tb.CPUDUT1.DP.Z_out!==1'b0||cpu_tb.CPUDUT1.DP.V_out!==1'b0||cpu_tb.CPUDUT1.DP.N_out!==1'b1)begin
		err=1'b1;
		$stop;
	end

	#10;


	//test16
	@(negedge clk); 
    	in = 16'b1010100011110000;//compare right shift 1 bit 000 and 111 
    	load = 1;
    	#10;
    	load = 0;
    	s = 1;
    	#10
    	s = 0;
    	@(posedge w);
    	#10;

	if(cpu_tb.CPUDUT1.DP.Z_out!==1'b0||cpu_tb.CPUDUT1.DP.V_out!==1'b0||cpu_tb.CPUDUT1.DP.N_out!==1'b0)begin
		err=1'b1;
		$stop;
	end

	#10;

	//test17
	@(negedge clk); 
    	in = 16'b1011000011110000;//and right shift 1 bit 000 and 000 and store in 111
    	load = 1;
    	#10;
    	load = 0;
    	s = 1;
    	#10
    	s = 0;
    	@(posedge w);
    	#10;

	if(cpu_tb.CPUDUT1.DP.REGFILE.R7!==16'b0000000000000000)begin
		err=1'b1;
		$stop;
	end

	#10;

	//test18
	@(negedge clk); 
    	in = 16'b1010001010100100;//add 100 and 010 and store in 101
    	load = 1;
    	#10;
    	load = 0;
    	s = 1;
    	#10
    	s = 0;
    	@(posedge w);
    	#10;

	if(cpu_tb.CPUDUT1.DP.REGFILE.R5!==16'b0000000000000000)begin
		err=1'b1;
		$stop;
	end

	#10;
	$stop;

end
  
endmodule
