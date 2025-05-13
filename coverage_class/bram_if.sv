interface bram_if#(
    parameter DWIDTH= 8;
    parameter AWIDTH = 8;
)(
    input clk,
    input reset_n
);
    logic [DWIDTH-1:0] dout;
    logic [DWIDTH-1:0] din;
    logic we;
    logic [AWIDTH-1:0] wr_addr;
    logic [AWIDTH-1:0] rd_addr;
endinterface