//Env 
 class my_env extends uvm_env;
    //instantiation: subs, agent, scoreb
    my_subscirber subscriber; 
    my_scoreboard scoreboard;
    my_agent agent;
    // Factory Registration
    `uvm_component_utils(my_env)

    //Constructor
    function new(string name = "my_env", uvm_component parent);
        super.new(name,parent); 
    endfunction 

    //phases 
    //build_phase
    function void build_phase (uvm_phase phase); 
    super.build_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Build Phase",UVM_MEDIUM)
    //Constructor: Env
    subscriber = my_subscirber::type_id::create("subscriber",this); 
    scoreboard = my_scoreboard::type_id::create("scoreboard",this); 
    agent = my_agent::type_id::create("agent",this); 
    endfunction

    //connect_phase
    function void connect_phase (uvm_phase phase); 
    super.connect_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Connect Phase",UVM_MEDIUM)

    //Connect monitor with scoreboard & Subsriber
    agent.monitor.analysis_port_monitor.connect(scoreboard.analysis_export_scoreboard);
    agent.monitor.analysis_port_monitor.connect(subscriber.analysis_export);  // already was there. not in build phase
    endfunction

    //run_phase
    task run_phase (uvm_phase phase); 
    super.run_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Run Phase",UVM_MEDIUM)
    endtask

 endclass 
  