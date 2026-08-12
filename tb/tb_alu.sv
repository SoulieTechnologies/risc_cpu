module tb_alu;

    logic [31:0] a;
    logic [31:0] b;
    logic [3:0] alu_op;
    logic [31:0] c;
    logic z;

    alu dut (
        .a (a),
        .b (b),
        .alu_op (alu_op),
        .c (c),
        .z (z)
    );

    initial begin

        $dumpfile("sim/alu.vcd");
        $dumpvars(0, tb_alu);
        // TEST 1: ADD

        a = 32'h5; b = 32'h3; alu_op = 4'b0000; #10;
        assert(c == 32'h8) else $error("ADD failed");

        // TEST 2: SUB
        
        a = 32'h5; b = 32'h3; alu_op = 4'b0001; #10;
        assert(c == 32'h2) else $error("SUB failed");

         // TEST 3: AND (1)

        a = 32'h5; b = 32'h5; alu_op = 4'b0010; #10;
        assert(c == 32'h5) else $error("AND (1) failed");

        // TEST 4: AND (2)

        a = 32'h5; b = 32'h0; alu_op = 4'b0010; #10;
        assert(c == 32'h0) else $error("AND (2) failed");

        // TEST 5: AND (3)

        a = 32'h5; b = 32'h2; alu_op = 4'b0010; #10;
        assert(c == 32'h0) else $error("AND (3) failed");

        // TEST 6: OR (1)

        a = 32'h5; b = 32'h2; alu_op = 4'b0011; #10;
        assert(c == 32'h7) else $error("OR (1) failed");

        // TEST 7: OR (2)

        a = 32'h2; b = 32'h2; alu_op = 4'b0011; #10;
        assert(c == 32'h2) else $error("OR (2) failed");

        // TEST 7: OR (3)

        a = 32'h2; b = 32'h0; alu_op = 4'b0011; #10;
        assert(c == 32'h2) else $error("OR (3) failed");

        // TEST 8: XOR (1)

        a = 32'h2; b = 32'h2; alu_op = 4'b0100; #10;
        assert(c == 32'h0) else $error("XOR (1) failed");

        // TEST 9: XOR (2)

        a = 32'h2; b = 32'h0; alu_op = 4'b0100; #10;
        assert(c == 32'h2) else $error("XOR (2) failed");

        // TEST 10: XOR (3)

        a = 32'h5; b = 32'h2; alu_op = 4'b0100; #10;
        assert(c == 32'h7) else $error("XOR (3) failed");

        // TEST 11: LSL (1)

        a = 32'h2; b = 32'h2; alu_op = 4'b0101; #10;
        assert(c == 32'h8) else $error("LSL (1) failed");

        // TEST 12: LSL (2)

        a = 32'h2; b = 32'h0; alu_op = 4'b0101; #10;
        assert(c == 32'h2) else $error("LSL (2) failed");

        // TEST 13: LSL (3)

        a = 32'h0; b = 32'h5; alu_op = 4'b0101; #10;
        assert(c == 32'h0) else $error("LSL (3) failed");

        // TEST 14: LSR (1)

        a = 32'h4; b = 32'h1; alu_op = 4'b0110; #10;
        assert(c == 32'h2) else $error("LSR (1) failed");
        
        // TEST 15: LSR (2)

        a = 32'h4; b = 32'h0; alu_op = 4'b0110; #10;
        assert(c == 32'h4) else $error("LSR (2) failed");

        // TEST 16: LSR (3)

        a = 32'h0; b = 32'h5; alu_op = 4'b0110; #10;
        assert(c == 32'h0) else $error("LSR (3) failed");

        // TEST 17: LSR (4)

        a = 32'hFFFFFFF8; b = 32'h1; alu_op = 4'b0110; #10;
        assert(c == 32'h7FFFFFFC) else $error("LSR (4) failed");

        // TEST 18: ASR (1)

        a = 32'hFFFFFFF8; b = 32'h1; alu_op = 4'b0111; #10;
        assert(c == 32'hFFFFFFFC) else $error("ASR (1) failed");

        // TEST 19: ASR (2)

        a = 32'h8; b = 32'h1; alu_op = 4'b0111; #10;
        assert(c == 32'h4) else $error("ASR (2) failed");

        // TEST 20: SLT (1)

        a = 32'h4; b = 32'h8; alu_op = 4'b1000; #10;
        assert(c == 32'h1) else $error("SLT (1) failed");

        // TEST 21: SLT (2)

        a = 32'h8; b = 32'h4; alu_op = 4'b1000; #10;
        assert(c == 32'h0) else $error("SLT (2) failed");

        // TEST 22: SLT (3)

        a = 32'h0; b = 32'h0; alu_op = 4'b1000; #10;
        assert(c == 32'h0) else $error("SLT (3) failed");

        // TEST 23: SLT (4)

        a = 32'hFFFFFFF1; b = 32'h1; alu_op = 4'b1000; #10;
        assert(c == 32'h1) else $error("SLT (4) failed");
    
        // TEST 24: SLTU (1)

        a = 32'h4; b = 32'h8; alu_op = 4'b1001; #10;
        assert(c == 32'h1) else $error("SLTU (1) failed");

        // TEST 25: SLTU (2)

        a = 32'h8; b = 32'h4; alu_op = 4'b1001; #10;
        assert(c == 32'h0) else $error("SLTU (2) failed");

        // TEST 26: SLTU (3)

        a = 32'h0; b = 32'h0; alu_op = 4'b1001; #10;
        assert(c == 32'h0) else $error("SLTU (3) failed");

        // TEST 27: SLTU (4)

        a = 32'hFFFFFFF1; b = 32'h1; alu_op = 4'b1001; #10;
        assert(c == 32'h0) else $error("SLTU (4) failed");

        // TEST 28: Z flag (1)

        a = 32'h2; b = 32'h2; alu_op = 4'b0001; #10;
        assert(z == 1'b1) else $error("Z flag (1) failed");

        // TEST 29: Z flag (2)

        a = 32'h2; b = 32'h1; alu_op = 4'b0010; #10;
        assert(z == 1'b1) else $error("Z flag (2) failed"); 

        // TEST 30: Z flag (3)

        a = 32'h2; b = 32'h1; alu_op = 4'b0000; #10;
        assert(z == 1'b0) else $error("Z flag (3) failed"); 
        
        $display("All tests passed!");
        $finish;
    end
endmodule