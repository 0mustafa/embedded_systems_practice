module led(
input sys_clk,
input sys_rst_n,
output reg [2:0] led); //101 Green, 011 Blue, 110 Red

reg [31:0] counter;
reg [7:0] a;

always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        counter <= 32'd0;
    else if(counter < 32'd0004_3200_0000)
        counter <= counter + 1;
    else
        counter <= 32'd0;
end

always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        led <= 3'b110;
    else if(counter == 32'd0002_4000_0000 && led == 3'b110)
        led <= 3'b011;
    else if(counter == 32'd0003_1200_0000 && led == 3'b011)
        led <= 3'b101;
    else if(counter == 32'd0004_3200_0000 && led == 3'b101)
        led <= 3'b110;
    else
        led <= led;
end

endmodule