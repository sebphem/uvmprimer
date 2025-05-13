import uvm_pkg::*;

class basic_transaction extends uvm_sequence_item;

    rand integer a;
    rand integer b;
    function new(string name = "basic_transaction");
        super.new(name);
    endfunction //new()

    `uvm_object_utils_begin(basic_transaction)
        `uvm_field_int(a, UVM_ALL_ON)
        `uvm_field_int(b, UVM_ALL_ON)
    `uvm_object_utils_end

endclass //basic_transaction extends uvm_sequence_item