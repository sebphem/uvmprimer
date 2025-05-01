module top;

    typedef logic[7:0] operands;
    typedef enum bit[2:0] { nop_op=3'b000,
                            add_op=3'b001,
                            and_op=3'b010,
                            xor_op=3'b011,
                            mult_op=3'b100,
                            rst_op=3'b101} opcode_t;
    operands A, B;
    opcode_t op;
    bit clk, reset_n;
    logic start, done;
    wire [15:0] result;

    initial begin clk = 0; end
    always #10 clk=~clk;


    tinyalu dut(.A, .B, .op, .clk, .reset_n, .start, .done, .result);

    covergroup op_cov;
        coverpoint op {
            // bins single_cycle[] = {[add_op:xor_op], rst_op, nop_op};
            // bins multi_cycle[] = {mult_op};
            // bins opn_rst[] = ([add_op:mult_op] => rst_op);
            // bins rst_opn[] = (rst_op => [add_op:mult_op]);

            // bins sngl_mul[] = ([add_op:xor_op], nop_op => mult_op);
            // bins mul_sngl[] = (mult_op => [add_op:xor_op], nop_op);
            // bins sngl_sngl[] = ({[add_op:xor_op], rst_op, nop_op} [* 2]);
            // bins mul_mul = ({mult_op} [*3:5]);
            bins single_cycle[] = {[add_op : xor_op], rst_op,nop_op};
         bins multi_cycle = {mult_op};

         bins opn_rst[] = ([add_op:mult_op] => rst_op);
         bins rst_opn[] = (rst_op => [add_op:mult_op]);

         bins sngl_mul[] = ([add_op:xor_op],nop_op => mult_op);
         bins mul_sngl[] = (mult_op => [add_op:xor_op], nop_op);

         bins twoops[] = ([add_op:mult_op] [* 2]);
         bins manymult = (mult_op [* 3:5]);
        }
    endgroup

    // covergroup operand_cov;
    //     a_cover : coverpoint A {
    //         bins single_cycle = {}
    //     }
    //     b_cover : coverpoint A {
    //         bins single_cycle = {}
    //     }
    //     a_cover : coverpoint A {
    //         bins single_cycle = {}
    //     }
    // endgroup;

    function logic[7:0] get_data();
        logic[7:0] ret_dat;
        ret_dat = $random;
        return ret_dat;
    endfunction : get_data;

    op_cov op_cov_inst;
    // operand_cov operand_cov_inst;

    initial begin : coverage_sampler
        op_cov_inst = new();
        // operand_cov_inst = new();

        forever begin @(negedge clk);
            op_cov_inst.sample();
            // operand_cov_inst.sample();
        end
    end

    int correct, incorrect;

    always @(posedge done) begin : scoreboard
        shortint pred;
        #1;
        case(op)
            nop_op : pred = 0;
            add_op : pred = A + B;
            and_op : pred = A & B;
            xor_op : pred = A ^ B;
            mult_op : pred = A * B;
            rst_op : pred = 0;
        endcase

        if(pred!= result) begin
            incorrect += 1;
            $error("FAILED: A: %0h B: %0h op %s res: %0h pred: %0h",
                    A, B, op.name(), result, pred);
        end
        else begin
            correct +=1;
        end
    end


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

    //for this driver, we want to wait until its done
    initial begin : driver
        reset_n = 1'b0;
        @(negedge clk);
        @(negedge clk);
        reset_n = 1'b1;
        start = 1'b0;
        for (int i = 0; i < 1000; i++) begin
            A = get_data();
            B = get_data();
            op = get_op();
            start = 1'b1;
            case(op)
                nop_op : begin
                    @(posedge clk);
                    start = 1'b0;
                end
                rst_op : begin
                    reset_n = 1'b0;
                    start = 1'b0;
                    @(posedge clk);
                    reset_n = 1'b1;
                end
                default : begin
                    wait(done);
                    start = 1'b0;
                end
            endcase

        end
        $display("correct: %0d incorrect: %0d", correct, incorrect);
        $finish;
    end

endmodule;