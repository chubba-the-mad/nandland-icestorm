module demux_count_top (
    input i_Clk,
    input i_Switch_1,
    input i_Switch_2,
    output o_LED_1,
    output o_LED_2,
    output o_LED_3,
    output o_LED_4);

    localparam COUNT_LIMIT = 4194303;
    
    wire w_counter_toggle;

    count_and_toggle #(.COUNT_LIMIT(COUNT_LIMIT)) count_and_toggle_inst (
        .i_Clk(i_Clk),
        .i_Enable(1'b1),
        .o_Toggle(w_counter_toggle));

    demux_1_to_4 demux_inst (
        .i_Data(w_counter_toggle),
        .i_Sel0(i_Switch_1),
        .i_Sel1(i_Switch_2),
        .o_Data0(o_LED_1),
        .o_Data1(o_LED_2),
        .o_Data2(o_LED_3),
        .o_Data3(o_LED_4));

endmodule : demux_count_top

