`timescale 1 ns / 1 ns
module data_mem_tb ();

	logic	[15:0]  address_a;
	logic	[13:0]  address_b;
	logic	  clock;
	logic	[7:0]  data_a;
	logic	[31:0]  data_b;
	logic	  wren_a;
	logic	  wren_b;
	logic	[7:0]  q_a;
	logic	[31:0]  q_b;
    logic	[31:0]  contador;

    data_mem	DUT (
        .address_a ( address_a ),
        .address_b ( address_b ),
        .clock ( clock ),
        .data_a ( data_a ),
        .data_b ( data_b ),
        .wren_a ( wren_a ),
        .wren_b ( wren_b ),
        .q_a ( q_a ),
        .q_b ( q_b )
        );

    always begin
		#1
		clock = ~clock;
	end

	always@(posedge clock) begin
		contador <= contador + 1;
		if (contador >= 15)
			$stop;
	end


    initial begin
        address_a = 16'b0;
        address_b = 14'b0;
        clock = 1'b0;
        data_a = 8'b0;
        data_b = 32'b0;
        wren_a = 1'b0;
        wren_b = 1'b0;
		contador = 16'b0;
    end

    /*******************************
     * Prueba 1
     * Escritura en puerto de 8 bits
     *******************************/
    /*
    initial begin
        #2;
		data_a = 16'b1;
        wren_a = 1'b1;

        #2;
        wren_a = 1'b0;
	end
    */

    /*******************************
     * Prueba 2
     * Escribir en purto de 32 bits
     *******************************/
    /*
    initial begin
        #2;
		data_b = 32'b100000000000;
        wren_b = 1'b1;

        #2;
        wren_b = 1'b0;
	end
    */

    /*******************************
     * Prueba 3
     * Leer en puerto de 8 bits 
     * Escribir en puerto 32 bits
     * al mismo tiempo
     *******************************/
    initial begin
        #2;
		data_b = 32'b1;
        wren_b = 1'b1;

        #2;
        wren_b = 1'b0;
	end
    
endmodule
