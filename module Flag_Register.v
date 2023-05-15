module Flag_Register (
  input Clk, //it triggers the events at a certain edge or level
  input Rst, //if RST is ON then flipflop set to zero
  input [3:0] Opcode, //It helps to denote the type of operation done between operands
  input [3:0] A, //first Operand
  input [3:0] B,// Second Operand
  output reg [3:0] Flag // Four Flags : Carry Flag , Sign Flag , Zero Flag and Parity Flag
);
always @(posedge clk) begin
  if (Rst)
    Flag<= 4'b0000;
  else begin
    // Carry flag
    if (Opcode == 4'b0001 && (A+B) > 4'b1111) begin
      Flag[0] <= 1'b1;
    end else if (Opcode == 4'b0001 && (A+B) <= 4'b1111) begin
      Flag[0] <= 1'b0;
    end else if (Opcode == 4'b0000) begin
      Flag[0] <= 1'b0;
    end
    // Zero flag is set to 1 when the result is zero
    if ((A+B) == 4'h0)
      Flag[1] <= 1'b1;
    else
      Flag[1] <= 1'b0;
    // Sign flag is set to 1 when the MSB of result is 1
    if ((A + B)[3] == 1'b1)
      Flag[2] <= 1'b1;
    else
      Flag[2] <= 1'b0;
    // Parity flag is set to 1 when result has even number of set bits
    if ((A+B) & 1'b1)
      Flag[3] <= 1'b0; // odd number of set bits
    else
      Flag[3] <= 1'b1; // even number of set bits
  end
end
endmodule