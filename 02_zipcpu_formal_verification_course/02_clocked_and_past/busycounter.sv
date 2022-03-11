`default_nettype none

//`define FORMAL

module busycounter(
    input i_clk,
    input i_reset,
    input i_start_signal,
    output reg o_busy
);

parameter [15:0] MAX_AMOUNT = 22;
reg [15:0] r_counter;

initial r_counter = 0;

always @(posedge i_clk)
    if (i_reset)
        r_counter <= 0;
        // todo: initialise o_busy to 0?
    else if ((i_start_signal) && (r_counter==0))
        r_counter <= MAX_AMOUNT-1'b1;
    else if (r_counter != 0)
        r_counter <= r_counter - 1'b1;

always @(i_clk) begin
    // o_busy needs to be clocked, so that we can test it with $past
    o_busy = (r_counter != 0);
end

`ifdef FORMAL

reg f_past_valid;
initial f_past_valid = 0;
always @(posedge i_clk)
    f_past_valid <= 1;

// design starts in reset
// use assume to constrain input
initial
    assume(i_reset == 1);

// 1. i_start_signal can be raised at any time
//  -- no property needed here --

// 2. Once raised, assume i_start_signal will remain high until it is high and the counter is no longer busy.
always @(posedge i_clk)
    if (f_past_valid && $past(i_start_signal))
        if (f_past_valid && $past(i_start_signal))
            if ($past(o_busy))
                assume(i_start_signal);
            else
                assume(!i_start_signal);

// 3. o_busy will always be true while the counter is non-zero.
//    Make sure you check o_busy both when counter == 0 and counter != 0
//    -- this requires an assertion --
always @(posedge i_clk)
    if (r_counter == 0)
        assert(!o_busy);
    else
        assert(o_busy);

// 4. If the counter is non-zero, it should always be counting down
//    Beware of the reset!
//    -- this requires another assertion
always @(posedge i_clk)
    if (f_past_valid && !$past(i_reset) && ($past(r_counter != 0)))
        assert(r_counter == $past(r_counter)-1);

`endif

endmodule
