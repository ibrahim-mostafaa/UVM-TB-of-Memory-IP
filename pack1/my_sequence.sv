//sequence 
 class my_sequence extends uvm_sequence ;

    // Factory Registration
    `uvm_object_utils(my_sequence)

    //Instantiation: seq_item
    my_seq_item seq1;

    //Constructor
    function new(string name = "my_sequence");
        super.new(name); 
    endfunction 

    task pre_body();
    seq1 = my_seq_item::type_id::create("seq1");
    endtask

    task body();

    //Randomize inputs
    
    repeat (5) begin 
        // if(!seq1.randomize()) begin 
        //     $display("My_Sequence Radomization failed...."); 
        // end  
    start_item(seq1);
    assert (seq1.randomize()with {
        wr_enable == 1;
    }) 
        else   $display("Randomization Failed ..... ");
     $display("Time: ",$time, "     Generate new item:     wr_enable = %0d, addr = %0d, data_in = %0d",seq1.wr_enable,seq1.addr, seq1.data_in);
    finish_item(seq1);
    //#10;
    end
    repeat (5) begin 
        // if(!seq1.randomize()) begin 
        //     $display("My_Sequence Radomization failed...."); 
        // end  
    start_item(seq1);
    assert (seq1.randomize() with {
        wr_enable == 0;
    }) 
        else   $display("Randomization Failed ..... ");
     $display("Time: ",$time, "     Generate new item:     wr_enable = %0d, addr = %0d, data_in = %0d",seq1.wr_enable,seq1.addr, seq1.data_in);
    finish_item(seq1);
    //#10;
    end
        
endtask

 endclass 
