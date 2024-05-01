module display(
	input logic clk,
	input logic reset,

	output logic h_sync,
	output logic v_sync,
	output logic [3:0] R_VAL,
	output logic [3:0] G_VAL,
	output logic [3:0] B_VAL,
);

parameter HD = 640;
parameter HF = 16;
parameter HB = 48;
parameter HPW = 96;
parameter HMAX = HD + HF + HB + HPW - 1;

parameter VD = 480;
parameter VF = 10;
parameter VB = 29;
parameter VPW = 2;
parameter VMAX = VD + VF + VB + VPW - 1;

logic clk_25MHz;
logic [1:0] clk_counter;

logic [9:0] pos_x, pos_y;
logic [9:0] ray_x, ray_y;
logic [9:0] counter_x, counter_y;

always @( posedge clk_25MHz ) begin
	if (reset) begin
		pos_x = 10'd100;
		pos_y = 10'd150;
	end else begin
		if (counter_x == 0 && counter_y == 0) begin
			pos_x = pos_x + 1;
			pos_y = pos_y + 1;
		end
	end
end

assign R_VAL = (ray_x >= pos_x) && (ray_x <= pos_x + HF)
			&& (ray_y >= pos_y) && (ray_y <= pos_y + VF) ? 4'b1111 : 4'b0000;
assign G_VAL = 4'd0;
assign B_VAL = 4'd0;

assign h_sync = ray_x >= HPW;
assign y_sync = ray_y >= VPW;
assign ray_x = counter_x - (HPW + HB);
assign ray_y = counter_y - (VPW + VB);

always @( posedge clk ) begin
	if (reset) begin
		clk_counter = 0;
	end else begin
		clk_counter = clk_counter + 1;
	end
end

assign clk_25MHz = (clk_counter == 3);

always @( posedge clk_25MHz ) begin

	if (reset) begin
		counter_x = 0;
		counter_y = 0;
	end

	if (counter_x + counter_y * VMAX < HMAX * VMAX) begin
		if (counter_x == HMAX) begin
			counter_x = 0;
			counter_y = counter_y + 1;
		end else begin
			counter_x = counter_x + 1;
		end
	end else begin
		counter_x = 0;
		counter_y = 0;
	end

end

endmodule
