module Control_Unit (
    input [1:0] Opcode,   // opcode input
    input [2:0] Reg_Addr, // register address input
    input Clk,            // clock input
    output reg En_A,      // enable signal for register A
    output reg En_B,      // enable signal for register B
    output reg Wr_En,     // write enable signal for register file
    output reg ALU_Op,    // ALU operation signal
    output reg PC_En      // enable signal for the program counter
);
typedef enum logic [2:0] {
    Fetch, //Fetching the data from the registered file
    Decode, //Decoding the fetched data
    Execute //Executing the decoded data
} In_Cyc;
reg [1:0] IR;          // instruction register
reg [3:0] PC;          // program counter
reg [2:0] Reg_Addr_A;  // register address for register A
reg [2:0] Reg_Addr_B;  // register address for register B
reg [1:0] Opcode_Reg;  // opcode register
reg [3:0] D_In_Reg; // data input register
In_Cyc Present_State;       // current state
In_Cyc Next_State;  // next state
// Opcode decoder
always @(*) begin
    case (Opcode)
        2'b00: Opcode_Reg = 2'b00; // NO operation
        2'b01: Opcode_Reg = 2'b01; // MOV operation
        2'b10: Opcode_Reg = 2'b10; // ADD operation
        2'b11: Opcode_Reg = 2'b11; // SUB operation
    endcase
end
//Implementing the state Machine using procedural assignments 
always @(posedge clk) begin
    case (Present_State)
        Fetch: begin 
            IR <= {Opcode, Reg_Addr}; //IR is assigned with the concatenation of Opcode and Reg_Addr
            Next_State = Decode; //Next_State is assigned with Decode
        end
        Decode: begin 
            Reg_Addr_A <= IR[1:0]; 
            Reg_Addr_B <= IR[3:2];
            Opcode_Reg <= IR[1:0];
            Next_State = Execute; //Next_State is assigned with Execute
        end
        Execute: begin
            case (Opcode_Reg)
                2'b00: begin //if Opcode_Reg==0 then  NO operation is executed, Following nonblocking assignments done during NO operation
                    En_A <= 0;
                    En_B <= 0;
                    Wr_En <= 0;
                    ALU_Op <= 0;
                    PC_En <= 1;
                end
                2'b01: begin //if Opcode_Reg==1 then MOV operation is executed, Following nonblocking assignments done during MOV operation
                    En_A <= 1;
                    En_B <= 0;
                    Wr_En <= 1;
                    ALU_Op <= 0;
                    PC_En <= 1;
                end
                2'b10: begin //if Opcode_Reg==2 then ADD operation is executed, Following nonblocking assignments done during NO operation
                    En_A <= 1;
                    En_B <= 1;
                    Wr_En <= 1;
                    ALU_Op <= 1;
                    PC_En <= 1;
                end
                2'b11: begin // if Opcode_Reg==3 then SUB operation is executed, Following nonblocking assignments done during NO operation
                    En_A <= 1;
                    En_B <= 1;
                    Wr_En <= 1;
                    ALU_Op <= 2;
                    PC_En <= 1;
                end
            endcase
            Next_State = Fetch; //Next_State is assigned with Fetch
        end
    endcase
    Present_State <= Next_State; //Present_State is assigned with Next_State
end
endmodule