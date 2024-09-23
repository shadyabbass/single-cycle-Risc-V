module immmediate_extension(
// ports decleration
input      [31:0] instr,
input      [1:0]  imm_data_control,
output reg [31:0] imm_data
);

always @(*)
begin
case(imm_data_control)
2'b00: imm_data= {{20{instr[31]}},instr[31:20]};                               // T-type
2'b01: imm_data= {{20{instr[31]}},instr[31:25],instr[11:7]};                   // store type
2'b10: imm_data= {{20{instr[31]}},instr[7],instr[30:25],instr[11:8],1'b0};     // branch type
2'b11: imm_data= {{12{instr[31]}},instr[19:12],instr[20],instr[30:21],1'b0};   // jump type
endcase
end

endmodule

