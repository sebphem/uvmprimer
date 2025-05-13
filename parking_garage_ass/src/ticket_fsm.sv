module ticket_fsm #(
        parameter TIMER_LENGTH_SEC = 5;
        parameter DWIDTH = 16;
        parameter CLOCK_MHZ = 100;
    )(
        input clk,
        input reset_n,
        input entry_sensor,
        input exit_sensor,
        input request_btn,
        input ticket_removed,
        input ticket_inserted,
        input ticket_ok,
        input paper_empty, // 
        input bill_2,
        input bill_4,
        input timeout_5s,
        input logic [DWIDTH-1:0] parking_time_min,

        output reg printer_cmd,
        output take_ticket_lamp,
        output out_of_service_lamp,
        output reg entry_gate,
        output reg exit_gate,
        output reg fee_display, //bcd value
        output thank_you_lamp, //blink twice when paid
        output see_attendant_lamp, //steady when unreadable ticket
    ) 
    typedef enum logic [3:0] {IDLE_E, PRINT, WAIT_TAKE, E_GATE_OPEN, IDLE_X, CALC_FEE, WAIT_PAY, X_GATE_OPEN, ERROR} state_t;
    logic [DWIDTH-1:0] cur_timer, timer_next;
    state_t cur_state, next_state;

    always_ff @(posedge clk or negedge reset_n) begin
        if(!resetn) begin
            cur_state <= IDLE_E;
            cur_timer <= 0;
        end else begin
            cur_state <= next_state;
            cur_timer <= timer_next;
        end
    end

    //one car at a time
    //one must enter before another can leave

    always_comb begin
        printer_cmd = 0;
        take_ticket_lamp = 0;
        case(cur_state)
            //entry
            (IDLE_E): begin
                //entry
                if(entry_sensor && request_btn) begin
                    next_state = PRINT;
                end
            end
            (PRINT): begin
                //entry
                printer_cmd = 1;
                next_state = WAIT_TAKE;
            end
            (WAIT_TAKE): begin
                //entry
                take_ticket_lamp = 1;
                if(entry_sensor && ticket_removed) begin

                end
            end
            (E_GATE_OPEN): begin
                
            end
            //exit
            default: begin
                next_state = IDLE_E;
            end
        endcase
    end

endmodule