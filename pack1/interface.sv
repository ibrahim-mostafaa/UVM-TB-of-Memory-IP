//Interface
interface intf(input logic clk);

//design signals 
logic wr_enable; 
logic [3:0] addr;
logic [7:0] data_in;
logic [7:0] data_out;

//clocking block
clocking cb @(posedge clk);
default input #1step output negedge; 
input data_out;
output wr_enable,addr,data_in;
endclocking 

//dut modport 
//modport dut(input rst_n, rd_enable,wr_enable,addr,data_in, output data_out)

endinterface //intf
