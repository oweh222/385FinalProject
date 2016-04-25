//-------------------------------------------------------------------------
//      test_memory.vhd                                                  --
//      Stephen Kempf                                                    --
//      Summer 2005                                                      --
//                                                                       --
//      Revised 3-15-2006                                                --
//              3-22-2007                                                --
//              7-26-2013                                                --
//                                                                       --
//      For use with ECE 385 Experment 6                                 --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------

// This memory has similar behavior to the SRAM IC on the DE2 board.  This
// file should be used for simulations only.  In simulation, this memory is
// guaranteed to work at least as well as the actual memory (that is, the
// actual memory may require more careful treatment than this test memory).

// To use, you should create a seperate top-level entity for simulation
// that connects this memory module to your computer.  You can create this
// extra entity either in the same project (temporarily setting it to be the
// top module) or in a new one, and create a new vector waveform file for it.


module test_memory ( input 			Clk,
							input          Reset, 
                     inout  [15:0]  I_O,
                     input  [19:0]  A,
                     input          CE,
                                    UB,
                                    LB,
                                    OE,
                                    WE );
												
   parameter size = 2000; // expand memory as needed (current is 64 words)
	 
   logic [15:0] mem_array [size-1:0];
   logic [15:0] mem_out;
   logic [15:0] I_O_wire;
	 
   assign mem_out = mem_array[A[19:0]];  //ATTENTION: Size here must correspond to size of
              // memory vector above.  Current size is 64, so the slice must be 6 bits.  If size were 1024,
              // slice would have to be 10 bits.  (There are three more places below where values must stay
              // consistent as well.)
	 
   always_comb
   begin
      I_O_wire = 16'bZZZZZZZZZZZZZZZZ;

      if (~CE && ~OE && WE) begin
         if (~UB)
            I_O_wire[15:8] = mem_out[15:8];
				
         if (~LB)
            I_O_wire[7:0] = mem_out[7:0];
		end
   end
	  
   always_ff @ (posedge Clk or posedge Reset)
   begin
		if(Reset)   // Insert initial memory contents here
		begin
	
// floor data
mem_array[ 0 ] <= 16'hcd63;
mem_array[ 1 ] <= 16'hac19;
mem_array[ 2 ] <= 16'hcd63;
mem_array[ 3 ] <= 16'hcd63;
mem_array[ 4 ] <= 16'hac19;
mem_array[ 5 ] <= 16'hac59;
mem_array[ 6 ] <= 16'hcd63;
mem_array[ 7 ] <= 16'hac59;

// Sky Base color
mem_array[ 8 ] <= 16'h867d;



			
			for (integer i = 9; i <= size - 1; i = i + 1)		// Assign the rest of the memory to 0
			begin
				mem_array[i] <= 16'h0;
			end
		end
		else if (~CE && ~WE)
		begin
            if(~UB)
			    mem_array[A[19:0]][15:8] <= I_O[15:8];   // A(15 downto X+1): X must
														// be the same as above
		    if(~LB)
			    mem_array[A[19:0]][7:0] <= I_O[7:0];     // A(X downto 0): X
		end                                             // must be the same as above

   end
	  
   assign I_O = I_O_wire;
	  
endmodule