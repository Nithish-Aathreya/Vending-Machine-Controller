module vending(
    input logic clk, reset, coin_in,
    input logic [3:0] coin_value,
    output logic [3:0] refund,
    output logic [3:0] push
);


typedef enum logic [1:0] {
    S0 = 2'b00,  
    S1 = 2'b01,  
    S2 = 2'b10, 
    S3 = 2'b11  
} state_t;

state_t state, next_state;
logic [3:0] total_amount; 


parameter IDLE = 4'b1000, ITEM_SEL = 4'b0100, DISPENSE = 4'b0010, REFUND_SIG = 4'b0001;


always_ff @(posedge clk or posedge reset) begin
    if (reset)
        state <= S0;  
    else
        state <= next_state;
end

// Next State Logic (Combinational Logic)
always_comb begin
    next_state = state; // Default: stay in current state

    case (state)
        S0: if (coin_in) next_state = S1;  // Coin inserted -> Go to selection
        
        S1: begin
            if (total_amount >= 4'b0101) 
                next_state = S2;  // Sufficient amount -> Dispense
            else 
                next_state = S3;  // Insufficient amount -> Refund full amount
        end
        
        S2: begin
            if (total_amount > 4'b0101) 
                next_state = S3;  // If extra money, go to refund state
            else 
                next_state = S0;  // Otherwise, go back to idle
        end
        
        S3: next_state = S0; // After refund, go back to idle
    endcase
end


always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        push <= IDLE;
        refund <= 4'b0000;
        total_amount <= 4'b0000;
    end else begin
        case (state)
            S0: begin
                push <= IDLE;
                if (coin_in) total_amount <= total_amount + coin_value;  // Accumulate coins
            end

            S1: begin
                push <= ITEM_SEL;
            end

            S2: begin
                push <= DISPENSE;
                if (total_amount <= 4'b0101) 
                    total_amount <= 4'b0000; 
            end
 
          

            S3: begin
                push <= REFUND_SIG;
                refund <= (total_amount > 4'b0101) ? (total_amount - 4'b0101) : total_amount; // Refund logic
                total_amount <= 4'b0000; // Reset total amount after refund
            end

            default: push <= IDLE;
        endcase
    end
end

endmodule
