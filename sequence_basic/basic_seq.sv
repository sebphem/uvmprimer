import uvm_pkg::*;

class basic_seq extends uvm_sequence#(basic_transaction);

    function new(string name="basic_seq", uvm_component  parent);
        super.new(name, parent);
    endfunction

    task body();
        basic_transaction tx;

        repeat(100) begin
            tx = basic_transaction::type_id::create("tx");
            start_item(tx);
            assert(tx.randomize());
            finish_item(tx);
        end
        `uvm_info("SEQ_RUN", "SEQ RUN DONE", UVM_LOW);
    endtask
endclass