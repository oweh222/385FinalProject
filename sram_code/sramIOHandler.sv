module sramIOHandler
(
		input Clk, Reset,
		output    SRAM_CE_N,
                SRAM_UB_N,
                SRAM_LB_N,
                SRAM_OE_N,
                SRAM_WE_N
		//output logic [19:0]			 SRAM_ADDR
);

	enum logic[1:0] {init, enable} state, next_state;
	
	always_ff @ (posedge Clk or  posedge Reset)
	begin
		if (Reset)
		begin
			state <= init;
			//SRAM_ADDR <= 20'd0;
	   end
		else 
		begin
			state <= next_state;
			//SRAM_ADDR <= drawxsig % 32 * 32 + drawysig % 32;
		end
		
	end
	
	always_comb
	begin
		next_state = state;
		SRAM_CE_N = 1'b0;
		SRAM_LB_N = 1'b0;
		SRAM_UB_N = 1'b0;
		SRAM_WE_N = 1'b1;
		SRAM_OE_N = 1'b1;
		
		unique case (state)
			init: begin 
					next_state = enable;
					SRAM_OE_N = 1'b0;
				end
			
			enable: begin
				SRAM_OE_N = 1'b0;
				next_state = init;
			end 
			
		endcase		
			
	end 

	
endmodule 