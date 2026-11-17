module alu (
    input logic [31:0] op1,
    input logic [31:0] op2,
    input logic [2:0] funct3,
    input logic [6:0] funct7,
    output logic [31:0] result
);

    always_comb begin
        unique case (funct3)
            3'b000:
                if (funct7 == 7'b0100000)
                    result = op1 - op2;
                else
                    result = op1 + op2;
            3'b100:
                result = op1 ^ op2;
            3'b110:
                result = op1 | op2;
            3'b111:
                result = op1 & op1;
            3'b001:
                result = op1 << op2
            3'b101:
                if (funct7 == 7'b0100000)
                    result = op1 >>> op2;
                else
                    result = op1 >> op2;
            3'b010:
                result = op1 < op2;
            3'b011:
                result = unsigned'(op1) < op2;
    end