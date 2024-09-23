module ALU_RiscV(
// ports decleration
input      [3:0]  ALU_control,
input      [31:0] data_in1, data_in2,
output reg [3:0]  alu_flag, // bit[0]=> beq, bit[1]=> bne, bit[2]=> blt, bit[3]=> bge.
output reg [31:0] data_out 
);

// internal signals
//////

always @(*)
begin
case(ALU_control)
4'b0000:begin // addition
           data_out= data_in1 + data_in2;
        end

4'b0001:begin // subtraction
           data_out= data_in1 - data_in2;
           alu_flag[0]= (data_out==32'd0)? 1'b1:1'b0;
           alu_flag[1]= (data_out!=32'd0)? 1'b1:1'b0;
        end

4'b0010:begin // shift left logical
           data_out= data_in1 <<  data_in2[4:0];
        end

4'b0011:begin // set less than
           data_out= (data_in1 < data_in2)? 1'b1 : 1'b0;
           alu_flag[2]= (data_out==32'd1)? 1'b1:1'b0;
           alu_flag[3]= (data_out==32'd0)? 1'b1:1'b0;
        end

/*4'b0100:begin
           data_out= ($unsigned(data_in1) < $unsigned(data_in2))? 1'b1 : 1'b0;
        end*/

4'b0101:begin // xoring
           data_out= data_in1 ^ data_in2;
        end

4'b0110:begin // shift right logical
           data_out= data_in1 >> data_in2[4:0];
        end

4'b0111:begin // shift right arithmetic
           data_out= data_in1 >>> data_in2[4:0];
        end

4'b1000:begin // oring
           data_out= data_in1 | data_in2;
        end

4'b1001:begin // anding
           data_out= data_in1 & data_in2;
        end
endcase
end


endmodule

