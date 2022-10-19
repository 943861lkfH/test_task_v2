`timescale 1ns / 1ps

module test_max_8();

reg clk, rst, wr_en;
reg [15:0] fifo_data_in;
wire data_valid, empty, full;
wire [7:0] kol_one_bits;
wire [15:0] data_max0, data_max1, data_max2, data_max3, data_max4, data_max5, data_max6, data_max7;

MAX_8 max_test(
    .clk(clk),
    .rst(rst),
    .fifo_data_in(fifo_data_in),
    .wr_en(wr_en),
    .empty(empty),
    .full(full),
    .data_max0(data_max0),
    .data_max1(data_max1),
    .data_max2(data_max2),
    .data_max3(data_max3),
    .data_max4(data_max4),
    .data_max5(data_max5),
    .data_max6(data_max6),
    .data_max7(data_max7),
    .kol_one_bits(kol_one_bits),
    .data_valid(data_valid));

integer    i;

initial
begin
    clk = 0;
    rst = 1;
    #20 rst = 0;
    wr_en = 1;
    /*fifo_data_in = 16'hAAAA;
    #20
    fifo_data_in = 16'hAA0B;
    #20
    fifo_data_in = 16'h000F;
    #20
    fifo_data_in = 16'h0086;
    #20
    fifo_data_in = 16'h04BB;
    #20
    fifo_data_in = 16'h1000;
    #20
    fifo_data_in = 16'h0B0B;
    #20
    fifo_data_in = 16'h1110;
    #20
    fifo_data_in = 16'h0000;
    #20
    fifo_data_in = 16'hCC06;
    #20
    fifo_data_in = 16'h000A;
    #20
    fifo_data_in = 16'h0523;
    #20
    fifo_data_in = 16'h00F7;
    #20
    fifo_data_in = 16'h06CC;
    #20
    fifo_data_in = 16'h0351;
    #20
    fifo_data_in = 16'h12C3;
    #20
    fifo_data_in = 16'hAF45;
    #20
    fifo_data_in = 16'h0065;
    #20
    fifo_data_in = 16'h0232;
    #20
    fifo_data_in = 16'h8651;
    #20
    fifo_data_in = 16'h0b0b;
    #20
    fifo_data_in = 16'h000F;
    #20
    fifo_data_in = 16'h0086;
    #20
    fifo_data_in = 16'h04BB;
    #20
    fifo_data_in = 16'h1000;
    #20
    fifo_data_in = 16'h0B0B;
    #20
    fifo_data_in = 16'hC000;
    #20
    fifo_data_in = 16'h0000;
    #20
    fifo_data_in = 16'h0806;
    #20
    fifo_data_in = 16'h000A;
    #20
    fifo_data_in = 16'h0523;
    #20
    fifo_data_in = 16'h00F7;
    #20
    fifo_data_in = 16'h06CC;
    #20
    fifo_data_in = 16'h0861;
    #20
    fifo_data_in = 16'h1200;
    #20
    fifo_data_in = 16'h1005;
    #20
    fifo_data_in = 16'h0065;
    #20
    fifo_data_in = 16'h0232;
    #20
    fifo_data_in = 16'h0051;
    #20
    fifo_data_in = 16'h030B;
    #20
    fifo_data_in = 16'h000F;
    #20
    fifo_data_in = 16'h0086;
    #20
    fifo_data_in = 16'h04BB;
    #20
    fifo_data_in = 16'h1000;
    #20
    fifo_data_in = 16'h0B0B;
    #20
    fifo_data_in = 16'h1010;
    #20
    fifo_data_in = 16'h0000;
    #20
    fifo_data_in = 16'h1111;
    #20
    fifo_data_in = 16'h000A;
    #20
    fifo_data_in = 16'h0523;
    #20
    fifo_data_in = 16'h00F7;
    #20
    fifo_data_in = 16'h06CC;
    #20
    fifo_data_in = 16'h1061;
    #20
    fifo_data_in = 16'h1003;
    #20
    fifo_data_in = 16'h0045;
    #20
    fifo_data_in = 16'h0065;
    #20
    fifo_data_in = 16'h0232;
    #20
    fifo_data_in = 16'h1011;
    #20
    fifo_data_in = 16'h8861;
    #20
    fifo_data_in = 16'h12A3;
    #20
    fifo_data_in = 16'h0145;
    #20
    fifo_data_in = 16'h0065;
    #20
    fifo_data_in = 16'h0232;
    #20
    fifo_data_in = 16'h0151;
    #20*/
    
    for (i = 0; i < 64; i = i + 1)
    begin
       fifo_data_in=$urandom%65535;
       #20;
    end
    wr_en = 0;
    
end

always #10 clk = ~clk;

endmodule