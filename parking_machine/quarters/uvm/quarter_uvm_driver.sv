import uvm_pkg::*;
class quarter_driver extends uvm_driver;

    `uvm_component_utils(quarter_driver)

    function new(string name = "quarter_driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual quarter_if qif;
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db)
    endfunction

endclass