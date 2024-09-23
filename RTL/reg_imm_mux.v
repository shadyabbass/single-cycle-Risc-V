module reg_imm_mux(
    input [31:0]      imm_data,
    input [31:0]      reg_data,
    input             sel,
    output reg [31:0] data
    );
    
    always@(*)
    begin
       if (sel==1'b0)
         data= reg_data;
       else
         data= imm_data;
    end
endmodule

