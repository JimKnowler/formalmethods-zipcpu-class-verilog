module shiftregister(
    input i_clk,
    input i_bit
);

    reg [15:0] r_sa, r_sb;
    
    always @(posedge i_clk)
        r_sa <= { r_sa[14:0], i_bit };

    always @(posedge i_clk)
        r_sb <= { r_sb[14:0], i_bit };
    
`ifdef FORMAL
    initial r_sa = 0;
    initial r_sb = 0;

    always @(*)
        assert(r_sa[15] == r_sb[15]);
`endif

endmodule
