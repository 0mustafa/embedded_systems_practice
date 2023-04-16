module traffic_lights(
    input sys_clk,      // clk input
    input sys_rst_n,    // reset input
    output reg [2:0] led     // 110 G, 101 R, 011 B
);

reg [31:0] counter;
reg [31:0] time_counter;

always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        counter <= 32'd0;
    else if (counter < 32'd2400_0000)   // 1s delay
        counter <= counter + 1;
    else if(counter == 32'd2400_0000)
        time_counter <= time_counter + 1;
    else
        counter <= 32'd0;
end


always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        led <= 3'b101;
    else if (time_counter == 32'd0003 && led == 3'b011) begin
        led <= 3'b110;
        time_counter <= 32'd0;
    end else if (time_counter == 32'd0005 && led == 3'b110) begin
        led <= 3'b101;
        time_counter <= 32'd0;
    end else if(time_counter == 32'd0010 && led == 3'b101) begin
        led <= 3'b011;
        time_counter <= 32'd0;
    end else
        led <= led;
end


endmodule