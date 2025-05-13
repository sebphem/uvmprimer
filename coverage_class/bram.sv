module bram #(
    parameter DWIDTH= 8;
    parameter AWIDTH = 8;
) (
    input clk,
    input reset_n,
    output [DWIDTH-1:0] dout,
    input [DWIDTH-1:0] din,
    input we,
    input [AWIDTH-1:0] wr_addr,
    input [AWIDTH-1:0] rd_addr
);
    logic [DWIDTH-1:0] int_dout;

    logic [(2**DWIDTH)-1:0] MEM [(2**AWIDTH)-1:0];

    always_ff @( posedge clock) begin : rd_wr_determiner
        if(!resetn) begin
            int_dout <= 0;
        end else begin
            int_dout <= MEM[rd_addr];
            if (we) MEM[wr_addr] <= din;
        end
    end
    assign dout = int_dout;
endmodule