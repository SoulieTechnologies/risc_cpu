module rf(
    input logic clk,
    input logic rw,
    input logic [4:0] rs1,
    input logic [4:0] rs2,
    input logic [4:0] rd,
    input logic [31:0] wd,
    output logic [31:0] out_rs1,
    output logic [31:0] out_rs2
);

logic [31:0] regs [32];

always_comb begin
    out_rs1 = rs1 != 0 ? regs[rs1] : 32'b0; 
    out_rs2 = rs2 != 0 ? regs[rs2] : 32'b0; 

end

always_ff @(posedge clk) begin
    if (rw && rd != 5'd0)
        regs[rd] <= wd;

end
endmodule

