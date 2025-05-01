

function logic[7:0] get_data();
        logic[7:0] ret_dat;
        ret_dat = $random;
        return ret_dat;
    endfunction : get_data;

    function opcode_t get_op();
      bit [2:0] op_choice;
      op_choice = $random;
      case (op_choice)
        3'b000 : return nop_op;
        3'b001 : return add_op;
        3'b010 : return and_op;
        3'b011 : return xor_op;
        3'b100 : return mult_op;
        3'b101 : return rst_op;
        3'b110 : return rst_op;
        3'b111 : return rst_op;
      endcase // case (op_choice)
   endfunction : get_op