module led_run (ledr,ledg,clk,enable,reset);
input clk;
input [1:0] enable;
input reset;
output [17:0] ledr;
output [8:0] ledg;
wire [8:0] led_out1; 
wire [8:0] led_out2;
wire [17:0] led_out3; 
parameter LEDS_INIT1 = 11'b11000000000;
parameter LEDS_INIT2 = 11'b00000000011;
parameter DIR_INIT = 1;
     
reg [10:0] leds2 = LEDS_INIT2;
    reg [10:0] leds1 = LEDS_INIT1; // register for led output
    reg [3:0] position = DIR_INIT*8; // state counter 0-15 
    reg direction = DIR_INIT;   // direction indicator
 
    always @ (posedge clk) 
    begin
        if (direction == 0) begin
            leds1 <= leds1 << 1;
				leds2 <= leds2 >> 1;
        end else begin
            leds1 <= leds1 >> 1;  // bit-shift leds register
				leds2 <= leds2 << 1;
        end
        position <= position + 1;
    end
 
    always @*                  // change direction 
    begin        
        if (position < 8) begin      // in the second half 
            direction = 0;
        end else begin
            direction = 1;
        end
    end
 
    assign led_out1 = leds1[9:1]; // wire output and leds register
    assign led_out2 = leds2[9:1];
	 parameter ledrs = 18'b0000000000000000000;
	 
integer positions = 0,p = 0,pp=0;
	parameter led31 =9'b101010101;
	reg [8:0] ledss31 = led31;
	reg [17:0] ledss32;
	integer s = 0;
	integer check=0,counter = 0;
	integer counter1 =0;
	integer endled = 0;
	integer ppp= 8;
	always @ (posedge clk) 
    begin
		if (positions < 2) begin 
		ledss31 = ledss31 << 1;
		positions = positions +1;
		end
		else if (positions == 2)
		begin
		ledss31 = ledss31 >> 1;
		check = check +1;
		end
		if (check >= 2) begin
		positions = 0;
		check = 0;
		end
	 end
	 //end
	 parameter ledrf = 18'b1111111111111111111;
	 integer iii=0;
	 integer dem =0;

always @( posedge clk)begin
if ((enable==2'b10)) begin
	if (dem < 3) begin
			case(iii)
				0: begin
					ledss32 <= ledrs;
					iii <= iii + 1;
				end
				1: begin 
					ledss32 <= ledrf;
					iii <= iii - 1;
					dem = dem +1;
				end
			endcase
			end
			else ledss32 <= ledrs;
end
else begin dem =0;ledss32 <= ledrs;
	 end
	 end
	 
	 wire [17:0]leds;
	 effect2(clk,leds,1'b1,enable);
	 
		assign led_out3 = ledss32;
		assign ledr[8:0] = (enable==2'b01)?led_out1[8:0]:(enable==2'b10)?led_out3[8:0]:(enable==2'b11)?leds[8:0]:ledrs[8:0];
		assign ledr[17:9] = (enable==2'b01)?led_out2[8:0]:(enable==2'b10)?led_out3[17:9]:(enable==2'b11)?leds[17:9]:ledrs[8:0];
		assign ledg = (enable==2'b01)?ledss31:(enable==2'b10)?led_out3[8:0]:(enable==2'b11)?leds[8:0]:ledrs;
	
endmodule


module effect2(clk,leds,en,enable);
	input clk,en;
	input [1:0] enable;
	integer position = 0,p = 0,pp=0;
	parameter led31s =18'b101010101010101010;
  parameter ledss31ss =18'b000000000000000000;
	reg [17:0] ledss31s = led31s;
	output [17:0]leds;
	integer s = 0;
	integer check=0,counter = 0;
	integer counter1 =0;
	integer endled = 0;
	integer ppp= 17;
	integer dwd=0;
	always @ (posedge clk) 
    begin
	 if (enable==2'b11) begin
	 if ((dwd <11)) begin
	 //if (en == 2) begin
		if (position < 2) begin //effect 2
		ledss31s = ledss31s << 1;
		position = position +1;
		end
		else if (position == 2)
		begin
		ledss31s = ledss31s >> 1;
		check = check +1;
		end
		if (check >= 2) begin
		position = 0;
		check = 0;
		end
		dwd = dwd+1;
	 end
	 else begin ledss31s = ledss31ss;  end
	 end
	 else begin dwd=0; ledss31s = led31s; end
	end
	
	 //end
	assign leds = ledss31s;
endmodule
