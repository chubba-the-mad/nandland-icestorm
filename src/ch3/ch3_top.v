module ch3_top (
	input i_Switch_1,
	input i_Switch_2,
	input i_Switch_3,
	output o_LED_1);

wire w_not_out;
wire w_and_out;

or_gate or_gate(
	.i_Switch_1(i_Switch_1),
	.i_Switch_2(w_and_out),
	.o_LED_1(o_LED_1));

not_gate not_gate(
	.i_Switch_1(i_Switch_2),
	.o_LED_1(w_not_out));

and_gate and_gate(
	.i_Switch_1(w_not_out),
	.i_Switch_2(i_Switch_3),
	.o_LED_1(w_and_out));

endmodule
