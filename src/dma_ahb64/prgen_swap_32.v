//---------------------------------------------------------
//-- File generated by RobustVerilog parser
//-- Version: 1.0
//-- Invoked Fri Mar 25 23:33:02 2011
//--
//-- Source file: prgen_swap32.v
//---------------------------------------------------------


  
module  prgen_swap32 (end_swap,data_in,data_out,bsel_in,bsel_out);
   
   input [1:0]            end_swap;
   input [31:0]        data_in;
   output [31:0]       data_out;
   input [3:0]            bsel_in;
   output [3:0]        bsel_out;

   
   reg [31:0]            data_out;
   reg [3:0]            bsel_out;


   
   always @(/*AUTOSENSE*/data_in or end_swap)
     begin
    case (end_swap[1:0])
      2'b00   : data_out = data_in;
      2'b01   : data_out = {data_in[23:16], data_in[31:24], data_in[7:0], data_in[15:8]};
      2'b10   : data_out = {data_in[7:0], data_in[15:8], data_in[23:16], data_in[31:24]};
      2'b11   : data_out = {data_in[7:0], data_in[15:8], data_in[23:16], data_in[31:24]};
    endcase
     end
   
   always @(/*AUTOSENSE*/bsel_in or end_swap)
     begin
    case (end_swap[1:0])
      2'b00   : bsel_out = bsel_in;
      2'b01   : bsel_out = {bsel_in[2], bsel_in[3], bsel_in[0], bsel_in[1]};
      2'b10   : bsel_out = {bsel_in[0], bsel_in[1], bsel_in[2], bsel_in[3]};
      2'b11   : bsel_out = {bsel_in[0], bsel_in[1], bsel_in[2], bsel_in[3]};
    endcase
     end
   
   
endmodule
   


