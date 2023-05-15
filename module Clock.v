module Clock(
    input Clk_In, // input clock signal
    output reg Clk_Out // output clock signal
);
initial Clk_Out = 1'b0; // initialize clock to zero
always @(posedge Clk_In) begin
    Clk_Out <= ~Clk_Out; // toggle output clock signal
end
endmodule

