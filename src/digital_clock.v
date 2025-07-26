`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2025 16:46:36
// Design Name: 
// Module Name: digital_clock
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module digital_clock(
    input clk,           // 50 MHz main clock
    input rst,           // reset button
    output reg [7:0] seg,  // segment output (active low)
    output reg [3:0] an   // digit enable (active low)
);

    wire clk_1Hz;
    wire clk_1kHz;

    reg [5:0] sec = 0;
    reg [5:0] min = 0;
    reg [1:0] digit_sel = 0;
    reg [3:0] digit_data;

    // Instantiate clock dividers
    clk_divider_1Hz  clk1 (.clk(clk), .clk_out(clk_1Hz));
    clk_divider_1kHz clk2 (.clk(clk), .clk_out(clk_1kHz));

    // Update time every 1 second
    always @(posedge clk_1Hz or posedge rst) begin
        if (rst) begin
            sec <= 0;
            min <= 0;
        end else begin
            if (sec == 59) begin
                sec <= 0;
                if (min == 59)
                    min <= 0;
                else
                    min <= min + 1;
            end else
                sec <= sec + 1;
        end
    end

    // Multiplex display using 1 kHz refresh clock
    always @(posedge clk_1kHz) begin
        digit_sel <= digit_sel + 1;

       case (digit_sel)
    2'b00: begin
        digit_data <= sec % 10;
        an <= 4'b0001;
    end
    2'b01: begin
        digit_data <= sec / 10;
        an <= 4'b1000;
    end
    2'b10: begin
        digit_data <= min % 10;
        an <= 4'b0100;
    end
    2'b11: begin
        digit_data <= min / 10;
        an <= 4'b0010;
    end
endcase

        // BCD to 7-segment decoder (active low)
        case (digit_data)
            4'd0: seg <= 8'b00000011;
            4'd1: seg <= 8'b10011111;
            4'd2: seg <= 8'b00100101;
            4'd3: seg <= 8'b00001101;
            4'd4: seg <= 8'b10011001;
            4'd5: seg <= 8'b01001001;
            4'd6: seg <= 8'b01000001;
            4'd7: seg <= 8'b00011111;
            4'd8: seg <= 8'b00000001;
            4'd9: seg <= 8'b00001001;
            default: seg <= 8'b11111111;
        endcase
    end

endmodule

