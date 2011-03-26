//---------------------------------------------------------
//-- File generated by RobustVerilog parser
//-- Version: 1.0
//-- Invoked Fri Mar 25 23:33:02 2011
//--
//-- Source file: prgen_min2.v
//---------------------------------------------------------



module prgen_min2(a,b,min);

   parameter             WIDTH = 8;
   
   input [WIDTH-1:0]      a;
   input [WIDTH-1:0]      b;

   output [WIDTH-1:0]      min;

   
   assign          min = a < b ? a : b;   
   
endmodule


   

