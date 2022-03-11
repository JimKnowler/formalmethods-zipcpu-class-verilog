module dblpipe(
    input i_clk,
    input i_reset,
    input i_data,
    output reg o_data
);
    wire w_data_a;
    wire w_data_b;
    
    lfsr_fib one(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_ce(1),
        .i_in(i_data),
        .o_bit(w_data_a)
    );

    lfsr_fib two(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_ce(1),
        .i_in(i_data),
        .o_bit(w_data_b)
    );

    always @(posedge i_clk)
        o_data <= w_data_a ^ w_data_b;
    
`ifdef FORMAL
    reg f_past_valid;

    initial
        f_past_valid = 1'b0;

    always @(posedge i_clk)
        f_past_valid <= 1'b1;

    initial begin
        assume(i_reset);
        o_data = 0;
    end

    always @(posedge i_clk)
        if (f_past_valid)
            assert(o_data == 0);
`endif

endmodule


module lfsr_fib(
    input i_clk,
    input i_reset,
    input i_ce,
    input i_in,
    output o_bit
);
    parameter INITIAL_FILL = 0;
    parameter LN = 8;
    parameter TAPS = 8'b00101100;

    reg [(LN-1):0] r_sreg;    

    always @(posedge i_clk)
        if (i_reset)
            r_sreg <= INITIAL_FILL;
        else if (i_ce) begin
            r_sreg[(LN-2):0] <= r_sreg[(LN-1):1];
            r_sreg[(LN-1)] <= (^(r_sreg & TAPS)) ^ i_in;
        end
    
    assign o_bit = r_sreg[0];
    
`ifdef FORMAL
    initial r_sreg = INITIAL_FILL;
`endif

endmodule