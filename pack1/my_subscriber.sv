//Subscriber 
 class my_subscirber extends uvm_subscriber #(my_seq_item);

    // Factory Registration
    `uvm_component_utils(my_subscirber)

    //Constructor
    function new(string name = "my_subscriber", uvm_component parent);
        super.new(name,parent); 
    endfunction 

    //phases 
    //build_phase
    function void build_phase (uvm_phase phase); 
    super.build_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Build Phase",UVM_MEDIUM)
    endfunction

    //connect_phase
    function void connect_phase (uvm_phase phase); 
    super.connect_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Connect Phase",UVM_MEDIUM)
    endfunction

    //run_phase
    task run_phase (uvm_phase phase); 
    super.run_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Run Phase",UVM_MEDIUM)
    endtask

    //override pure virtual function void
    function void write(my_seq_item t); 
    //t.print_tran("Subsriber write method");
    endfunction
 endclass 
