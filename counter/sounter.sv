module counter #(parameter N = 8) (
	input logic clk,
	input logic reset,
	output logic [N-1:0] q
);
	

always_ff @( posedge clk, posedge reset ) begin
	if (reset) begin
		q <= 0
	end else begin
		q <= q + 1;
	end
end

endmodule