interface bfm_if
    operandAB_T operands;
    opcode_t op;
    bit clk, reset_n;
    logic start, done;
    logic [15:0] result;

    task send_op(input operandAB_T ioperands, input operation_t iop, output shortint alu_result);
        op = iop;
        if(iop == rst_op) begin
            @(posedge clk);
            reset_n = 1'b0;
            start = 1'b0;
            @(posedge clk);
            #1 
            reset_n = 1'b1;
        end
        //if we have an actual command
        else begin
            @(negedge clk);
            operands = ioperands;
            start = 1'b1;
            //if there is a nop, do nothing
            if(iop == nop_op) begin
                #1
                start = 1'b0;
            end else begin
                while(done == 0) @(negedge clk);
                start = 1'b0;
            end
        end
    endtask

    task reset_alu();
        reset_n = 1'0;
        @(negedge clk);
        @(negedge clk);
        reset_n = 1'b1;
        start = 1'b0;
    endtask

endinterface