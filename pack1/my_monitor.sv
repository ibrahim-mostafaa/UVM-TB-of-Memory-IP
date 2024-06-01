//Monitor 
 class my_monitor extends uvm_monitor;

    // Factory Registration
    `uvm_component_utils(my_monitor)

    //Instantiation of virtual interface
    virtual interface intf config_intf; 
    virtual interface intf local_intf; 

    //Instantiation of analysis port
    uvm_analysis_port #(my_seq_item) analysis_port_monitor;  

    //Constructor
    function new(string name = "my_monitor", uvm_component parent);
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

    //Constructor: handle of analysis port
    analysis_port_monitor = new("analysis_port_monitor",this);
    endfunction

    //connect_phase
    function void connect_phase (uvm_phase phase); 
    super.connect_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Connect Phase",UVM_MEDIUM)
    endfunction

    //run_phase
    task run_phase (uvm_phase phase);
    //Instantiation: seq_item_mon
    my_seq_item seq_item_mon; 

    super.run_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Run Phase",UVM_MEDIUM)

    //Constructor: seq_item_mon
    seq_item_mon = my_seq_item::type_id::create("seq_item_mon"); 
    forever begin 
    monitor (seq_item_mon); 

    //Pass sequence_item_mon to scoreboard and subscriber. 
    $display("**********************Monitor After****************************");
    $display("Time: ",$time, "      seq_item_mon.wr_enable = %0d, seq_item_mon.addr = %0d, seq_item_mon.data_in = %0d, seq_item_mon.data_out= %0d"
    ,seq_item_mon.wr_enable, seq_item_mon.addr, seq_item_mon.data_in,seq_item_mon.data_out);  
    analysis_port_monitor.write(seq_item_mon);


    $display("Monitor Port Done");
    end
    endtask

    task monitor (my_seq_item seq_item_mon); 
    //Receive items from virutal interface 
    @(local_intf.cb);
    
    seq_item_mon.wr_enable <= local_intf.cb.wr_enable;
    seq_item_mon.addr <= local_intf.cb.addr;
    seq_item_mon.data_out <=local_intf.cb.data_out;
    seq_item_mon.data_in <=local_intf.cb.data_in;

    // if(seq_item_mon.wr_enable) begin 
    // seq_item_mon.data_out <= 8'bx;
    // end 
    // else begin 
    // seq_item_mon.data_out <=local_intf.cb.data_out;
    // end 

 
    endtask

 endclass 
