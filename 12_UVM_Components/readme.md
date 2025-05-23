# notes

in the random testbench, we make a bunch of functions that get reused in the adder.

```systemverilog
class random_tester extends uvm_component;
   `uvm_component_utils (random_tester)

   virtual tinyalu_bfm bfm;

   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new
   
   virtual function operation_t get_op();
      bit [2:0] op_choice;
      op_choice = $random;
      case (op_choice)
        3'b000 : return no_op;
        3'b001 : return add_op;
        3'b010 : return and_op;
        3'b011 : return xor_op;
        3'b100 : return mul_op;
        3'b101 : return no_op;
        3'b110 : return rst_op;
        3'b111 : return rst_op;
      endcase // case (op_choice)
   endfunction : get_op

   virtual      function byte get_data();
      bit [1:0] zero_ones;
      zero_ones = $random;
      if (zero_ones == 2'b00)
        return 8'h00;
      else if (zero_ones == 2'b11)
        return 8'hFF;
      else
        return $random;
   endfunction : get_data
```

In order to have the functions be overwritten by child classses, you need to call them virtual and they will become overwritten in the next time that the test is run