`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2025 16:47:35
// Design Name: 
// Module Name: clk_divider_1Hz
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


module clk_divider_1Hz(
    input clk,
    output reg clk_out = 0
);
    reg [25:0] count = 0; // 50M / 2 = 25M counts

    always @(posedge clk) begin
        count <= count + 1;
        if (count == 25_000_000) begin
            clk_out <= ~clk_out;
            count <= 0;
        end
    end
endmodule
