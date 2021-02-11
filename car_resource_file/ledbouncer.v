module	ledbouncer(i_clk, o_led);
	parameter	NLEDS=8, CTRBITS=25, NPWM = 9;
	input	wire		i_clk;
	output	reg	[(NLEDS-1):0]	o_led;

	reg	[(NLEDS-1):0]	led_owner;
	reg			led_dir;
	reg	[(CTRBITS-1):0]	led_ctr;
	reg			led_clk;
	reg	[(NPWM-1):0]	led_pwm [0:(NLEDS-1)];
	wire	[(NPWM-1):0]	br_ctr;

	// The
	always @(posedge i_clk)
		{ led_clk, led_ctr } <= led_ctr + {{(CTRBITS-2){1'b0}},2'b10};

	initial	led_owner = { {(NLEDS-1){1'b0}}, 1'b1};
	always @(posedge i_clk)
		if (led_owner == 0)
		begin
			led_owner <= { {(NLEDS-1){1'b0}}, 1'b1 };
			led_dir   <= 1'b1; // Left, or shift up
		end else if ((led_clk)&&(led_dir)) // Go left
		begin
			if (led_owner == { 1'b1, {(NLEDS-1){1'b0}} })
				led_dir <= !led_dir;
			else
				led_owner <= { led_owner[(NLEDS-2):0], 1'b0 };
		end else if (led_clk) begin
			if (led_owner == { {(NLEDS-1){1'b0}}, 1'b1 })
				led_dir <= !led_dir;
			else
				led_owner <= { 1'b0, led_owner[(NLEDS-1):1] };
		end

	genvar	k;
	generate for(k=0; k<(NLEDS); k=k+1) begin:s
		always@(posedge i_clk)
			if (led_clk)
			begin
				if (led_owner[k])
					led_pwm[k] <= 9'h1ff;
				else if (led_pwm[k] > 9'h04)
					led_pwm[k] <= 9'h04;
				else if (led_pwm[k] > 9'h03)
					led_pwm[k] <= 9'h03;
				else if (led_pwm[k] > 9'h02)
					led_pwm[k] <= 9'h02;
				else if (led_pwm[k] > 9'h01)
					led_pwm[k] <= 9'h01;
				else
					led_pwm[k] <= 9'h00;
			end
		end
	endgenerate

	assign	br_ctr = { led_ctr[0], led_ctr[1], led_ctr[2], led_ctr[3], 
			led_ctr[4] };

	generate for(k=0; k<(NLEDS); k=k+1) begin:ss
		always @(posedge i_clk)
			o_led[k] <= (&led_pwm[k])? 1'b1
				:((led_pwm[k] == 0) ? 1'b0
				: (br_ctr[(NPWM-1):0]<=led_pwm[k]));
		end
	endgenerate

endmodule