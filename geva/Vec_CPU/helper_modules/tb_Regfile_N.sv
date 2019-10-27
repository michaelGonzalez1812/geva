
module tb_Regfile_N;   

// regfile Parameters
parameter PERIOD  = 2;


// regfile Inputs
logic clk                            = 0 ;
logic we                             = 0 ;
logic [3:0] rd_addr1                 = 0 ;
logic [3:0] rd_addr2                             = 0 ;
logic [3:0] wr_addr                              = 0 ;
logic [31:0] wr_data_32            = 0 ;
logic [127:0] wr_data_128            = 0 ;

// regfile Outputs
logic [31:0] reg1_data_32          ;
logic [31:0] reg2_data_32                            ;
logic [127:0] reg1_data_128          ;
logic [127:0] reg2_data_128;

initial
begin
    forever #(PERIOD/2)  clk=~clk;
end


Regfile_N u_Regfile_N_32  (clk,
					 we,
					rd_addr1, rd_addr2, wr_addr,
					 wr_data_32,
					reg1_data_32, reg2_data_32);

Regfile_N #(128) u_Regfile_N_128  (clk,
					 we,
					rd_addr1, rd_addr2, wr_addr,
					wr_data_128,
					reg1_data_128, reg2_data_128);

initial
begin

    we=1;
    rd_addr1=3'd3;
    rd_addr2=3'd4;
    wr_addr= 3'd3;
    
    wr_data_128 = 128'd45;
    wr_data_32 = 32'd78;
    #10

    normal_write: assert (reg1_data_128 === 128'd45 && reg1_data_32 === 32'd78)
        else $error("Assertion normal_write failed!");

    we=1;
    rd_addr1=3'd3;
    rd_addr2=3'd4;
    wr_addr= 3'd4;
    
    wr_data_128 = 128'd455;
    wr_data_32 = 32'd788;
    #10

    assert (reg2_data_128 === 128'd455 && reg2_data_32 === 32'd788)
        else $error("Assertion normal_write failed!");

    we=0;
    rd_addr1=3'd3;
    rd_addr2=3'd4;
    wr_addr= 3'd3;
    
    wr_data_128 = 128'd589;
    wr_data_32 = 32'd238;
    #10

    disabled_test: assert (reg1_data_128 === 128'd45 && reg1_data_32 === 32'd78)
        else $error("Assertion disabled_test failed!");


    // $finish;
end

endmodule