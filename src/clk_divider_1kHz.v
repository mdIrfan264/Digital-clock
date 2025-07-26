`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2025 16:49:18
// Design Name: 
// Module Name: clk_divider_1kHz
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


module clk_divider_1kHz(
    input clk,
    output reg clk_out = 0
);
    reg [15:0] count = 0; // 50M / (2 * 25k) = 1kHz

    always @(posedge clk) begin
        count <= count + 1;
        if (count == 25_000) begin
            clk_out <= ~clk_out;
            count <= 0;
        end
    end
endmodule
