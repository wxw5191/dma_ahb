//---------------------------------------------------------
//-- File generated by RobustVerilog parser
//-- Version: 1.0
//-- Invoked Fri Mar 25 23:33:01 2011
//--
//-- Source file: dma_ch_calc_addr.v
//---------------------------------------------------------



module dma_ahb64_core0_ch_calc_addr(clk,reset,ch_update_d,load_in_prog,load_addr,go_next_line,burst_start,incr,start_addr,frame_width,x_size,burst_size,burst_addr);
   

   input             clk;
   input             reset;
   
   input             ch_update_d;
   input             load_in_prog;
   input [32-1:0]    load_addr;
   
   input             go_next_line;
   input             burst_start;
   input             incr;
   input [32-1:0]    start_addr;
   input [`FRAME_BITS-1:0]  frame_width;
   input [`X_BITS-1:0]         x_size;
   input [8-1:0]   burst_size;
   output [32-1:0]   burst_addr;
   
   
   reg [32-1:0]         burst_addr;
   
   wire             go_next_line_d;
   reg [`FRAME_BITS-1:0]    frame_width_diff_reg;
   wire [`FRAME_BITS-1:0]   frame_width_diff;
   

   
   assign             frame_width_diff = {`FRAME_BITS{1'b0}};
   assign             go_next_line_d   = 1'b0;
   
   
   always @(posedge clk or posedge reset)
     if (reset)
       burst_addr <= #1 {32{1'b0}};
     else if (load_in_prog)
       burst_addr <= #1 load_addr;
     else if (ch_update_d)
       burst_addr <= #1 start_addr;
     else if (burst_start & incr)
       burst_addr <= #1 burst_addr + burst_size;
     else if (go_next_line_d & incr)
       burst_addr <= #1 burst_addr + frame_width_diff;
   
   
endmodule


