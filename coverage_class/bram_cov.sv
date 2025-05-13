class bram_cov;

    virtual bram_if bif;


    function new(bram_if bif);
        this.bif = bif;
    endfunction
endclass