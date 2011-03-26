//---------------------------------------------------------
//-- File generated by RobustVerilog parser
//-- Version: 1.0
//-- Invoked Fri Mar 25 23:31:23 2011
//--
//-- Source file: prgen_demux.v
//---------------------------------------------------------


  

module prgen_demux8(sel,x,ch_x);

   parameter                  WIDTH      = 8;
   
   
   input [3-1:0]     sel;
   input [WIDTH-1:0]           x;
   output [8*WIDTH-1:0]    ch_x;

   
   reg [8*WIDTH-1:0]       ch_x;

   

   always @(/*AUTOSENSE*/sel or x)
     begin
    ch_x = {8*WIDTH{1'b0}};
    
    case (sel)                                  
      3'd0 : ch_x[WIDTH-1+WIDTH*0:WIDTH*0] = x;
      3'd1 : ch_x[WIDTH-1+WIDTH*1:WIDTH*1] = x;
      3'd2 : ch_x[WIDTH-1+WIDTH*2:WIDTH*2] = x;
      3'd3 : ch_x[WIDTH-1+WIDTH*3:WIDTH*3] = x;
      3'd4 : ch_x[WIDTH-1+WIDTH*4:WIDTH*4] = x;
      3'd5 : ch_x[WIDTH-1+WIDTH*5:WIDTH*5] = x;
      3'd6 : ch_x[WIDTH-1+WIDTH*6:WIDTH*6] = x;
      3'd7 : ch_x[WIDTH-1+WIDTH*7:WIDTH*7] = x;

      default :                                 
        ch_x[WIDTH-1:0] = x;      
    endcase                                     
     end

   
endmodule
   


