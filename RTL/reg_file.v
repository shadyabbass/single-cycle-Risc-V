module reg_file(
    input             clk,
    input             rst,
    input [31:0]      instruction,
    input [31:0]      wr_data,
    input             wren,
    output reg [31:0] rd_data1, rd_data2
    );
    
    // register decleration
    reg [31:0] register [31:0];
    
    // internal signals
    wire [4:0] addr1, addr2, addr_w;
    
    assign addr1= instruction[19:15];
    assign addr2= instruction[24:20];
    assign addr_w= instruction[11:7];
    
    // design will be asynchronous read and synchronous write
    
    // writing block
    always@(posedge clk, negedge rst)
    begin
       if (!rst) begin
         register[0]<=16'd0;
         register[2]<=16'd0;
         register[4]<=16'd0;
         register[5]<=16'd0;
         register[6]<=16'd0;
         register[7]<=16'd0;
         register[8]<=16'd0;
         register[9]<=16'd0;
         register[10]<=16'd0;
         register[11]<=16'd0;
         register[12]<=16'd0;
         register[13]<=16'd0;
         register[14]<=16'd0;
         register[15]<=16'd0;
         register[16]<=16'd0;
         register[17]<=16'd0;
         register[18]<=16'd0;
         register[19]<=16'd0;
         register[20]<=16'd0;
         register[21]<=16'd0;
         register[22]<=16'd0;
         register[23]<=16'd0;
         register[24]<=16'd0;
         register[25]<=16'd0;
         register[26]<=16'd0;
         register[27]<=16'd0;
         register[28]<=16'd0;
         register[29]<=16'd0;
         register[30]<=16'd0;
         register[31]<=16'd0;
         end
     else
         if(wren==1'b1)
           register[addr_w]<=wr_data;
         
    end
    
    // reading block
    always@(*)
    begin
         rd_data1= register[addr1];
         rd_data2= register[addr2];
    end
    
endmodule
