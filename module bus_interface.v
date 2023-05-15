module bus_interface (
   input Clk, //it triggers the events at a certain edge or level
   input Rst, //if RST is ON then flipflop set to zero
    input [3:0] D_In,// Input Data 
    output reg [3:0] D_Out,// Output Data
    input [3:0] Addr_In, //Input Address
    output reg [3:0] Addr_Out,//Output Address
    input Rd, // Control signal read
    input Wr, // Control signal write           
    input Ready, // Bus Grant
    output reg [2:0] Ctrl_Out //Output control signal
);

//Lets define some Internal signals
reg [3:0] Itrl_D; //Internal Data
reg [3:0] Itrl_Addr; //Internal Address
reg [2:0] Itrl_Ctrl; //Internal Control
always @(posedge clk) begin
    if (Rst) begin //if Rst==1 then D_Out=0 and Itrl_D also 0 .
        D_Out <= 4'b0000;
        Itrl_D <= 4'b0000;
    end 
    else if (Ready == 1'b0) 
        D_Out <= Itrl_D; //If bus is ready then D_out is assigned with Itrl_D
    else
        D_Out <= 4'bzzzz; //else D_Out will be in a high impedance state
end
initial begin
if (Wr== 1'b0)
 Itrl_D=D_In; //If Write ==0 then Itrl_D assigned with D_In
else 
 Itrl_D=4'bzzzz; //Else Itrl_D in high impedance state
end
always @(posedge clk) begin
    if (Rst) begin //if Rst==1 then Addr_Out=0 and Itrl_D also 0
        Addr_Out <= 4'b0000;
        Itrl_D <= 4'b0000;
    end 
    else if (Ready == 1'b0)
        Addr_Out <= Itrl_Addr; //If bus is not ready then Addr_Out is assigned with Itrl_D
    else begin
        Addr_Out <= 4'bzzzz; //else then Addr_Out will be high impedance state
    end
end
assign Itrl_Addr = Addr_In; // Itrl_Addr is assigned with Addr_In 
always @(posedge clk) begin
    if (Rst) begin //if Rst==1 then Ctrl_Out=0 and Itrl_Ctrl also 0
        Ctrl_Out <= 3'b000;
        Itrl_Ctrl <= 3'b000;
    end 
    else if (Ready == 1'b0)
        Ctrl_Out <= Itrl_Ctrl; //If bus is not ready then Ctrl_Out is assigned with Itrl_Ctrl
    else 
        Ctrl_Out <= 3'bzzz;
end
always @(*) begin
    if (Wr == 1'b0)
        Itrl_Ctrl[2] = 1'b0; // It Writes the control signal
    else if (Rd == 1'b0)
        Itrl_Ctrl[2] = 1'b1; // It Reads the control signal
    else
        Itrl_Ctrl[2] = 1'bx; // This is used as a tri-state control signal.
    Itrl_Ctrl[0] = Ready;  // it is a Ready signal of bus
    Itrl_Ctrl[0] = 1'b1;   // it is just a Enable signal
end
endmodule