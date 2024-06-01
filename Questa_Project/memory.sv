//module memory (intf mem_intf); 
module memory (
    input  clk, rst_n,wr_enable,
    input  [3:0] addr, 
    input  [7:0] data_in, 
    output logic [7:0] data_out
); 

logic [7:0] mem [0:15]; 

always@(posedge clk,negedge rst_n) begin 
    if (!rst_n) begin 
    data_out <=8'b0; 
    for(int i = 0;i<16; i= i+1) begin 
    mem[i] <= 8'b0;  
    end   
	end 	
    else if (wr_enable) begin 
        mem[addr] <= data_in;
    end
    else data_out <= mem[addr];
end 

endmodule 
