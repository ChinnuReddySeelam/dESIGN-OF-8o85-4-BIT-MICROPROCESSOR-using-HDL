module Instruction_Register(
    input Clk, //it triggers the events at a certain edge or level
    input Rst, //if RST is ON then flipflop set to zero
    input [7:0] Inst, //It is just a input instruction signal
    output reg [3:0] OpCode, //To know the type arithmetic instruction has to do
    output reg [3:0] Operand //It helps Opcode to perform the specific operation
);
reg [7:0] Register; //It is used to store the instruction
//Register will be updated on every positive edge of clk
always @ (posedge Clk) begin
    if (Rst) 
        Register <= 8'b00000000; //If rst==1 then Register set to zero
    else 
        Register <= Inst; //if rst==0 then Register should be fetched with instruction
end
//[7:0]Inst=[7:4]Opcode + [3:0] Operand
assign {Opcode, Operand} = Register[7:0]; //”{}” it denotes concatenation so [7:4] bits assigned to Opcode and [3:0] bits assigned to Operand
endmodule