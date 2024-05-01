module shiftRegister #(parameter N = 8)(
	input logic clk,
	input logic reset, load,
	input logic sin,
	input logic [N-1:0] d,
	output logic [N-1:0] q,
	output logic sout,
);

always_ff @( posedge clk, posedge reset ) begin
	if (reset) begin
		q <= 0
	end else if (load) begin
		q <= d
	end else begin
		q <= {q[N-2:0], sin};
	end

	assign sout = q[N-1];
end
	
endmodule