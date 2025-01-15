`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2024 06:02:20 PM
// Design Name: 
// Module Name: ATM
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

module ATM (
    input clk,
    input reset,
    input [3:0] card_number,
    input [3:0] pin_number,
    input [3:0] withdraw_amount,
    input card_inserted,
    output reg account_blocked,
    output reg error,
    output reg cash_dispensed,
    output reg exit,
    output reg [7:0] balance  // Register to hold and display the balance
);

    // Registers to store attempt counter and initial balance
    reg [3:0] attempt_counter;
    reg [7:0] initial_balance;  // Initial balance set for the account

    // Parameters (set initial values)
    initial begin
        initial_balance = 8'd100; // Set initial balance to $100
    end

    // Reset logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            attempt_counter <= 0;
            account_blocked <= 0;
            error <= 0;
            cash_dispensed <= 0;
            balance <= initial_balance; // Reset balance to initial value
            exit <= 0;
        end else if (card_inserted && !account_blocked) begin
            if (card_number == 4'b1010) begin // Condition for match found (example)
                if (pin_number == 4'b1100) begin // Condition for correct PIN (example)
                    error <= 0;
                    if (withdraw_amount <= balance) begin // Check balance for withdrawal
                        balance <= balance - withdraw_amount; // Update balance
                        cash_dispensed <= 1;
                    end else begin
                        cash_dispensed <= 0;
                        error <= 1; // Not enough balance
                    end
                end else begin
                    attempt_counter <= attempt_counter + 1;
                    error <= 1;
                    if (attempt_counter >= 3) begin
                        account_blocked <= 1; // Block account after 3 incorrect attempts
                    end
                end
            end else begin
                error <= 1; // Invalid card number
            end
        end else if (!card_inserted) begin
            cash_dispensed <= 0;
            error <= 0;
            exit <= 1;
        end
    end
endmodule
module ATM (
    input clk,
    input reset,
    input [3:0] card_number,
    input [3:0] pin_number,
    input [3:0] withdraw_amount,
    input card_inserted,
    output reg account_blocked,
    output reg error,
    output reg cash_dispensed,
    output reg exit,
    output reg [7:0] balance  // Register to hold and display the balance
);

    // Registers to store attempt counter and initial balance
    reg [3:0] attempt_counter;
    reg [7:0] initial_balance;  // Initial balance set for the account

    // Parameters (set initial values)
    initial begin
        initial_balance = 8'd100; // Set initial balance to $100
    end

    // Reset logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            attempt_counter <= 0;
            account_blocked <= 0;
            error <= 0;
            cash_dispensed <= 0;
            balance <= initial_balance; // Reset balance to initial value
            exit <= 0;
        end else if (card_inserted && !account_blocked) begin
            if (card_number == 4'b1010) begin // Condition for match found (example)
                if (pin_number == 4'b1100) begin // Condition for correct PIN (example)
                    error <= 0;
                    if (withdraw_amount <= balance) begin // Check balance for withdrawal
                        balance <= balance - withdraw_amount; // Update balance
                        cash_dispensed <= 1;
                    end else begin
                        cash_dispensed <= 0;
                        error <= 1; // Not enough balance
                    end
                end else begin
                    attempt_counter <= attempt_counter + 1;
                    error <= 1;
                    if (attempt_counter >= 3) begin
                        account_blocked <= 1; // Block account after 3 incorrect attempts
                    end
                end
            end else begin
                error <= 1; // Invalid card number
            end
        end else if (!card_inserted) begin
            cash_dispensed <= 0;
            error <= 0;
            exit <= 1;
        end
    end
endmodule





