module alu (
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [3:0] alu_op,
    output logic [31:0] c,
    output logic z
);

always_comb begin
    case (alu_op)
        4'b0000: c = a + b;          // ADD
        4'b0001: c = a - b;          // SUB
        4'b0010: c = a & b;          //  AND
        4'b0011: c = a | b;          // OR
        4'b0100: c = a ^ b;          // XOR
        4'b0101: c = a << b[4:0];    // LSL
        4'b0110: c = a >> b[4:0];    // LSR
        4'b0111: c = $signed(a) >>> b[4:0];  // ASR
        4'b1000: c = ($signed(a) < $signed(b)) ? 32'b1 : 32'b0; // SLT
        4'b1001: c = (a < b) ? 32'b1 : 32'b0; // SLTU
        default: c = 32'b0;
    endcase
end
assign z = (c == 32'b0);
endmodule