//Driver 
 class my_driver extends uvm_driver #(my_seq_item);

    // Factory Registration
    `uvm_component_utils(my_driver)

    //Instantiation of virtual interface
    virtual interface intf config_intf; 
    virtual interface intf local_intf; 

    //Constructor
    function new(string name = "my_driver", uvm_component parent);
        super.new(name,parent); 
    endfunction 

    //phases 
    //build_phase
    function void build_phase (uvm_phase phase); 
    super.build_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Build Phase",UVM_MEDIUM)

    // get from config_db
    if(!uvm_config_db #(virtual intf)::get(this,"","my_vif",config_intf))
        `uvm_fatal(get_full_name(),"Error!")

    local_intf = config_intf; 
    endfunction

    //connect_phase
    function void connect_phase (uvm_phase phase); 
    super.connect_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Connect Phase",UVM_MEDIUM)
    endfunction

    //run_phase
    task run_phase (uvm_phase phase); 

    //Instanitation: seq_item_driv
    my_seq_item seq_item_driv; 

    super.run_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Run Phase",UVM_MEDIUM)

    //Receive transactions for sequencer 
    forever begin 

    seq_item_port.get_next_item(seq_item_driv);

    drive(seq_item_driv); 
    $display("**********************Driver After****************************");
    $display("Time: ",$time, "      seq_item_driv.wr_enable = %0d, seq_item_driv.addr = %0d, seq_item_driv.data_in = %0d",seq_item_driv.wr_enable,
    seq_item_driv.addr, seq_item_driv.data_in);
    
    seq_item_port.item_done();

    end 
    endtask

    task drive (my_seq_item seq_item_driv);
    
    @(local_intf.cb);
    local_intf.cb.wr_enable <= seq_item_driv.wr_enable; 
    local_intf.cb.data_in <= seq_item_driv.data_in; 
    local_intf.cb.addr <= seq_item_driv.addr; 

    //local_intf.cb.wr_enable <= 0; 

    $display("Driver Port Done"); 
    endtask 

 endclass 
