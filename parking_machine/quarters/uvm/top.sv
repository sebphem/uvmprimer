import uvm_pkg::*;
import quarter_uvm_package::*;



module top;

    quarter_if qif();

    parking_machine DUT(
        .clk(qif.clk),
        .reset_n(qif.reset_n),
        .quarter_slot(qif.quarter_slot),
        .ticket(qif.ticket)
    );

    initial begin
        uvm_config_db#(virtual quarter_if)::set(this, "*","qif", qif);
        run_test();
    end

endmodule : top