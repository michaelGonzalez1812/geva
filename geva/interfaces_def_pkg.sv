package interfaces_def_pkg;

    typedef struct packed {
        logic [15:0] addr_vga;
        logic [13:0] addr_cpu;
        logic [1:0]  out_vga_mtx_sel;
        logic [1:0]  out_cpu_mtx_sel;
        logic wren_cpu_block0;
        logic wren_cpu_block1;
        logic wren_cpu_block2;
    } addrs_deco_ctrl_sig;

    typedef struct packed {
        logic [31:0] addr;
        logic [31:0] p_data;
    } mem_unit_ctl_flags;
endpackage