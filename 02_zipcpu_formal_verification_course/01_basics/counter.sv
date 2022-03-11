`default_nettype none

module counter(
    input i_clk,
    input i_start_signal,
    output reg o_busy
);

parameter [15:0] MAX_AMOUNT = 22;
reg [15:0] r_counter;

always @(posedge i_clk)
    if ((i_start_signal) && (r_counter==0))
        r_counter <= MAX_AMOUNT-1'b1;
    else if (r_counter != 0)
        r_counter <= r_counter - 1'b1;

always @(*)
    o_busy = (r_counter != 0);

`ifdef FORMAL
initial i_start_signal = 1;                     // add initial state of start signal

always @(*) begin
    if (i_start_signal == 0)                    // add conditional for start signal
        assert(r_counter < MAX_AMOUNT);
end

`endif

endmodule
