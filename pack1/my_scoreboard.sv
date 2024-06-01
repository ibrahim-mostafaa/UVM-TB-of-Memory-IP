//Scoreboard 
 class my_scoreboard extends uvm_scoreboard;

    // Factory Registration
    `uvm_component_utils(my_scoreboard)

    // Instantiation: analysis imp
    uvm_analysis_imp #(my_seq_item,my_scoreboard) analysis_export_scoreboard;

    //Constructor
    function new(string name = "my_scoreboard", uvm_component parent);
        super.new(name,parent); 
    endfunction 

    //phases 
    //build_phase
    function void build_phase (uvm_phase phase); 
    super.build_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Build Phase",UVM_MEDIUM)

    // Constructor: analysis imp
    analysis_export_scoreboard = new("analysis_export_scoreboard",this);
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

    function void write(my_seq_item seq_item); 
        //seq_item.print_tran("Scoreboard write method");
        $display("Time: ",$time, "   SB.wr_enable=%0d, SB.data_in=%0d, SB.addr=%0d, SB.data_out=%0d", 
        seq_item.wr_enable,seq_item.data_in,seq_item.addr, seq_item.data_out);
    endfunction

 endclass 
   