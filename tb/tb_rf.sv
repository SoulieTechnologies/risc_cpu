module tb_rf;
    logic clk = 0;
    logic rw;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;
    logic [31:0] wd;
    logic [31:0] out_rs1;
    logic [31:0] out_rs2;


    rf dut (
        .clk (clk),
        .rw (rw),
        .rs1 (rs1),
        .rs2 (rs2),
        .rd (rd),
        .wd (wd),
        .out_rs1 (out_rs1),
        .out_rs2 (out_rs2)
    );

    always #10  clk = ~clk;

    initial begin
        $dumpfile("sim/rf.vcd");
        $dumpvars(0, tb_rf);
        
            // TEST 1: Write then read

            rw = 1'b1; rd = 5'b1; wd = 32'b10101; @(posedge clk); #1; // Write
            rw = 1'b0; rs1 = 5'b1; #1; // Read
            assert(out_rs1 == 32'b10101) else $error ("WRITE/READ failed (TEST 1)");

            // TEST 2: Write with rw = 0

            rw = 1'b1; rd = 5'b1; wd = 32'b1; @(posedge clk); #1; // Write with rw = 1
            rw = 1'b0; rd = 5'b1; wd = 32'b10; @(posedge clk); #1; // Write with rw = 0
            rs1 = 5'b1; #1; // Read
            assert(out_rs1 == 32'b1) else $error ("Write with rw = 0 failed (TEST 2)");

            // TEST 3: Write twice, and then read
            
            rw = 1'b1; rd = 5'b1; wd = 32'b1; @(posedge clk); #1; // Write once
            rw = 1'b1; rd = 5'b1; wd = 32'b10; @(posedge clk); #1; // Write twice
            rs1 = 5'b1; #1; // Read
            assert(out_rs1 == 32'b10) else $error ("Write twice failed (TEST 3)");

            // TEST 4: x0 stays 0
            rw = 1'b1; rd = 5'b0; wd = 32'b1; @(posedge clk); #1; // Write to R0
            rs1 = 5'b0; #1; // Read
            assert(out_rs1 == 32'b0) else $error ("immutable x0 failed (TEST 4)");


            
            
            $display("All tests passed!");
            $finish;
        end
endmodule 