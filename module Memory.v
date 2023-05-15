module Memory(
    input Clk,//it triggers the events at a certain edge or level
    input Rst,//if Rst is ON then flipflop set to zero
    input Wr, //It is like a enable signal to perform the write operation
    input [3:0] Wr_D, //It helps to write the data into the memory
    input [3:0] Addr, //It helps to store the address of data
    output reg [3:0] Rd_D // it helps to read the data from the memory
);
reg [3:0] Mem_Arr [0:15]; // Each Mem_Arr stores 4 bits
always @ (posedge Clk) begin
    if (Rst) 
        foreach(Mem_Arr[i])
            Mem_Arr[i] <= 4'b0000; //When Rst==1 then All the contents in the Mem_Arr set to zero
    else if (Wr)
        Mem_Arr[Addr] <= Wr_D; //When Wr==1 Then We can write the data into memory
end
assign Rd_D = Mem_Arr[Addr]; // Performing the read operation 
endmodule