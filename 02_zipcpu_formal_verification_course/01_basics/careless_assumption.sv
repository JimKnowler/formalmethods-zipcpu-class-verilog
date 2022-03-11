module careless_assumption(
    input clk
);

    reg [15:0] counter;

    initial counter = 0;
    always @(posedge clk)
        counter <= counter + 1'b1;
    
    always @(*)
    begin
        assert(counter <= 100);
        assume(counter <= 90);              // this assumption prevent proof from examining cases where counter reaches 100
    end

endmodule

