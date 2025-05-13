module parking_machine#(
)(
    input clk,
    input reset_n,
    input quarter_slot,
    output ticket
)
    typedef enum logic [3:0] {S0, S25, S50, S75} state_t;
    state_t cur_state, next_state;

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            cur_state <= S0;
        end else begin
            cur_state <= next_state;
        end
    end

    always_comb begin
        ticket = 0;
        case(cur_state)

            (S0): begin
                next_state = S0
                if (quarter_slot) next_state = S25;
            end
            (S25): begin
                next_state = S25
                if (quarter_slot) next_state = S50;
            end
            (S50): begin
                next_state = S50
                if (quarter_slot) next_state = S75;
            end
            (S75): begin
                next_state = S0
                ticket = 1;
            end
        endcase
    end
endmodule