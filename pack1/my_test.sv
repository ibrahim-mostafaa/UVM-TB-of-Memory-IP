//test 
 class my_test extends uvm_test;
    //instantiation: Env
    my_env env; 

    //instantiation: sequnce
    my_sequence sequence1; 

    //Instantiation of virtual interface
    virtual interface intf config_intf; 
    virtual interface intf local_intf; 

    // Factory Registration
    `uvm_component_utils(my_test)

    //Constructor
    function new(string name = "my_test", uvm_component parent);
        super.new(name,parent); 
    endfunction 

    //phases 
    //build_phase
    function void build_phase (uvm_phase phase); 
    super.build_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Build Phase",UVM_MEDIUM)
    //Constructor: Env
    env = my_env::type_id::create("env",this); 

    //get from Config_db
    if(!uvm_config_db #(virtual intf)::get(this,"","my_vif",config_intf)) 
        `uvm_fatal(get_full_name(),"Error!")
    
    local_intf = config_intf;
    //set vif Driver & Monitor 
    uvm_config_db #(virtual intf)::set(this,"env.agent.driver","my_vif",local_intf);
    uvm_config_db #(virtual intf)::set(this,"env.agent.monitor","my_vif",local_intf);

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

    // Construction: sequence
        sequence1 = my_sequence::type_id::create("sequence1");
        phase.raise_objection(this);
        sequence1.start(env.agent.sequencer); 
        phase.drop_objection(this);
    endtask

 endclass 
  