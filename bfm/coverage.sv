module coverage

/*
we need for the output:
- coverage groups
- coverage points
- bins

what we do:
- make the coverage group instances
- sample them

we need for the coverage groups:
- bfm pins themselves
    - bfm interface
- typedefs for the pins

*/

    opcode_t op_cover;

    covergroup op_cov;
        coverpoint op_cover {
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

    covergroup operand_cov;

        all_ops : coverpoint op_cover{
            ignore_bins null_ops = {rst_op, no_op};
        }
        a_cover : coverpoint A {
            bins zeros[] = {8'h00};
            bins ones[] = {8'hFF};
            // every bin of the 253 we just defined has to be hit 3 times
            bins others[] = {[8'hFE:8'h01]};
            // one bin is created, we just need to hit any of values 3 different times
            bins others = {[8'hFE:8'h01]};
            // functionally equivalent
            bins others[1] = {[8'hFE:8'h01]};
            options.at_least = 3;
        }
        b_cover : coverpoint B {
            bins zeros = {8'h00};
            bins ones = {8'hFF};
            bins others = {[8'hFE:8'h01]};
            options.at_least = 3;
        }

        corner_cover : cross a_cover, b_leg, all_ops{
            bins and 
        }
    endgroup;


    op_cov op_cov_inst;
    operand_cov operand_cov_inst;
    
    initial begin

    end
endmodule