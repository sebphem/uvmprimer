module tb;
    bit reset_n, clk;
    bram_if bif(.clk, .reset_n);

    bram DUT(bif);
    bram_vec_gen vec = new();

    task make_new_test_vector_and_drive()
        assert(vec.interesting_randomize());
        bif.wr_addr = vec.wr_addr;
        bif.rd_addr = vec.rd_addr;
        bif.din = vec.din;
        bif.we = vec.we;
    endtask


    initial begin
        clk=0;
        reset_n=0;
        #10;
        reset_n=1;

        repeat(100) begin
            make_new_test_vector_and_drive();
        end
    end

    always #10 clk=~clk;
endmodule