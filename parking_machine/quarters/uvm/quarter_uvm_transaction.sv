import uvm_pkg::*;

//using a more lean style that just adds the uvm_sequence_item signals to the uvm database

class input_uvm_transaction extends uvm_sequence_item;
    rand logic quarter_slot;
    function new(string name="")
        super.new(name);
    endfunction : new

    `uvm_object_utils_begin(input_uvm_transaction)
        `uvm_field_int(quarter_slot, UVM_ALL_ON)
    `uvm_object_utils_end
endclass

class output_uvm_transaction extends uvm_sequence_item;

    logic ticket;
    function new(string name="")
        super.new(name);
    endfunction : new

    `uvm_object_utils_begin(output_uvm_transaction)
        `uvm_field_int(ticket, UVM_ALL_ON)
    `uvm_object_utils_end
endclass