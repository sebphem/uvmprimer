class basic_env extends uvm_env;

    basic_seq seq;
    basic_driver driver;


    function new(string name="basic_env", uvm_component  parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        seq = basic_seq::type_id::create("seq", this);
        driver = basic_driver::type_id::create("driver", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        driver.seq_item_port.connect(seq.seq_item_export);
    endfunction
endclass