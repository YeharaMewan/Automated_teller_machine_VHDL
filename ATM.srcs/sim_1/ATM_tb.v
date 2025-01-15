`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2024 06:03:31 PM
// Design Name: 
// Module Name: ATM_tb
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

module ATM_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [3:0] card_number;
    reg [3:0] pin_number;
    reg [3:0] withdraw_amount;
    reg card_inserted;

    // Outputs
    wire account_blocked;
    wire error;
    wire cash_dispensed;
    wire exit;
    wire [7:0] balance;

    // Instantiate the ATM module
    ATM uut (
        .clk(clk),
        .reset(reset),
        .card_number(card_number),
        .pin_number(pin_number),
        .withdraw_amount(withdraw_amount),
        .card_inserted(card_inserted),
        .account_blocked(account_blocked),
        .error(error),
        .cash_dispensed(cash_dispensed),
        .exit(exit),
        .balance(balance)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;
        card_number = 4'b0000;
        pin_number = 4'b0000;
        withdraw_amount = 4'b0000;
        card_inserted = 0;

        // Hold reset for a few cycles
        #10 reset = 0;

        // Test Case 1: Valid Card and Correct PIN, Withdraw amount
        $display("Test Case 1: Valid Card and Correct PIN");
        card_inserted = 1;
        card_number = 4'b1010;   // Correct card number
        #10; // Wait for card input

        $display("Initial Balance: %d", balance);  // Display initial balance

        pin_number = 4'b1100;     // Correct PIN
        #10; // Wait for PIN entry

        withdraw_amount = 4'b0010; // Withdraw $2
        #10; // Wait for transaction to process

        $display("Balance after withdrawal: %d", balance);
        if (cash_dispensed) $display("Test Case 1 Passed: Cash dispensed successfully.");
        else $display("Test Case 1 Failed: Cash not dispensed.");

        #10 card_inserted = 0;

        // Test Case 2: Attempt withdrawal with insufficient balance
        $display("Test Case 2: Withdraw more than balance");
        card_inserted = 1;
        card_number = 4'b1010;   // Correct card number
        #10;

        pin_number = 4'b1100;     // Correct PIN
        #10;

        withdraw_amount = 8'd150; // Attempt to withdraw $150, which is more than balance
        #10;

        $display("Balance after attempted over-withdrawal: %d", balance);
        if (error) $display("Test Case 2 Passed: Error for insufficient funds.");
        else $display("Test Case 2 Failed: No error for insufficient funds.");

        #10 card_inserted = 0;

        // Test Case 3: Check balance after resetting
        $display("Test Case 3: Reset and Check Initial Balance");
        reset = 1;
        #10;
        reset = 0;
        card_inserted = 1;
        card_number = 4'b1010;   // Correct card number
        pin_number = 4'b1100;    // Correct PIN
        #10;

        $display("Balance after reset: %d", balance);
        if (balance == 8'd100) $display("Test Case 3 Passed: Balance reset correctly.");
        else $display("Test Case 3 Failed: Balance did not reset.");

        #10 card_inserted = 0;

        // End of Test
        $display("End of Testbench.");
        $finish;
    end

endmodule


