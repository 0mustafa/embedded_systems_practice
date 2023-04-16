module 16x16_ram
# (
    parameter ADDR_WIDTH = 4,
    parameter DATA_WIDTH = 16,
    parameter DEPTH = 16
)
(
    input                   clk,
    input [ADDR_WIDTH-1:0] addr,
    inout [DATA_WIDTH-1:0] data,
    input                    cs,
    input                    we,
    input                    oe
);

reg [DATA_WIDTH-1:0] tmp_data;
reg [DATA_WIDTH-1:0] mem [DEPTH];

always @(posedge clk)begin
    if(cs & we)
        mem[addr] <= data;
end

always @(negedge clk)begin
    if(cs & !we)
        tmp_data <= mem[addr];
end

assign data = cs & oe & ! wr ? tmp_data : 'hz;
endmodule