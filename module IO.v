module IO(
    input Clk, //it triggers the events at a certain edge or level
    input Rst, //if RST is ON then flipflop set to zero
    input [3:0] Addr, //It stores the address of the data
    input [7:0] D_In, //It stores the Data that should be entered in
    output [7:0] D_Out //It gives the Data that come outside as output
);
//Defining the Ports A,B,C
reg [7:0] Port_A_D;
reg [7:0] Port_B_D;
reg [7:0] Port_C_D;
// port A operations
initial begin
if (Addr==4'b0000)
 D_Out=Port_A_D;
else
 D_Out=8'hzz //When Addr is unknown then D_Out should be High impedance state
end
always @(posedge clk) begin
    if (Rst)
        Port_A_D<= 8'h00; //When Rst==1 then Port_A_D=0
   else if (Addr == 4'b0000)
        Port_A_D <= D_In; //When Rst==0 and if (Addr == 4'b0000) then Port_A_D is assigned with D_In
end
//port B operations
always @(posedge clk) begin
    if (Rst)
        Port_B_D <= 8'h00; //When Rst==1 then Port_B_D=0
    else if (Addr == 4'b0001)
        Port_B_D <= D_In;//When Rst==0 and if (Addr == 4'b0001) then Port_B_D is assigned with D_In
end
//port C operations
always @(posedge clk) begin
    if (Rst)
        Port_C_D <= 4'b0000;//When Rst==1 then Port_C_D=0 
    end else if (Addr == 4'b0010)
        Port_C_D <= D_In;//When Rst==0 and if (Addr == 4'b0010) then Port_C_D is assigned with D_In
end
// Assigning the output data
initial begin
if(Addr== 4'b0001)
 D_Out=Port_B_D;
else if (Addr== 4'b0010) 
 D_Out=Port_C_D;
else 
 D_Out=8'hzz; //Whenever the Addr is not defined then default D_out set to high impedance state
end
endmodule