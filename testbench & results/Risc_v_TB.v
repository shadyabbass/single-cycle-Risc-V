`timescale 1 ns/10 ps
module Risc_v_TB;
reg rst_tb;
reg clock_tb;
wire [31:0] result_tb;

// module instantiation
single_cycle_RiscV RISC_V_TB(
.rst(rst_tb),
.clock(clock_tb),
.result(result_tb)
);


// clock generator using frequency 10 MHz.
always
begin
clock_tb= 1'b1;
#50;
clock_tb= 1'b0;
#50;
end

// reset generator
initial
begin
$monitor ("rst_tb=%b ,instruction=%b , result=%b , time=%0t ns/n",rst_tb,RISC_V_TB.INSTR,result_tb,$time,);
rst_tb=1'b0;
#150;
rst_tb=1'b1;

#2000;
$stop;
end

endmodule