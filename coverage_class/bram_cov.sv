class bram_cov;

    virtual bram_if bif;


    covergroup bram_cov_groups @(bif.clk);
        coverpoint bif.wr_addr = {
            bins zero = {0};
            bins middle = {['h01:'h87]};
            bins last = {'h88};
        }
        coverpoint bif.rd_addr = {
            bins zero = {0};
            bins middle = {['h01:'h87]};
            bins last = {'h88};
        }
        coverpoint bif.din = {
            bins zero = {0};
            bins middle = {['h01:'h87]};
            bins last = {'h88};
        }
        coverpoint bif.dout = {
            bins zero = {0};
            bins middle = {['h01:'h87]};
            bins last = {'h88};
        }
    endgroup

    function new(bram_if bif);
        this.bif = bif;

    endfunction
endclass