module single_cycle_RiscV(
    input rst,
    input clock,
    output reg [31:0] result
    );
    
    // internal signals decleration
    // data path
    reg  [31:0] current_PC, next_PC;
    reg  [31:0] PCPlus4, PCTarget;
    wire [31:0] INSTR, ImmExt, SrcB, ALUResult, ReadData, WriteData;
    wire [31:0] RD1, RD2;
    // control unit
    reg        PCSrc;
    wire       MemWrite, ALUSrc, RegWrite;
    wire [1:0] ResultSrc, ImmSrc;
    wire [3:0] ALUControl;
    wire       Jump;
    wire [3:0] ALU_FLAG,Branch;

    
    // blocks instantiation
    
   // instruction memory
     instruction_memory INSTR_MEM_BLOCK(
     .pc(current_PC),
     .instruction(INSTR)
     );
     
   // control unit
    control_unit CONTROL_BLOCK(
    .op_code          (INSTR[6:0]),
    .funct3           (INSTR[14:12]),
    .funct7_5         (INSTR[30]),
    .alu_flag         (ALU_FLAG),
    .result_control   (ResultSrc),
    .imm_ext_control  (ImmSrc),
    .jumping          (Jump),
    .branching        (Branch),
    .mem_write_control(MemWrite),
    .reg_write_control(RegWrite),
    .ALU_mux_control  (ALUSrc),
    .ALU_control      (ALUControl)
    );
    
    // register file
     reg_file REG_BLOCK(
      .clk         (clock),     
      .rst         (rst),     
      .instruction (INSTR),         
      .wr_data     (result),    
      .wren        (RegWrite),        
      .rd_data1    (RD1),
      .rd_data2    (RD2)
     );
     
   // extension unit
     immmediate_extension  EXTENSION_BLOCK(
        .instr           (INSTR), 
        .imm_data_control(ImmSrc),
        .imm_data        (ImmExt)
     );

     // immediate or register data mux
      reg_imm_mux ALU_MUX(
        .imm_data(ImmExt),
        .reg_data(RD2),
        .sel     (ALUSrc),
        .data    (SrcB)
      );
     
   // alu unit
     ALU_RiscV ALU_BLOCK(
       .ALU_control(ALUControl),      
       .data_in1   (RD1),
       .data_in2   (SrcB),
       .alu_flag   (ALU_FLAG),      
       .data_out   (ALUResult)              
     );
   
     // data memory
       data_memory DATA_MEM_BLOCK(
         .clk       (clock),
         .wr_en     (MemWrite),
         .addr      (ALUResult),
         .write_data(RD2),
         .read_data (ReadData)
       );

assign WriteData= RD2;

// programm counter
always@(posedge clock, negedge rst)
begin
   if (! rst)
     current_PC<= 32'd0;
   else
      current_PC<= next_PC;
end
always@(*)
begin

PCPlus4= current_PC + 4;
PCTarget= current_PC + ImmExt;
PCSrc= ( (ALU_FLAG[0] & Branch[0]) | (ALU_FLAG[1] & Branch[1]) | (ALU_FLAG[2] & Branch[2]) | (ALU_FLAG[3] & Branch[3]) | Jump );

   if (PCSrc==1'b0)
     next_PC= PCPlus4;
   else
     next_PC= PCTarget;
end

// output logic
always@(*)
begin
case(ResultSrc)
2'b00: result= ALUResult;
2'b01: result= ReadData;
2'b10: result= PCPlus4;
default: result= 32'd0;
endcase
end

endmodule
