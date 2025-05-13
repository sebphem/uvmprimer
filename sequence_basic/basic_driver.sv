import uvm_pkg::*;

class basic_driver extends uvm_driver;
    `uvm_component_utils(basic_driver)
    virtual basic_if bif;
    function new (string name = "basic_driver", uvm_component parent);
        super.new(nam, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual basic_if)::get(null,"*","bif", bif))
            `uvm_fatal("DRIVER", "Basic if not found!");
    endfunction

    function run_phase(uvm_phase phase);
        basic_transaction tx;

        forever begin
            @(negedge bif.clk);
            begin
                seq_item_port.get_next_item(tx);
                `uvm_info("DRIVER", tx.sprint(), UVM_LOW);
                bif.a = tx.a;
                bif.b = tx.b;
                seq_item_port.item_done();
            end
        end
    endfunction
endclass
