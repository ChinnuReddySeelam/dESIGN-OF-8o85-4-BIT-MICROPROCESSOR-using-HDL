module ALU(
  input [3:0] A1, //First Operand 
  input [3:0] A2, //Second Operand
  input [3:0] Opcode, //It gives which type of arithmetic or logical operation has to do between the operands
  output reg [3:0] Result, //It stores the final result after performing the operations between operands
  output reg Carry, //It is like a carry flag it raises to one when the presence of carry
  output reg Zero,  //It is like a Zero Flag it raises to one when the final result is zero
  output reg Sign  // It gives the sign of the final result
);
reg [4:0] Temp_Res; //It is used to store the result temporarily
reg Temp_Carry; //It is used to store the carry temporarily
//We are initializing the opcodes for specified operations
initial begin
  int Add=4'b0000; //Addition operation
  int  OR=4'b0001; //OR operation
  int AND=4'b0010; //AND operation
  int XOR=4'b0011; //XOR operation
  int Sub=4'b0100; //Subtraction operation
  int ADC=4'b0101; //Addition with carry operation
  int Comp_A1=4'b0110; //Complementing the A1 operation
  int Comp_A2=4'b0111; //Complementing the A2 operation
  int Sh_Le_A1=4'b1000; //Shifting the A1 to left
  int Sh_Le_A2=4'b1001; //Shifting the A2 to left
  int Sh_Ri_A1=4'b1010; //Shifting the A1 to right
  int Sh_Ri_A2=4'b1011; //Shifting the A2 to right
end
//Using the procedural assignments we are going to set the carry flag
always @(*) begin
  case (opcode)
    Add: Temp_Carry = (A1[3] & A2[3]); //If both MSB bits of A1 and A2 are high then Temporary Carry raises to one  else it set to zero
    OR: Temp_Carry = (A1[3] | A2[3]); //If one of the MSB bits of A1 and A2 is high then Temporary Carry raises to one else it set to zero
    AND: Temp_Carry = 1'b0; //Default Temporary carry set to zero
    XOR: Temp_Carry = (A1[3] ^ A2[3]); //Only one of the MSB bits of A1 and A2 is high should be high then Temporary carry raises to one else zero
    Sub: Temp_Carry = (Temp_Res[4] == 1);// if Temp_Res[4] == 1 then Temporary carry set to one else zero
    ADC: Temp_Carry = (Temp_Res[4] == 1);// if Temp_Res[4] == 1 then Temporary carry set to one else zero
    Comp_A1:Temp_Carry = (Temp_Res[4] == 0);// if Temp_Res[4] == 0 then Temporary carry set to one else zero
    Comp_A2:Temp_Carry = (Temp_Res[4] == 0); //if Temp_Res[4] == 0 then Temporary carry set to one else zero
    Sh_Le_A1: Temp_Carry = (Temp_Res[0] == 1); //if Temp_Res[0] == 1 then Temporary carry set to one else zero
    Sh_Le_A2: Temp_Carry = (Temp_Res[0] == 1); //if Temp_Res[0] == 1 then Temporary carry set to one else zero
    Sh_Ri_A1: Temp_Carry = (Temp_Res[4] == 1); //if Temp_Res[4] == 1 then Temporary carry set to one else zero
    Sh_Ri_A2: Temp_Carry = (Temp_Res[4] == 1); //if Temp_Res[4] == 1 then Temporary carry set to one else zero
  endcase
end

// main ALU operations
always @(*) begin
  case (opcode)
    Add: Temp_Res = A1 + A2;  // add
    OR: Temp_Res = A1 | A2;  // or
    AND: Temp_Res = A1 & A2;  // and
    XOR: Temp_Res = A1 ^ A2;  // xor
    Sub: Temp_Res = A1 - A2;  // subtract
    ADC: Temp_Res = A1 + A2 + Temp_Carry;  // add with carry
    Comp_A1: Temp_Res = ~A1;  // complement of A1
    Comp_A2: Temp_Res = ~A2;  // complement of A2
    Sh_Le_A1: Temp_Res = A1 << 1;  // shift left A1
    Sh_Le_A2: Temp_Res = A2 << 1;  // shift left A2
    Sh_Ri_A1: Temp_Res = A1 >> 1;  // shift right A1
    Sh_Ri_A2: Temp_Res = A2 >> 1;  // shift right A2
  endcase
end
//Finally assigning outputs
assign Carry = Temp_Carry; //Temporary carry assigned to Final Carry 
assign Zero = (Temp_Res == 0); //If the final temporary result is zero then the zero flag is raised to one
assign Sign = Temp_Res[3]; //Sign of the result is decided using the MSB bit, If the MSB bit is 1 then the result is negative else it is positive
assign Result = Temp_Res[3:0]; //Temporary result is assigned to final result
endmodule

=>"Register File Module":-

module Register_File (
    input [2:0] Reg_Addr_A, // Address of the register A
    input [2:0] Reg_Addr_B, // Address of the register B
    input [3:0] D_In,    // Data wants to be written in
    input Wr_En,         // It enables the write opearation
    output reg [3:0] D_Out_A, // Data out from the Register A
    output reg [3:0] D_Out_b  // Data out from the Register B
);
reg [3:0] Reg_File [0:7]; // eight 4 bit general purpose registers
always @(*) begin
//If the Write operation is high then the write operation is done else Read operation is done
    if (Wr_En) begin
        Reg_File[Reg_Addr_A] <= D_In;
        Reg_File[Reg_Addr_B] <= D_In;
    end
    D_Out_A <= Reg_File[Reg_Addr_A];
    D_Out_B <= Reg_File[Reg_Addr_B];
end
endmodule