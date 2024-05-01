
module fsm_tb();

logic clk, reset, up, down;
logic [7:0] counter;

fsm_UD dut (.clk(clk), .reset(reset), .up(up), .down(down), .counter(counter));

always
	begin
		clk = 1;
		# 5;
		clk = 0;
		# 5;
	end

initial begin
	reset = 1;
	# 30;
	reset = 0;
	up = 0;
	down = 0;
	# 30;
	up = 1;
	# 1000;
	up = 0;
	# 1000;
	up = 1;
	# 1000;
	up = 0;
	$display("counter = %d", counter);
end

endmodule

module fsm_UD(	input logic clk, reset, up, down,
				output logic [7:0] counter);

logic pressed;

always_ff @(posedge clk) begin
	if (reset) begin
		counter = 0;
		pressed = 0;
	end else begin
		if (up & !pressed) begin
			counter = counter + 1;
			pressed = 1;
		end
		if (down & !pressed) begin
			counter = counter - 1;
			pressed = 1;
		end
		if (!up & !down) begin
			pressed = 0;
		end

	end
end

endmodule
