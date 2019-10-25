module vgaAddressDecoder #(parameter BASE_IMAGE_XPOS = 10'd150,
                            BASE_IMAGE_XEDGE = BASE_IMAGE_XPOS + 10'd250, 
                            BASE_IMAGE_YPOS = 10'd80,
                            BASE_IMAGE_YEDGE = BASE_IMAGE_YPOS + 10'd250)
                    (input logic image_select,
                    input logic [9:0] hcnt, vcnt,

                    output logic [31:0] video_address );


logic [31:0] base_image_offset = 0;
logic [31:0] encrypted_image_offset = 32'h10000; //  2^16 = 65536
logic [31:0] black_address = 32'hFFFF; //  to show in the borders
logic [31:0] selected_image_offset, y_mulitply, x_extended;


logic [9:0] inner_x, inner_y;

logic is_visible;

assign is_visible = (hcnt >= BASE_IMAGE_XPOS &&  hcnt <= BASE_IMAGE_XEDGE) && (vcnt >= BASE_IMAGE_YPOS && vcnt <= BASE_IMAGE_YEDGE);


assign x_extended = {22'b0,inner_x};
assign y_mulitply = inner_y * 32'd250;

assign selected_image_offset = image_select ? base_image_offset : encrypted_image_offset;


always_comb begin
    if(is_visible) begin
        inner_x <= hcnt - BASE_IMAGE_XPOS;
        inner_y <= vcnt - BASE_IMAGE_YPOS;
    end
    else begin
        inner_x <= 0;
        inner_y <= 0;
    end
end

assign video_address = is_visible ? selected_image_offset + y_mulitply + x_extended : black_address;
    
endmodule