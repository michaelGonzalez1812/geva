
/**
***********************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica
       
		Autores: Michael Gonzalez Rivera
				 Erick Cordero Rojas
				 Victor Montero
				 Jorge
					
			Lenguaje: SystemVerilog
					Version: 1.0         
	
	Entradas: - Valor a convertir
				
	Restricciones:

   Salidas: - Resultado de la conversión

            
		Arquitectura de Computadores II 2019
				Prof. Jefferson Gonzales
************************************************/

import interfaces_def_pkg::*;



module data_mem_unit_vec (
    input logic clk,
    input logic reset,
    input logic mem_start,
    input logic [31:0] cpu_addr,
    input logic [31:0] mem_data_read, //from ram
    input logic [63:0] vec_data_in,
    input logic wr_en,
    output mem_unit_ctl_flags ctl_flags,
    output logic [63:0] vec_data_out,
    output logic mem_ready, in_wr_en);

	 
	 
	typedef enum { 
		WAIT ,
		BEGINING,
        MED,
        FINISHING,
        STILL_FINISHING,
        ALMOST_THERE,
        READY
    } state_types;

    state_types state;
    logic [31:0] current_addr;

    // assign ctl_flags.p_data = vec_data_in [31:0];
    always_ff @(posedge clk, posedge reset) begin
        if (reset) state = WAIT;
        else
            case (state)
                WAIT: begin
                    state = (mem_start == 1'b1) ? BEGINING : WAIT;
                    ctl_flags.addr = cpu_addr;
                    mem_ready = 1'b0;
                    in_wr_en <= 0;
                end
                
                BEGINING: begin
                    state = MED;
                    ctl_flags.addr = cpu_addr;
                    // write
                    in_wr_en = 1;
                    ctl_flags.p_data = vec_data_in[63:32] ;
                end

                MED: begin
                    state = FINISHING;
                    //read
                    // vec_data_out[31:0] = mem_data_read;
                    //write
                    ctl_flags.addr += 1;
                    ctl_flags.p_data = vec_data_in[31:0] ;
                    // ctl_flags.p_data = vec_data_in [31:0];
                end

                FINISHING: begin
                    state = STILL_FINISHING;
                    vec_data_out[63:32] = mem_data_read;
                    mem_ready = 1'b0;
                    
                    //read
                    // vec_data_out[63:32] = mem_data_read;
                end

                STILL_FINISHING:begin
                    state = ALMOST_THERE;
                    mem_ready = 1'b0;
                    in_wr_en = 0;
                    //read
                    // vec_data_out[63:32] = mem_data_read;
                end

                ALMOST_THERE:begin
                    state = READY;
                    mem_ready = 1'b0;
                    //read
                    vec_data_out[31:0] = mem_data_read;
                end

                READY: begin
                    state = WAIT;
                    mem_ready = 1'b1;
                    //read
                    // vec_data_out[63:32] = mem_data_read;
                end

                default: state = WAIT;
            endcase
    end
endmodule

    