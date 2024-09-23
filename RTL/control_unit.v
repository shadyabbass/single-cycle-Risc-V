module control_unit (
// port decleration
input  [6:0] op_code,
input  [2:0] funct3,
input        funct7_5,
input  [3:0] alu_flag,

output [1:0] result_control, imm_ext_control,
output       jumping,
output [3:0] branching,
output       mem_write_control, reg_write_control,  ALU_mux_control,
output [3:0] ALU_control
);

// internal signal decleration
wire [2:0] ALU_assistant;


// main decoder instantiation
main_decoder MD(
.op_code(op_code),
.ALU_out(alu_flag),
.imm_ext_control(imm_ext_control),
.ALU_data_control(ALU_mux_control), // mux
.mem_write_control(mem_write_control),
.reg_write_control(reg_write_control),
.ALU_assistant(ALU_assistant),                                        
.jump(jumping),
.result_control(result_control)
);


// ALU decoder instantiation
ALU_decoder ALUD(
.ALU_ass(ALU_assistant),
.funct3(funct3),
.funct7(funct7_5),
.branch(branching),
.ALU_control(ALU_control)
);

endmodule
