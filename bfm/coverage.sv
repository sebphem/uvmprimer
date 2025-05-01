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

    covergroup op_cov;
        coverpoint dut.op {
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
        a_cover : coverpoint A {
            bins zeros = {8'h00};
            bins ones = {8'hFF};
            bins others = {[8'hFE:8'h01]};
        }
        b_cover : coverpoint B {
            bins zeros = {8'h00};
            bins ones = {8'hFF};
            bins others = {[8'hFE:8'h01]};
        }
    endgroup;


endmodule