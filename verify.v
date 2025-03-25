

module vending_tb;

  
    logic clk, reset, coin_in;
    logic [3:0] coin_value;
    logic [3:0] refund, push;
    
    
    vending uut (
        .clk(clk),
        .reset(reset),
        .coin_in(coin_in),
        .coin_value(coin_value),
        .refund(refund),
        .push(push)
    );
    
   
    always #5 clk = ~clk; 
    
    initial begin
        $dumpfile("vending_tb.vcd");
        $dumpvars(0, vending_tb);

        
        clk = 0;
        reset = 1;
        coin_in = 0;
        coin_value = 0;
        #10;
        
        reset = 0;
      
        #10 coin_in = 1; coin_value = 4'b0101; // Insert 5
        #10 coin_in = 0;
        #20;
        
        
        #10 coin_in = 1; coin_value = 4'b0111; // Insert 7
        #10 coin_in = 0;
        #20;
        
       
        #10 coin_in = 1; coin_value = 4'b0011; // Insert 3
        #10 coin_in = 0;
        #20;
        
       
        #10 coin_in = 1; coin_value = 4'b0010; // Insert 2
        #10 coin_in = 0;
        #10 coin_in = 1; coin_value = 4'b0011; // Insert 3
        #10 coin_in = 0;
        #20;
        
        
        $finish;
    end
    
endmodule

