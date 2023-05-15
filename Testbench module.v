`timescale 1ns / 1ns

module tb_8085;

// Define the parameters
parameter CLK_PERIOD = 10;

// Declare the DUT
reg clk, rst_n;
reg [15:0] addr;
reg [7:0] data_in;
wire [7:0] data_out;
wire int_req, int_ack;
wire bus_req, bus_ack;
wire mem_rd, mem_wr, io_rd, io_wr;
wire [7:0] mem_data, io_data;
wire [3:0] flags;
wire [7:0] vector;

// Instantiate the DUT
clock_module clock(clk);
reset_module reset(clk, rst_n);
interrupt_module interrupt(clk, rst_n, int_req, int_ack);
bus_interface_module bus_interface(clk, rst_n, bus_req, bus_ack, addr, data_in, data_out, mem_rd, mem_wr, io_rd, io_wr, mem_data, io_data);
register_file_module register_file(clk, rst_n, addr[3:0], data_in[3:0], data_out[3:0]);
alu_module alu(clk, rst_n, addr[3:0], data_in[3:0], flags);
flag_register_module flag_register(clk, rst_n, flags);
io_module io(clk, rst_n, addr, data_in[7:0], data_out);

// Generate the clock
initial begin
    clk = 1'b0;
    forever #CLK_PERIOD clk = ~clk;
end

// Reset the DUT
initial begin
    rst_n = 1'b0;
    #20 rst_n = 1'b1;
end

// Write a value to a register and check the output
initial begin
    addr = 4'b0000;
    data_in = 8'b00001111;
    #50;
    data_in = 8'b01010101;
    #50;
    addr = 4'b0001;
    data_in = 8'b11110000;
    #50;
    addr = 4'b0000;
    data_in = 8'b10101010;
    #50;
    addr = 4'b0001;
    data_in = 8'b01010101;
    #50;
    addr = 4'b0000;
    data_in = 8'b11110000;
    #50;
    addr = 4'b0001;
    data_in = 8'b00001111;
    #50;
    addr = 4'b0000;
    data_in = 8'b01010101;
    #50;
    $finish;
end

endmodule
