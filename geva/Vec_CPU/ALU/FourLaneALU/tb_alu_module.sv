
module tb_alu_module;

// alu_module Parameters
parameter PERIOD  = 2;


// alu_module Inputs
logic clk                            = 0 ;
logic reset = 0;
logic alu_st                               = 0 ;
logic [3:0] alu_op                   = 0 ;
logic [7:0] esc                      = 0 ;
logic [63:0] vec1                    = 0 ;
logic [63:0] vec2                                 = 0 ;

// alu_module Outputs
logic alu_rdy                        ;
logic [63:0] vec_result              ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end



alu_module  u_alu_module (clk, reset, alu_st, alu_op, esc, vec1, vec2, alu_rdy, vec_result );

initial
begin

    //suma vector vector
    alu_st = 1; alu_op = 4'b1010; vec1 = 64'd100; vec2 = 64'd153;#10

    vec_sum: assert (vec_result === 64'd253)
        else $error("Assertion vec_sum failed!");

    
    alu_st = 1; alu_op = 4'b1010; vec1 = 64'h1122334455667788; vec2 = 64'h1122334455667788;#10

    assert (vec_result === 64'h22446688AACCEE10)
        else $error("Assertion vec_sum failed!");
    

        // resta vector vector
alu_st = 1; alu_op = 4'b1100; vec1 = 64'h1122334455667788; vec2 = 64'h1122334455667788;#10

    assert (vec_result === 64'h0)
        else $error("Assertion vec_sum failed!");


        //suma vector escalar
    alu_st = 1; alu_op = 4'b1011; vec1 = 64'h11220033; esc = 8'h22;#10

    assert (vec_result === 64'h2222222233442255)
        else $error("Assertion suma vecotr escalar failed!");

           //resta vector escalar
    alu_st = 1; alu_op = 4'b1101; vec1 = 64'h66220033; esc = 8'h22;#10

    assert (vec_result === 64'hdededede4400de11)
        else $error("Assertion resta vector escalar failed!");

    
    alu_st = 1; alu_op = 4'b1010; vec1 = 64'h1122334455667788; vec2 = 64'h1122334455667788;#10

    assert (vec_result === 64'h22446688AACCEE10)
        else $error("Assertion vec_sum failed!");
    
end

endmodule