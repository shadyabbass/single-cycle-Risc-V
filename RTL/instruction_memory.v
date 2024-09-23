module instruction_memory(
    input [31:0] pc,
    output [31:0] instruction
    );
    
    // memory decleration
    reg [31:0] instr_memory [2**31 -1:0];
    
    initial
       begin
       //$readmemh("machine_code.txt", instr_memory);
       instr_memory[0]=  32'h00500113  ;
       instr_memory[1]=  32'h00C00193  ;
       instr_memory[2]=  32'hFF718393  ;
       instr_memory[3]=  32'h00a3a303  ;
       instr_memory[4]=  32'h0023E233  ;
       instr_memory[5]=  32'h0041F2B3  ;
       instr_memory[6]=  32'h004282B3  ;
       instr_memory[7]=  32'h02728863  ;
       instr_memory[8]=  32'h0041A233  ;
       instr_memory[9]=  32'h00020463  ;
       instr_memory[10]= 32'h00000293  ;
       instr_memory[11]= 32'h0023A233  ;
       instr_memory[12]= 32'h005203B3  ;
       instr_memory[13]= 32'h402383B3  ;
       instr_memory[14]= 32'h0471AA23  ;
       instr_memory[15]= 32'h06002103  ;
       instr_memory[16]= 32'h005104B3  ;
       instr_memory[17]= 32'h008001EF  ;
       instr_memory[18]= 32'h00100113  ;
       instr_memory[19]= 32'h00910133  ;
       instr_memory[20]= 32'h0221A023  ;
       instr_memory[21]= 32'h00210063  ;
       end
       
    assign instruction= instr_memory[pc[31:2]];
        
        
endmodule
