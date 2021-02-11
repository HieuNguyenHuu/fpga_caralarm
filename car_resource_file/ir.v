module ir(input enableIR,    			
							input CLOCK2_50,
							input IRDA_RXD,			//input IR
							//input [6:0] max_second,
							output reg [1:0] select_main_state,
							//output reg turnoffalert,
							input rstir,
							output data_readys
							/*output [6:0]HEX0,
							output [6:0]HEX1,
							output [6:0]HEX2,
							output [6:0]HEX3,
							output [6:0]HEX4,
							output [6:0]HEX5,
							output [6:0]HEX6,
							output [6:0]HEX7,
							input [17:0] SW,
							output [17:0] LEDR,
							input [3:0] KEY*/
							);
							
wire  data_ready;        
wire  [31:0] hex_data;  
reg resetIR;
reg d;
wire enable;
//assign enable = SW[0];
wire clk50;
/*pll1 u0( 
		.inclk0(CLOCK_50), 
		//irda clock 50M  
		.c0(clk50),           
		.c1()); */
//assign LEDR = SW;
IR_RECEIVE u1(
					///clk 50MHz////
					.iCLK(CLOCK2_50), 
					//reset          
					.iRST_n(rstir),        
					//IRDA code input
					.iIRDA(IRDA_RXD), 
					//read command      
					//.iREAD(data_read),
					//data ready      					
					.oDATA_READY(data_ready),
					//decoded data 32bit
					.oDATA(hex_data)        
					);
					
				/*	SEG_hex u2( //display the HEX on HEX0                               
			.iDIG(hex_data[31:28]),         
			.oHEX_D(HEX0)
		  );  
SEG_hex u3( //display the HEX on HEX1                                
           .iDIG(hex_data[27:24]),
           .oHEX_D(HEX1)
           );
SEG_hex u4(//display the HEX on HEX2                                
           .iDIG(hex_data[23:20]),
           .oHEX_D(HEX2)
           );
SEG_hex u5(//display the HEX on HEX3                                 
           .iDIG(hex_data[19:16]),
           .oHEX_D(HEX3)
           );
SEG_hex u6(//display the HEX on HEX4                                 
           .iDIG(hex_data[15:12]),
           .oHEX_D(HEX4)
           );
SEG_hex u7(//display the HEX on HEX5                                 
           .iDIG(hex_data[11:8]) , 
           .oHEX_D(HEX5)
           );
SEG_hex u8(//display the HEX on HEX6                                 
           .iDIG(hex_data[7:4]) ,
           .oHEX_D(HEX6)
           );
SEG_hex u9(//display the HEX on HEX7                                 
           .iDIG(hex_data[3:0]) ,
           .oHEX_D(HEX7)
           ); */
					/*reg [6:0] hex_out;
					
parameter six = 7'b0000010;
parameter blank = 7'b1111111;
parameter five = 7'b0010010;*/
//assign LEDR[0] = IRDA_RXD;
always@(negedge data_ready)begin 
	//if (enable) begin
			case(hex_data[23:16]) 
			8'h0F:
			begin
				select_main_state <= 2'b01;
				//turnoffalert <= 1'b1;
				//resetIR <= 1'b1;
				//d =1'b1;
				//hex_out <= six;
			end
			8'h13:begin
				select_main_state <= 2'b10;
				//turnoffalert <= 1'b0;
				//resetIR <= 1'b1;
			end
			8'h10: begin
				select_main_state <= 2'b11;
				//turnoffalert <= 1'b0;
				//resetIR <= 1'b1;
			end
			8'h12: begin
				select_main_state <= 2'b00;
				
			end
			/*8'h02:
			begin
				hex_out <= five;
			end*/
			endcase
end					
//assign HEX0 = hex_out;
//assign HEX1 = hex_out;			
endmodule 