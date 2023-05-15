module Reset(
    input Rst, // reset signal
    input clk, // clock signal
    output reg Rst // reset signals
);
initial Rst = 1'b0;//initialize reset to inactive state
always @(posedge clk) begin
     begin
       if (Rst)
        Rst <= 1'b0;// if the reset signal is active High, set reset to the active state
       else
        Rst <= 1'b1;// if the reset signal is inactive, set reset to the inactive state
end
endmodule