module ALU_decoder(
// ports decleration
input      [2:0] ALU_ass,
input      [2:0] funct3,
input            funct7,
output reg [3:0] ALU_control,
output reg [3:0] branch // bit[0]=> beq, bit[1]=> bne, bit[2]=> blt, bit[3]=> bge.
);

// body
always@ (*)
begin
branch= 4'b0000;
casex(ALU_ass)
3'b000:begin // load
          ALU_control=4'b0000;
       end

3'b001:begin // I-type
          case(funct3)
              3'b000:ALU_control= 4'b0000;
              3'b001:ALU_control= 4'b0010;
              3'b010:ALU_control= 4'b0011;
              3'b100:ALU_control= 4'b0101;

              3'b101:begin
                        if (funct7)
                           ALU_control= 4'b0111;
                        else
                           ALU_control= 4'b0110;
                     end

              3'b110:ALU_control= 4'b1000;
              3'b111:ALU_control= 4'b1001;
           endcase
       end

3'b010:begin // store
          ALU_control= 4'b0000;
       end

3'b011:begin // R-type
          case(funct3)
              3'b000:
                begin
                    if (funct7)
                       ALU_control= 4'b0001;
                    else
                       ALU_control= 4'b0000;
                 end

              3'b001:ALU_control= 4'b0010;
              3'b010:ALU_control= 4'b0011;
              3'b100:ALU_control= 4'b0101;

              3'b101:
                begin
                   if (funct7)
                       ALU_control= 4'b0111;
                   else
                       ALU_control= 4'b0110;
                end

              3'b110:ALU_control= 4'b1000;
              3'b111:ALU_control= 4'b1001;
           endcase
       end

3'b100:begin // branch
          case(funct3)
               3'b000:begin 
                        ALU_control= 4'b0001; // beq
                        branch[0]=1'b1;
                     end
               3'b000:begin 
                        ALU_control= 4'b0001; // bne
                        branch[1]=1'b1;
                     end
              3'b0011:begin 
                        ALU_control= 4'b0001; // blt
                        branch[2]=1'b1;
                     end
              3'b0011:begin 
                        ALU_control= 4'b0001; // bge
                        branch[3]=1'b1;
                     end
       endcase           
       end

3'b101:begin// Jal rd , offset
          ALU_control= 4'bxxxx;
       end

default: ALU_control= 4'b0000;
endcase
end

endmodule


