class bram_vec_gen#(
    parameter DWIDTH= 8;
    parameter AWIDTH = 8;
);
    rand logic [AWIDTH-1:0] wr_addr;
    rand logic [AWIDTH-1:0] rd_addr;

    rand logic [DWIDTH-1:0] din;
    rand bit we;

    constraint addr_space{
        wr_addr inside {[8'h00:8'hff]};
        rd_addr inside {[8'h00:8'hff]};
    }

    constraint data_space{
        din inside {[8'h00:8'hff]};
    }

    void function interesting_randomize();
        random_val = $urandom_range(0,3);
        this.randomize();
        case(random_val)
            (0): begin
                if($urandom_range(0,3))din = 0;
                wr_addr = 0;
                rd_addr = 0;
            end
            (3): begin
                if($urandom_range(0,3))din = 'hff;
                wr_addr = 'hff;
                rd_addr = 'hff;
            end
        endcase
    endfunction

endclass