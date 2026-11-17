module top(
    input logic clk,
);

    logic [2:0] funct3 = 3'b010;
    logic dmem_wren = 1'b0;
    logic [31:0] dmem_address = 31'd0;
    logic [31:0] dmem_data_in = 31'd0;
    logic [31:0] dmem_data_out;
    logic [31:0] imem_address = 31'h1000;
    logic [31:0] instruction;

    logic reset;
    logic led;
    logic red;
    logic green;
    logic blue;

    memory #(
        .IMEM_INIT_FILE_PREFIX  ("rv32i_test")
    ) u1 (
        .clk            (clk), 
        .funct3         (funct3), 
        .dmem_wren      (dmem_wren), 
        .dmem_address   (dmem_address), 
        .dmem_data_in   (dmem_data_in), 
        .imem_address   (imem_address), 
        .imem_data_out  (instruction), 
        .dmem_data_out  (dmem_data_out), 
        .reset          (reset), 
        .led            (led), 
        .red            (red), 
        .green          (green), 
        .blue           (blue)
    );

    logic [31:0] pc;
    logic [31:0] instruction;

    always_comb begin
        imem_address = pc;
        case (instruction[6:0])
            7'b0110011:
                // R type instruction
    end
    
    always_ff @(posedge clk) begin
        pc <= pc + 32'd4;
    end
