module counter2(
    input i_clk
);

    reg [15:0] r_counter;

    always @(posedge i_clk)
        if (r_counter == 16'd22)
            r_counter <= 0;
        else
            r_counter <= r_counter + 1'b1;
    
`ifdef FORMAL
    initial r_counter = 0;

    always @(*)
        assert(r_counter < 16'd500);
`endif 

endmodule
