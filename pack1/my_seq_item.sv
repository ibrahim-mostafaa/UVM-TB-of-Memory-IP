//sequence item 
 class my_seq_item extends uvm_sequence_item ;

    // Factory Registration
    `uvm_object_utils(my_seq_item)

    //Constructor
    function new(string name = "my_seq_item");
        super.new(name); 
    endfunction 

    //seq_item_signals 
    //logic rst_n;
    rand bit wr_enable; 
    rand bit [7:0] data_in;
    rand bit [3:0] addr;

    bit [7:0] data_out;

    // virtual function string convert2str();
    // return $sformatf("wr_enable = %0d, addr = %0d, data_in = %0d, data_out = %0d", wr_enable,addr, data_in,data_out);
    // endfunction

    constraint c1 {
            //wr_enable == $urandom_range (0,1);
            //wr_enable == $urandom_range(0,1);
            addr inside {[4'h0:4'hF]};
            data_in inside {[8'h00:8'hFF]};
    }

 endclass 
