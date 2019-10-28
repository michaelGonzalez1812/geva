module inst_mem_bb (
	address,
	clock,
	q);

	input	[31:0]  address;
	input	  clock;
	output	[15:0]  q;

	logic [31:0] addr_decoded;

    enum bit [1:0] {
        BLOCK0 = 2'd0, 
        BLOCK1 = 2'd1, 
        BLOCK2 = 2'd2
    } BLOCKS; 

	logic [1:0] block_sel;

	logic [15:0] q_block0;
	logic [15:0] q_block1;
	logic [15:0] q_block2;

	inst_mem_block0 mem_block0 (
		.address ( addr_decoded [15:0] ),
		.clock ( clock ),
		.q ( q_block0 )
	);

	inst_mem_block1 mem_block1 (
		.address ( addr_decoded [15:0] ),
		.clock ( clock ),
		.q ( q_block1 )
	);

	inst_mem_block2 mem_block2 (
		.address ( addr_decoded [15:0] ),
		.clock ( clock ),
		.q ( q_block2 )
	);

	assign block_sel = 
        (address > 32'd131071) ? BLOCK2 :
        (address > 32'd65535)  ? BLOCK1 : BLOCK0;

	assign addr_decoded = 
        (block_sel == BLOCK2) ? (address - 32'd131072) :
        (block_sel == BLOCK1) ? (address - 32'd65536) : address;

	assign q =
        (block_sel == BLOCK0) ? q_block0 :
        (block_sel == BLOCK1) ? q_block1 : q_block2;
endmodule
