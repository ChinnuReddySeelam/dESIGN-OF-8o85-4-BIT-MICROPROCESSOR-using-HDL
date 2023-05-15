module Interrupt_Control(
  input Clk, //it triggers the events at a certain edge or level
  input Rst, //if RST is ON then flipflop set to zero
  input Intr, //It is intrepput request
  output IntA, //Interuppt A
  output IntB, //Interuppt B
  output IntC, //Interuppt C
  output IntD, //Interuppt D
  output [7:0] Vector // vector usually refers to the address of an interrupt service routine (ISR) that is executed when an interrupt occurs. 
);
initial begin
//initialising the interrupts
 int IDLE = 3'b000;
 int INTA = 3'b001;
 int INTB = 3'b010;
 int INTC = 3'b011;
 int INTD = 3'b100;
end
//Defining the State and Vector_Reg , Which are useful for ISR
reg [2:0] State = IDLE;
reg [7:0] Vector_Reg;
always @(posedge clk) begin
  if (Rst) begin
    State <= IDLE;
    Vector_Reg <= 8'h00;
  end 
  else begin
    case(State)
      IDLE: begin  //When State==3'b000 then the assignments follows following conditions
        IntA <= 1'b0;
        IntB <= 1'b0;
        IntC <= 1'b0;
        IntD <= 1'b0;
        Vector <= Vector_Reg;
        if (Intr)
          State <= INTA; //When Intr is high then State is assigned with INTA
      end
      INTA: begin //When State==3'b001 then the assignments follows following conditions
        IntA <= 1'b1;
        Vector_Reg <= 8'h08;
        State <= INTB; //State is assigned with INTB
      end
      INTB: begin //When State==3'b010 then the assignments follows following conditions
        IntA <= 1'b0;
        IntB <= 1'b1;
        Vector_Reg <= 8'h10;
        State <= INTC; //State is assigned with INTC
      end
      INTC: begin //When State==3'b011 then the assignments follows following conditions
        IntB <= 1'b0;
        IntC<= 1'b1;
        Vector_Reg <= 8'h18;
        State <= INTD; //State is assigned with INTD
      end
      INTD: begin //When State==3'b100 then the assignments follows following conditions
        IntC <= 1'b0;
        IntD <= 1'b1;
        Vector_Reg <= 8'h20;
        State <= IDLE; //State is assigned with IDLE
      end
    endcase
  end
end
endmodule