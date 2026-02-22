module demux_lfsr_top (
    input i_Clk,
    input i_Switch_1,
    input i_Switch_2,
    output o_LED_1,
    output o_LED_2,
    output o_LED_3,
    output o_LED_4);

    reg r_lfsr_toggle = 1'b0;
    wire w_lfsr_done;

    lfsr_22 lfsr_inst (
        .i_Clk(i_Clk),
        .o_LFSR_Data(),
        .o_LFSR_Done(w_lfsr_done));

    always @(posedge i_Clk)
    begin
        if (w_lfsr_done)
            r_lfsr_toggle <= !r_lfsr_toggle;
    end

    demux_1_to_4 demux_inst (
        .i_Data(r_lfsr_toggle),
        .i_Sel0(i_Switch_1),
        .i_Sel1(i_Switch_2),
        .o_Data0(o_LED_1),
        .o_Data1(o_LED_2),
        .o_Data2(o_LED_3),
        .o_Data3(o_LED_4));

endmodule : demux_lfsr_top

