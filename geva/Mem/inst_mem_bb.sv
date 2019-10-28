module inst_mem_bb (
	address,
	clock,
	q);

	input	[31:0]  address;
	input	  clock;
	output	[15:0]  q;

	logic [31:0] addr_decoded;

    enum bit {
        BLOCK0 = 1'd0, 
        BLOCK1 = 1'd1
    } BLOCKS; 

	logic block_sel;

	logic [15:0] q_block0;
	logic [15:0] q_block1;

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

	assign block_sel = (address > 32'd65535)  ? BLOCK1 : BLOCK0;
	assign addr_decoded = (block_sel == BLOCK1) ? (address - 32'd65536) : address;
	assign q = (block_sel == BLOCK0) ? q_block0 : q_block1;
endmodule
