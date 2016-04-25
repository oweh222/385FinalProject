/**
 * color mapper that manages all sprites in the game
 * return the color of the current pixel
 */

module  color_mapper ( input Clk, Reset_h,
								input        [9:0] BallX, BallY, DrawX, DrawY, Ball_size,
                       output logic[15:0] color);
    
		
		
	  logic BKG_ON, BALL_ON, BASKET_ON;
	  logic[15:0] bkg_color, ballColor;	
	

	  
	  Background bkg_inst(.*);
	  
	 
	  ball_color ball_color_inst(.*);
	  
	  always_comb
	  begin
			if (BALL_ON == 1'b1) color = ballColor;
			else color = bkg_color;
	  end
	
	
endmodule
