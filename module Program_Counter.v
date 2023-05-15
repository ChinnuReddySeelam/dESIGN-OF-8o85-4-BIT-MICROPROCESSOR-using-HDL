module Program_Counter(
    input Clk,//it triggers the events at a certain edge or level
    input Rst,//if Rst is ON then flipflop set to zero    
    input Enable,//Enable allows you to increment the value of the counter
    input [3:0] Incr, //This is an input parameter used for incrementing the counter purpose
    input [3:0] Load_Value, //This helps to give the counter a new value 
    output reg [3:0] Counter  //It acts like the pointer which holds the address in the stack 
);
//Counter will be updated on every positive edge of Clk
always @ (posedge Clk) begin
    if (Rst)
        Counter <= 4'b0000; // Initialize counter to 0
    else if (enable)
        Counter <= counter+Incr; // Increment counter value
    else
        Counter <= Load_Value; // Load new value into counter
end
endmodule
