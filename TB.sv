//Testbench
`include "uvm_pkg.sv"
`include "pack1.sv"
`include "Interface.sv"
`include "memory.sv"

module TB;
import uvm_pkg::*;
import pack1::*; 

// Generate clk
bit clk; 
initial begin
    clk = 1;
    forever #10 clk = ~clk; 
end

// Generate rst_n
bit rst_n; 
initial begin
    rst_n = 0; 
    $display("Time: ", $time, "     Reset asserted");
    @(negedge clk) rst_n = 1; 
    $display("Time: ", $time, "     Reset deasserted");
end
//instantiate interfrace 
intf mem_intf(clk); 

//instantiate dut 
memory dut(.clk(clk), .rst_n(rst_n), .wr_enable(mem_intf.wr_enable), 
.addr(mem_intf.addr), .data_in(mem_intf.data_in), .data_out(mem_intf.data_out) );

//run test
initial begin
    uvm_config_db #(virtual intf)::set(null,"uvm_test_top","my_vif",mem_intf); // my_vif = memory_intf , it now points to it. 
    run_test("my_test"); 
end
endmodule
