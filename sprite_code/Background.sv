module Background
(
	input Clk, Reset_h,
	input logic [9:0] DrawX, DrawY,
	output logic [15:0] bkg_color
);

	logic[15:0] SRAM_ADDR;
	logic[15:0] sram_in, sram_out;
	wire[15:0] SRAM_DQ;
	logic SRAM_CE_N,
         SRAM_UB_N,
         SRAM_LB_N,
         SRAM_OE_N,
         SRAM_WE_N;


	tristate #(.N(16)) tr0(
	.Clk(Clk), .OE(SRAM_OE_N), .In(sram_in), .Out(sram_out), .Data(SRAM_DQ)
	);
	
   sramIOHandler sramIO_inst(.*, .Reset(Reset_h));
	
	test_memory sram_inst
	 (
		.WE(SRAM_WE_N),
		.CE(SRAM_CE_N),
		.UB(SRAM_UB_N),
		.LB(SRAM_LB_N),
		.OE(SRAM_OE_N),
		.Clk(Clk),
		.Reset(Reset_h),
		.I_O(SRAM_DQ),
		.A(SRAM_ADDR),
	 );
	

	always_comb
	begin
			if (DrawY >= 10'd360)
				SRAM_ADDR = DrawY[2:0];
			else 
				SRAM_ADDR = 20'd8; 
	
	end 
	
	assign bkg_color = sram_out;
	
endmodule 