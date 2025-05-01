module top;
    bfm_if bfm_u();
    sequencer sequencer_u(bfm_u);
    coverage coverage_u(bfm_u);
    scoreboard scoreboard_u(bfm_u);
    tinyalu DUT (.A(bfm.operands.A), .B(bfm.operands.B), .op(bfm.op), 
                .clk(bfm.clk), .reset_n(bfm.reset_n), 
                .start(bfm.start), .done(bfm.done), .result(bfm.result));
endmodule
