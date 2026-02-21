module debounce_top (
    input i_Clk,
    input i_Switch_1,
    output o_LED_1);
  
wire w_debounced_switch;
 
debounce_filter #(.DEBOUNCE_LIMIT(250000)) debounce_inst (
    .i_Clk(i_Clk),
    .i_Bouncy(i_Switch_1),
    .o_Debounced(w_debounced_switch));
   
led_toggle led_toggle_inst (
    .i_Clk(i_Clk),
    .i_Switch_1(w_debounced_switch),
    .o_LED_1(o_LED_1));
   
endmodule
