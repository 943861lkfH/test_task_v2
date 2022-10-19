`timescale 1ns / 1ps

module MAX_8(
    input clk, rst, wr_en, [15:0] fifo_data_in,
    output reg data_valid, wire [15:0] data_max0, wire [15:0] data_max1, wire [15:0] data_max2, wire [15:0] data_max3, wire [15:0] data_max4, wire [15:0] data_max5, wire [15:0] data_max6, wire [15:0] data_max7, empty, full, reg [7:0] kol_one_bits
);

wire [15:0] fifo_data_out;

reg rd_en;
reg [15:0] res_max [0:7];
reg [1:0] station;
integer cnt, cnt_shift, cnt_search;
parameter s_read_fifo = 2'b00, s_search_max = 2'b01, s_kol_one_bits = 2'b10, s_out = 2'b11;

fifo_generator_0 FG0(
    .clk(clk),
    .srst(rst),
    .wr_en(wr_en),
    .din(fifo_data_in),
    .dout(fifo_data_out),
    .rd_en(rd_en),
    .full(full),
    .empty(empty));

always @(posedge clk)
begin
    if (rst)
    begin
        res_max[0] <= 16'b0;
        res_max[1] <= 16'b0;
        res_max[2] <= 16'b0;
        res_max[3] <= 16'b0;
        res_max[4] <= 16'b0;
        res_max[5] <= 16'b0;
        res_max[6] <= 16'b0;
        res_max[7] <= 16'b0;
        rd_en <= 0;
        kol_one_bits <= 8'h0;
        data_valid <= 0;
    end
end 

always @(posedge clk)
begin
    if (full)
    begin
        station <= s_read_fifo;
        rd_en = 1;
    end
end 

always @(posedge clk)
begin      
case (station)
    s_read_fifo:
        begin
            if (empty)
                begin
                    station <= s_kol_one_bits;
                end
            else
            begin
                rd_en <= 0;
                station <= s_search_max;
            end
        end
    s_search_max:
        begin
            begin : search
                for(cnt_search = 4'b0; cnt_search < 4'b1111; cnt_search = cnt_search + 1)
                begin
                    if(fifo_data_out > res_max[cnt_search])
                    begin
                        for (cnt_shift = 4'b111; cnt_shift > cnt_search; cnt_shift = cnt_shift - 1)
                        begin
                            res_max[cnt_shift] <= res_max[cnt_shift - 1];
                        end
                        res_max[cnt_search] = fifo_data_out;
                        rd_en <= 1;
                        station <= s_read_fifo;
                        
                        disable search;
                    end
                end
            end
            if  (cnt_search == 4'b1111) begin
                rd_en = 1;
                station <= s_read_fifo;
            end       
        end
    s_kol_one_bits:
        begin
            for(cnt = 0; cnt < 8; cnt = cnt + 1)
                for(cnt_shift = 0; cnt_shift < 16; cnt_shift = cnt_shift + 1)
                    begin
                        kol_one_bits = kol_one_bits + res_max[cnt][cnt_shift];
                    end
            station <= s_out;
        end
    s_out:
        data_valid = 1;
endcase
end

assign data_max0 = res_max[0];
assign data_max1 = res_max[1];
assign data_max2 = res_max[2];
assign data_max3 = res_max[3];
assign data_max4 = res_max[4];
assign data_max5 = res_max[5];
assign data_max6 = res_max[6];
assign data_max7 = res_max[7];

endmodule
