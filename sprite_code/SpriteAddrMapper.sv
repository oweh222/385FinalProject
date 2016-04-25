/**
 * Created By Sihao Chen
 *
 * @input The hash key of sprite map
 * @output The start address of the specified sprite data in the sram
 *
 */


module SpriteAddrMapper (
	input logic[3:0] sprite_number,
	output logic[19:0] Addr
	output logic[9:0] SpriteW, SpriteH
)

	always_comb
	begin
		unique case (sprite_number)

			// Basketball Sprite
			0: Addr = 20'b0 + ;

			// Basketball Sprite
			1: Addr = 

			// Basket Sprite
			2: Addr =

			default: Addr = 20'h0;
			
		endcase 

	end

endmodule 