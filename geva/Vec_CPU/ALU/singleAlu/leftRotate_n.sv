module leftRotate_n #(parameter N=8)
				(input  logic [N-1:0] B, 
             input  logic [$clog2(N)-1:0]  A, 
             output logic [N-1:0] Y);
                 
            logic [N-1:0] B_temp;
			assign {Y,B_temp} = {B,B} << A;	 
				 
endmodule