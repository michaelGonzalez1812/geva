module shifter_module (
    input logic [31:0] A, 
    input logic [4:0] B,
    input logic shift_op,
    output logic [31:0] Y
);

logic [31:0] right_shift, left_shift;

assign right_shift = A >> B;
assign left_shift = A << B;

assign Y = shift_op ? right_shift : left_shift;

    
endmodule