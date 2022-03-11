module shiftregister2(
    input i_clk,
    input i_bit,
    input i_ce
);

    reg [15:0] r_sa, r_sb;
    
    always @(posedge i_clk)
        if (i_ce)
            r_sa <= { r_sa[14:0], i_bit };

    always @(posedge i_clk)
        if (i_ce)
            r_sb <= { r_sb[14:0], i_bit };
    
`ifdef FORMAL
    initial r_sa = 0;
    initial r_sb = 0;

    always @(*) begin
        // induction fails when we only use this assert
        //assert(r_sa[15] == r_sb[15]);

        // change this assert to compare full contents of shift registers
        // so that induction proof can't initialise them with different values
        assert(r_sa == r_sb);
    end
`endif

endmodule
