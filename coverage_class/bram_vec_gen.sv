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

endclass