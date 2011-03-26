//---------------------------------------------------------
//-- File generated by RobustVerilog parser
//-- Version: 1.0
//-- Invoked Fri Mar 25 23:33:01 2011
//--
//-- Source file: prgen_rawstat.v
//---------------------------------------------------------


  
module  prgen_rawstat (clk,reset,clear,write,pwdata,int_bus,rawstat);

   parameter           SIZE = 32;
   
   input            clk;
   input            reset;
   
   input            clear;
   input            write;
   input [SIZE-1:0]    pwdata;
   input [SIZE-1:0]    int_bus;
   
   output [SIZE-1:0]   rawstat;
   
   
   
   reg [SIZE-1:0]      rawstat;
   wire [SIZE-1:0]     write_bus;
   wire [SIZE-1:0]     clear_bus;
   
   
   assign            write_bus = {SIZE{write}} & pwdata;
   assign            clear_bus = {SIZE{clear}} & pwdata;
   
   
   always @(posedge clk or posedge reset)
     if (reset) 
       rawstat <= #1 {SIZE{1'b0}};
     else 
       rawstat <= #1 (rawstat | int_bus | write_bus) & (~clear_bus);
   
endmodule
   


