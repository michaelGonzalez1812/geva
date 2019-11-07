module geva(
    input logic clk, reset, image_select,
    input logic [1:0] alg_select,
    output logic pixlclk, hsync, vsync, sync_b, blank_b,
    output logic [7:0] R, G, B);
    
  




logic [31:0] pc, pc_plus_offset, cpu_addr, cpu_data, mem_data, video_address;
logic [15:0] instruction, instruction0, instruction1, instruction2, instruction3;
logic [7:0] out_data_vga;
logic wr_enable;

int alg0_offset = 0;
int alg1_offset = 65536;
// int alg2_offset = 0;
// int alg3_offset = 0;

// assign pc_plus_offset = alg_select ? pc + alg0_offset : pc + alg1_offset;

// inst_mem_bb instr_mem (pc_plus_offset,clk,instruction);
  
assign instruction = alg_select == 0 ? instruction0 : alg_select == 1 ?  instruction1 : alg_select == 2 ?  instruction2 : instruction3;

imem inst_mem(pc,instruction0);
imem inst_mem1(pc,instruction1);
imem inst_mem2(pc,instruction2);
imem inst_mem3(pc,instruction3);

data_mem_bb data_mem( clk, cpu_addr,  video_address,  wr_enable,  cpu_data,	out_data_vga, mem_data);


vec_cpu  u_vec_cpu (
    .clk                 (  clk                  ),
    .reset                     ( reset                      ),
    .instruction  ( instruction   ),
    .mem_data     ( mem_data      ),

    .wr_enable           (wr_enable            ),
    .pc           (pc            ),
    .cpu_addr                  ( cpu_addr                   ),
    .cpu_data                  ( cpu_data                   )
);

vgaModule vga_mod( clk, reset, image_select, out_data_vga, pixlclk, hsync, vsync, sync_b, blank_b, R, G, B, video_address);








endmodule 