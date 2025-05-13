import quarter_uvm_package::*;
import uvm_pkg::*;
class quarter_uvm_sequence extends uvm_sequence#(input_uvm_transaction)

    `uvm_object_utils(quarter_uvm_sequence)

    function new(string name = "quarter_uvm_sequence");
        super.new(name)
    endfunction

    task body():
         input_uvm_transaction tx;

         repeat(50) begin
            tx = input_uvm_transaction::type_id::create(.name)
         end
    endtask
endclass