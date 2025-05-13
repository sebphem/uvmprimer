import uvm_pkg::*;

class quarter_uvm_test extends uvm_test;
    `uvm_component_utils(quarter_uvm_test)

    quarter_uvm_env env;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = quarter_uvm_env::type_id::create(.name("env").parent("this"));
    endfunction : build_phase

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();

    endfunction : end_of_elab

    virtual task run_phase(uvm_phase phase);
        quarter_uvm_sequence seq;
        seq = new("seq");

        phase.raise_objection(this);
        
        phase.drop_objection(this);
    endtask
endclass