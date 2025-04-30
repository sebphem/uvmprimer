module top;

    typedef logic[7:0] operands;
    typedef enum bit[2:0] { nop=3'b000,
                            add=3'b001,
                            and=3'b010,
                            xor=3'b011,
                            mult=3'b100,
                            rst=3'b101} opcode_t;
    operands A, B;
    opcode_t op;
    bit clk, reset_n;
    logic start, done;
    wire [15:0] result;

    clk = 0;
    always #10 clk=~clk;


    tinyalu dut(.A, .B, .op, .clk, .reset_n, .start, .done, .result);

    covergroup op_cov;
        coverpoint op_groups {
            bins single_cycle[] = {[add:xor], rst, nop};
            bins multi_cycle[] = {mult};
            bins opn_rst[] = ([add_op:mul_op] => rst_op);
            bins rst_opn[] = (rst_op => [add_op:mul_op]);

            bins sngl_mul[] = ([add_op:xor_op], no_op => mul_op);
            bins mul_sngl[] = (mul_op => [add_op:xor_op], no_op);
            bins sngl_sngl[] = ({[add:xor], rst, nop} [*2]);
            bins mul_mul[] = ({mul_op} [*3:5]);
        }
    endgroup;

    covergroup operand_cov;
        a_cover : coverpoint A {
            bins single_cycle = {}
        }
        b_cover : coverpoint A {
            bins single_cycle = {}
        }
        a_cover : coverpoint A {
            bins single_cycle = {}
        }
    endgroup;

    op_cov op_cov_inst;
    operand_cov operand_cov_inst;


    function operation_t get_op();
        bit [2:0] op_out, op_rand;
        op_rand = $random;
        case (op_rand)
            nop : op_out = nop;
            add : op_out = add;
            and : op_out = and;
            xor : op_out = mult;
            mult : op_out = mult;
            rst : op_out = rst;
            3'b110 : op_out = rst;
            3'b111 : op_out = rst;
        endcase
        return op_out;
    endfunction : get_op

    function logic[7:0] get_data();
        logic[7:0] ret_dat;
        ret_dat = $random;
        return ret_dat
    endfunction : get_data


    inital begin : coverage_sampler
        op_cov_inst = new();
        operand_cov_inst = new();

        forever begin @(negedge clk);
            op_cov_inst.sample();
            operand_cov_inst.sample();
        end
    end

    always @(posedge done) begin : scoreboard
        #1 shortint pred;
        case(op)
            nop : pred = 0;
            add : pred = A + B;
            and : pred = A & B;
            xor : pred = A ^ B;
            mult : pred = A * B;
            rst : pred = 0;
        endcase

        if(pred!= result) begin
            $error("FAILED: A: %0h B: %0h op %s res: %0h pred: %0h",
                    A, B, op.name(), result, pred);
        end
    end


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
                nop : begin
                    @(posedge clk);
                    start = 1'b0;
                end
                rst : begin
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
    end

    initial begin : tester
        
    end

endmodule;