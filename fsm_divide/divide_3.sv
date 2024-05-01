module divideby3FSM(input logic clk
					input logic reset
					output logic q);

typedef enum { S0, S1, S2 } statetype;
statetype state, nexstate;

// state register
always_ff @( posedge clk, posedge reset ) begin
	if (reset) begin
		state <= S0;
	end else begin
		state <= nexstate;
	end
end

// next state logic
always_comb begin
	case (state)
		S0: nexstate = S1;
		S1: nexstate = S2;
		S2: nexstate = S0;
		default: nexstate = S0;
	endcase

	// output logic
	assign q = (state == S0);
end

endmodule
