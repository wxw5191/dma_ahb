//---------------------------------------------------------
//-- File generated by RobustVerilog parser
//-- Version: 1.0
//-- Invoked Fri Mar 25 23:33:02 2011
//--
//-- Source file: dma_ch_wr_slicer.v
//---------------------------------------------------------


  
module  dma_ahb64_core0_ch_wr_slicer (clk,reset,ch_update,rd_clr_line,fifo_wr,fifo_wdata,fifo_wsize,wr_align,wr_ptr,rd_incr,end_swap,slice_wr,slice_wr_fifo,slice_wr_ptr,slice_bsel,slice_wdata,slice_wsize);

   input               clk;
   input               reset;

   input               ch_update;
   input               rd_clr_line;
   
   input               fifo_wr;
   input [64-1:0]      fifo_wdata;
   input [4-1:0]      fifo_wsize;
   input [3-1:0]      wr_align;
   input [5-1:0]      wr_ptr;
   input               rd_incr;
   input [1:0]               end_swap;
   
   output               slice_wr;
   output               slice_wr_fifo;
   output [5-1:0]     slice_wr_ptr;
   output [8-1:0]     slice_bsel;
   output [64-1:0]     slice_wdata;
   output [4-1:0]     slice_wsize;
   

   
   reg [4-1:0]           line_remain;                  
   wire [4-1:0]       join_wsize;
   wire [4-1:0]       append_wsize;
   wire [4-1:0]       direct_wsize;
   reg                   append;
   reg [4-1:0]           next_size;
   
   reg [64-1:0]           align_wdata;
   reg [64-1:0]           align_wdata_d;
   wire [3-1:0]       wr_align_valid;
   reg [64-1:0]           next_wdata;
   wire [8-1:0]       bsel_dec;
   reg [8-1:0]           bsel_shift;

   wire               next_wr;
   
   wire               slice_wr_pre;
   wire [5-1:0]       slice_wr_ptr_pre;
   wire [8-1:0]       slice_bsel_pre;
   wire [8-1:0]       slice_bsel_swap;
   wire [64-1:0]       slice_wdata_pre;
   reg [64-1:0]           slice_wdata_pre_d;
   wire [64-1:0]       slice_wdata_swap;
   wire [4-1:0]       slice_wsize_pre;

   wire               slice_wr;
   wire               slice_wr_fifo;
   reg [5-1:0]           slice_wr_ptr;
   reg [8-1:0]           slice_bsel;
   reg [64-1:0]           slice_wdata;
   reg [4-1:0]           slice_wsize;


   always @(posedge clk or posedge reset)
     if (reset)
       line_remain <= #1 4'd8;
     else if (ch_update |  rd_clr_line)
       line_remain <= #1 4'd8;
     else if (slice_wr_pre & (line_remain == slice_wsize_pre))
       line_remain <= #1 4'd8;
     else if (slice_wr_pre)
       line_remain <= #1 line_remain - slice_wsize_pre;
   
   assign               join_wsize = next_size + fifo_wsize;

   prgen_min2 #(4) min2_append(
                     .a(join_wsize),
                     .b(4'd8),
                     .min(append_wsize)
                     );
   
   prgen_min2 #(4) min2_direct(
                     .a(line_remain),
                     .b(fifo_wsize),
                     .min(direct_wsize)
                     );
   
   
   always @(posedge clk or posedge reset)
     if (reset)
       append  <= #1 1'b0;
     else if (next_wr)
       append  <= #1 1'b0;
     else if (fifo_wr & (slice_wsize_pre == join_wsize))
       append  <= #1 1'b0;
     else if (fifo_wr)
       append  <= #1 1'b1;

   
   always @(posedge clk or posedge reset)
     if (reset)
       next_size  <= #1 {4{1'b0}};
     else if (next_wr)
       next_size  <= #1 {4{1'b0}};
     else if (fifo_wr & append)
       next_size  <= #1 join_wsize - append_wsize;
     else if (fifo_wr)
       next_size  <= #1 join_wsize - direct_wsize;

   
   //WDATA
   always @(posedge clk or posedge reset)
     if (reset)
       align_wdata_d <= #1 {64{1'b0}};
     else if (fifo_wr)
       align_wdata_d <= #1 align_wdata;

   
   assign               wr_align_valid = 
                  rd_incr ? wr_align : 
                  wr_align - wr_ptr[3-1:0];

   //always @(/*AUTOSENSE*/) - no AUTOSENSE because of fifo_wr
   always @(fifo_wdata or wr_align_valid or fifo_wr)
     begin
    case (wr_align_valid[3-1:0])
      3'd0 : align_wdata = fifo_wdata;
      3'd1 : align_wdata = {fifo_wdata[7:0],  fifo_wdata[63:8]};
      3'd2 : align_wdata = {fifo_wdata[15:0], fifo_wdata[63:16]};
      3'd3 : align_wdata = {fifo_wdata[23:0], fifo_wdata[63:24]};
      3'd4 : align_wdata = {fifo_wdata[31:0], fifo_wdata[63:32]};
      3'd5 : align_wdata = {fifo_wdata[39:0], fifo_wdata[63:40]};
      3'd6 : align_wdata = {fifo_wdata[47:0], fifo_wdata[63:48]};
      3'd7 : align_wdata = {fifo_wdata[55:0], fifo_wdata[63:56]};
    endcase
     end


   always @(/*AUTOSENSE*/align_wdata or align_wdata_d or next_size)
     begin
    case (next_size[3-1:0])
      3'd0 : next_wdata = align_wdata_d;
      3'd1 : next_wdata = {align_wdata[63:8],  align_wdata_d[7:0]};
      3'd2 : next_wdata = {align_wdata[63:16], align_wdata_d[15:0]};
      3'd3 : next_wdata = {align_wdata[63:24], align_wdata_d[23:0]};
      3'd4 : next_wdata = {align_wdata[63:32], align_wdata_d[31:0]};
      3'd5 : next_wdata = {align_wdata[63:40], align_wdata_d[39:0]};
      3'd6 : next_wdata = {align_wdata[63:48], align_wdata_d[47:0]};
      3'd7 : next_wdata = {align_wdata[63:56], align_wdata_d[55:0]};
    endcase
     end

   
   //BSEL
   assign bsel_dec = 
      slice_wsize == 4'd1 ? 8'b00000001 :
      slice_wsize == 4'd2 ? 8'b00000011 :
      slice_wsize == 4'd3 ? 8'b00000111 :
      slice_wsize == 4'd4 ? 8'b00001111 :
      slice_wsize == 4'd5 ? 8'b00011111 :
      slice_wsize == 4'd6 ? 8'b00111111 :
      slice_wsize == 4'd7 ? 8'b01111111 :
      slice_wsize == 4'd8 ? 8'b11111111 : 
             {8{1'b0}};

   
   always @(/*AUTOSENSE*/bsel_dec or wr_ptr)
     begin
    case (wr_ptr[3-1:0])
      3'd0 : bsel_shift = bsel_dec;
      3'd1 : bsel_shift = {bsel_dec[6:0], 1'b0};
      3'd2 : bsel_shift = {bsel_dec[5:0], 2'b0};
      3'd3 : bsel_shift = {bsel_dec[4:0], 3'b0};
      3'd4 : bsel_shift = {bsel_dec[3:0], 4'b0};
      3'd5 : bsel_shift = {bsel_dec[2:0], 5'b0};
      3'd6 : bsel_shift = {bsel_dec[1:0], 6'b0};
      3'd7 : bsel_shift = {bsel_dec[0],   7'b0};
    endcase
     end


   //CMD
   assign next_wr             = (~fifo_wr) & (|next_size);
   
   assign slice_wr_pre        = fifo_wr | next_wr;
      
   assign slice_wsize_pre     =  
      next_wr ? next_size    : 
      append  ? append_wsize : direct_wsize;
    
   assign slice_wr_ptr_pre    = wr_ptr;

   assign slice_wdata_pre     = append ? next_wdata : align_wdata;

   assign slice_bsel_pre      = bsel_shift;
   

   prgen_delay #(1) delay_wr0(.clk(clk), .reset(reset), .din(slice_wr_pre), .dout(slice_wr));
   prgen_delay #(1) delay_wr(.clk(clk), .reset(reset), .din(slice_wr), .dout(slice_wr_fifo));

   
   always @(posedge clk or posedge reset)
     if (reset)
       begin
      slice_wsize       <= #1 {4{1'b0}};
      slice_wdata_pre_d <= #1 {64{1'b0}};
       end
     else if (slice_wr_pre)
       begin
      slice_wsize       <= #1 slice_wsize_pre;
      slice_wdata_pre_d <= #1 slice_wdata_pre;
       end

   
   prgen_swap64 swap64(
               .end_swap(end_swap),
               .data_in(slice_wdata_pre_d),
               .data_out(slice_wdata_swap),
               .bsel_in(slice_bsel_pre),
               .bsel_out(slice_bsel_swap)
               );
   
   always @(posedge clk or posedge reset)
     if (reset)
       begin
      slice_wdata   <= #1 {64{1'b0}};
      slice_wr_ptr  <= #1 {5{1'b0}};
      slice_bsel    <= #1 {8{1'b0}};
       end
     else if (slice_wr)
       begin
      slice_wdata   <= #1 slice_wdata_swap;
      slice_wr_ptr  <= #1 slice_wr_ptr_pre;
      slice_bsel    <= #1 slice_bsel_swap;
       end
   
endmodule



   


