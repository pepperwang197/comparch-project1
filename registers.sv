module registers (
    input logic clk,
    input logic wren,
    input logic [4:0] rs1,
    input logic [4:0] rs2,
    input logic [4:0] rd,
    input logic [31:0] rdv,
    output logic [31:0] rs1v,
    output logic [31:0] rs2v
);

    logic [31:0] regs [31:0]

    assign rs1v = regs[rs1];
    assign rs2v = regs[rs2];

    assign regs[5'b0] = 32'b0;

    always_ff @(clk) begin
        if(wren && rd != 5'b0) begin
            regs[rd] <= rdv;
        end
    end
endmodule