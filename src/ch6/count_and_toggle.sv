module count_and_toggle #(COUNT_LIMIT = 10) (
    input i_Clk,
    input i_Enable,
    output reg o_Toggle);

    reg [$clog2(COUNT_LIMIT-1):0] r_counter;

    always @(posedge i_Clk)
    begin
        if (i_Enable == 1'b1)
        begin
            if (r_counter == COUNT_LIMIT - 1)
            begin
                o_Toggle <= !o_Toggle;
                r_counter <= 0;
            end
            else
                r_counter <= r_counter + 1;
        end
        else
            o_Toggle <= 1'b0;
    end // always @ (posedge i_Clk)
endmodule : count_and_toggle

