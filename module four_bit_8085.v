module four_bit_8085(
    input Clk, RSt,
    input [7:0] D_In,
    output [7:0] D_Out,
    output [3:0] Addr_Out,
    output reg [7:0] Inst_Out,
    output [7:0] P_Out, // Port out
    input [7:0] P_In, //Port in
    input Intr,
    output reg Ready,
   
);

wire [3:0] Addr;
wire [7:0] Data;
wire [7:0] Inst;
wire [7:0] P_D; //Port Data

// Instantiate the instruction register module
instruction_register inst_reg(
    .Clk(Clk),
    .Rst(Rst),
    .D_In(Data),
    .D_Out(Inst)
);

// Instantiate the address register module
address_register addr_reg(
    .Clk(Clk),
    .Rst(Rst),
    .D_In(Addr),
    .D_Out(Addr_Out)
);

// Instantiate the data register module
data_register data_reg(
    .Clk(Clk),
    .Rst(Rst),
    .D_In(D_In),
    .D_Out(D_Out)
);

// Instantiate the flag register module
flag_register flag_reg(
    .Clk(Clk),
    .Rst(Rst),
    .D_In(Data),
    .Carry_Out(Carry),
    .Aux_Carry_Out(Aux_Carry),
    .Parity_out(Parity),
    .Sign_out(Sign),
    .Zero_Out(Zero)
);

// Instantiate the ALU module
alu alu_inst(
    .A1(data),
    .A2(port_data),
    .Opcode(inst[7:4]),
    .Array_In(Carry),
    .Carry_Out(Carry),
    .Aux_Carry_Out(Aux_Carry),
    .Parity_out(Parity),
    .Sign_out(Sign),
    .Zero_Out(Zero)
    .Result(Data)
);

// Instantiate the I/O module
io_module io_inst(
    .Clk(Clk),
    .Rst(Rst),
    .Addr(Addr),
    .D_In(P_In),
    .D_Out(P_Data)
);

// Instantiate the interrupt control module
interrupt_control intr_ctrl(
    .Clk(Clk),
    .Intr(Intr),
    .Vector(Vector),
   
);

// Instantiate the bus interface module
bus_interface bus_if(
    .Clk(Clk),
    .Rst(Rst),
    .Addr(Addr),
    .D_In(Data),
    .D_Out(P_Data),
    .busreq(busreq),
    .busack(busack)
);

// Instantiate the clock module
clock_module clk_mod(
    .Clk(Cslk)
);

// Instantiate the reset module
reset_module rst_mod(
    .Clk(Clk),
    .Rst(Rst)
);
endmodule
