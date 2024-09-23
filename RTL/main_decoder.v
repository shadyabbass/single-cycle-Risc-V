module main_decoder(
// ports decleration
input      [6:0] op_code,
input      [3:0] ALU_out,
output reg [1:0] imm_ext_control,
output reg       ALU_data_control, mem_write_control, reg_write_control,
output reg [2:0] ALU_assistant,
output reg jump,
//output reg branch,
output reg [1:0] result_control
);

// body
always @(*)
begin
casex (op_code)
7'b000_0011:begin // load
               imm_ext_control= 2'b00;
               ALU_data_control= 1'b1;
               mem_write_control= 1'b0;
               reg_write_control= 1'b1;
               ALU_assistant= 3'b000;
               jump=1'b0;
               //branch=1'b0;
               result_control= 2'b01;
            end

7'b001_0011:begin // I-type
               imm_ext_control= 2'b00;
               ALU_data_control= 1'b1;
               mem_write_control= 1'b0;
               reg_write_control= 1'b1;
               ALU_assistant= 3'b001;
               jump=1'b0;  
               //branch=1'b0;
               result_control= 2'b00;
            end

7'b010_0011:begin // store
               imm_ext_control= 2'b01;
               ALU_data_control= 1'b1;
               mem_write_control= 1'b1;
               reg_write_control= 1'b0;
               ALU_assistant= 3'b010;
               jump=1'b0;  
               //branch=1'b0;
               result_control= 2'bxx;
            end

7'b011_0011:begin // R-type
               imm_ext_control= 2'bxx;
               ALU_data_control= 1'b0;
               mem_write_control= 1'b0;
               reg_write_control= 1'b1;
               ALU_assistant= 3'b011;
               jump=1'b0;  
               //branch=1'b0;
               result_control= 2'b00;
            end

7'b110_0011:begin // branch
               imm_ext_control= 2'b10;
               ALU_data_control= 1'b0;
               mem_write_control= 1'b0;
               reg_write_control= 1'b0;
               ALU_assistant= 3'b100;
               jump=1'b0;  
               //branch=1'b1;
               result_control= 2'bxx;
            end

7'b110_1111:begin // Jal
               imm_ext_control= 2'b11;
               ALU_data_control= 1'bx;
               mem_write_control= 1'b0;
               reg_write_control= 1'b1;
               ALU_assistant= 3'b101;
               jump=1'b1;  
               //branch=1'b0;
               result_control= 2'b10;
            end
default:begin
               imm_ext_control= 2'b00;
               ALU_data_control= 1'b0;
               mem_write_control= 1'b0;
               reg_write_control= 1'b0;
               ALU_assistant= 3'b000;
               jump=1'b0;  
               //branch=1'b0;
               result_control= 2'b00;
        end
endcase
end

endmodule
