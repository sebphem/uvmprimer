// contains all of the global typedefs
package bfm_globals
    typedef logic[7:0] operand;
    typedef enum bit[2:0] { nop_op=3'b000,
                            add_op=3'b001,
                            and_op=3'b010,
                            xor_op=3'b011,
                            mult_op=3'b100,
                            rst_op=3'b101} opcode_t;
    typedef struct packed {
        operand A,
        operand B
    } operandAB_T;
endpackage