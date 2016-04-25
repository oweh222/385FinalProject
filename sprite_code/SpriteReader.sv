/**
 * Sprite Reader
 * 
 * Read spirte data from sram to the frame buffer
 * State Machine

 */



module SpriteReader (

	input logic[19:0] Addr, Length;
	input logic cpu_ready;
	output logic read_ready;
)

	logic[19:0] curAddr;
	enum[5:0] // states

	logic[19:0] count; // Address counter


	

