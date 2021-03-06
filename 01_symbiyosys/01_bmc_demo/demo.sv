// from: https://symbiyosys.readthedocs.io/en/latest/quickstart.html#first-step-a-simple-bmc-example

module demo(
    input clk,
    output reg [5:0] counter
);

    initial counter = 0;                // in synthesized code, or only in simulation?

    always @(posedge clk) begin
        if (counter == 32)
            counter <= 0;
        else
            counter <= counter + 1;
    end

`ifdef FORMAL
    always @(posedge clk) begin
        assert (counter < 32);
    end
`endif 

endmodule
