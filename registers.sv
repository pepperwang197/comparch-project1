module registers (
    input logic clk;
    input logic wren;
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

    always_ff @(clk) begin
        if(wren) begin
            regs[rd] <= rdv;
        end
    end
