//---------------------------------------------------------
//-- File generated by RobustVerilog parser
//-- Version: 1.0
//-- Invoked Fri Mar 25 23:32:59 2011
//--
//-- Source file: dma_core.v
//---------------------------------------------------------



module dma_ahb64_core0(clk,reset,scan_en,idle,ch_int_all_proc,ch_start,periph_tx_req,periph_tx_clr,periph_rx_req,periph_rx_clr,pclk,clken,pclken,psel,penable,paddr,pwrite,pwdata,prdata,pslverr,rd_port_num,wr_port_num,joint_mode_in,joint_remote,rd_prio_top,rd_prio_high,rd_prio_top_num,rd_prio_high_num,wr_prio_top,wr_prio_high,wr_prio_top_num,wr_prio_high_num,WHADDR,WHBURST,WHSIZE,WHTRANS,WHWDATA,WHREADY,WHRESP,RHADDR,RHBURST,RHSIZE,RHTRANS,RHRDATA,RHREADY,RHRESP,WHLAST,WHOLD,RHLAST,RHOLD,WSYNC,RSYNC);
   
   input              clk;
   input                     reset;
   input                     scan_en;

   output                    idle;
   output [8*1-1:0]   ch_int_all_proc;
   input [7:0]                  ch_start;
   
   input [31:1]          periph_tx_req;
   output [31:1]          periph_tx_clr;
   input [31:1]          periph_rx_req;
   output [31:1]          periph_rx_clr;

   input              pclk;
   input              clken;
   input              pclken;
   input              psel;
   input              penable;
   input [10:0]          paddr;
   input              pwrite;
   input [31:0]          pwdata;
   output [31:0]          prdata;
   output              pslverr;

   output              rd_port_num;
   output              wr_port_num;

   input              joint_mode_in;
   input              joint_remote;
   input               rd_prio_top;
   input               rd_prio_high;
   input [2:0]              rd_prio_top_num;
   input [2:0]              rd_prio_high_num;
   input               wr_prio_top;
   input               wr_prio_high;
   input [2:0]              wr_prio_top_num;
   input [2:0]              wr_prio_high_num;
   
   output [32-1:0]    WHADDR;
   output [2:0]              WHBURST;
   output [1:0]              WHSIZE;
   output [1:0]              WHTRANS;
   output [64-1:0]    WHWDATA;
   input                     WHREADY;
   input                     WHRESP;
   output [32-1:0]    RHADDR;
   output [2:0]              RHBURST;
   output [1:0]              RHSIZE;
   output [1:0]              RHTRANS;
   input [64-1:0]     RHRDATA;
   input                     RHREADY;
   input                     RHRESP;
   output                    WHLAST;
   input                     WHOLD;
   output                    RHLAST;
   input                     RHOLD;
   input                     WSYNC;
   input                     RSYNC;
   

   //outputs of wdt
   wire              wdt_timeout;
   wire [2:0]              wdt_ch_num;
   
   //outputs of rd arbiter
   wire              rd_ch_go_joint;
   wire              rd_ch_go_null;
   wire              rd_ch_go;
   wire [2:0]              rd_ch_num;
   wire              rd_ch_last;
   
   //outputs of wr arbiter
   wire              wr_ch_go_joint;
   wire              wr_ch_go;
   wire [2:0]              wr_ch_num_joint;
   wire [2:0]              wr_ch_num;
   wire              wr_ch_last;
   wire              wr_ch_last_joint;
   
   //outputs of channels
   wire [31:0]              prdata;
   wire              pslverr;
   wire              load_req_in_prog;
   wire [7:0]              ch_idle;
   wire [7:0]              ch_active;
   wire [7:0]              ch_active_joint;
   wire [7:0]              ch_rd_active;
   wire [7:0]              ch_wr_active;
   wire              wr_last_cmd;
   wire              rd_line_cmd;
   wire              wr_line_cmd;
   wire              rd_go_next_line;
   wire              wr_go_next_line;
   
   wire [7:0]              ch_rd_ready_joint;
   wire [7:0]              ch_rd_ready;
   wire              rd_ready;
   wire              rd_ready_joint;
   wire [32-1:0]      rd_burst_addr;
   wire [8-1:0]     rd_burst_size;
   wire [`TOKEN_BITS-1:0]    rd_tokens;
   wire              rd_port_num;
   wire [`DELAY_BITS-1:0]    rd_periph_delay;
   wire              rd_clr_valid;  
   wire [2:0]              rd_transfer_num;  
   wire              rd_transfer;
   wire [4-1:0]      rd_transfer_size;  
   wire              rd_clr_stall;
   
   wire [7:0]              ch_wr_ready;
   wire              wr_ready;
   wire              wr_ready_joint;
   wire [32-1:0]      wr_burst_addr;
   wire [8-1:0]     wr_burst_size;
   wire [`TOKEN_BITS-1:0]    wr_tokens;
   wire              wr_port_num;
   wire [`DELAY_BITS-1:0]    wr_periph_delay;
   wire              wr_clr_valid;    
   wire              wr_clr_stall;
   wire [7:0]              ch_joint_req;
   wire              joint_req;
   wire              joint_mode;
   
   wire              joint_ch_go;
   wire              joint_stall;
   
   //outputs of rd ctrl
   wire              rd_burst_start;
   wire              rd_finish_joint;
   wire              rd_finish;
   wire              rd_ctrl_busy;

   //outputs of wr ctrl
   wire              wr_burst_start_joint;
   wire              wr_burst_start;
   wire              wr_finish;
   wire              wr_ctrl_busy;

   
   //outputs of axim wr
   wire              wr_cmd_split;
   wire [2:0]              wr_cmd_num;
   wire              wr_cmd_pending_joint;
   wire              wr_cmd_pending;
   wire              wr_cmd_full_joint;
   wire              ch_fifo_rd;
   wire [4-1:0]      ch_fifo_rsize;
   wire [2:0]              ch_fifo_rd_num;
   wire [2:0]              wr_transfer_num;
   wire              wr_transfer; 
   wire [4-1:0]      wr_transfer_size;
   wire [4-1:0]      wr_next_size;
   wire              wr_clr_line;
   wire [2:0]              wr_clr_line_num;
   wire              wr_cmd_full;
   wire              wr_slverr;
   wire              wr_decerr;
   wire              wr_clr;
   wire              wr_clr_last;
   wire [2:0]              wr_ch_num_resp;
   wire              timeout_aw;
   wire              timeout_w;
   wire [2:0]              timeout_num_aw;
   wire [2:0]              timeout_num_w;
   wire              wr_hold_ctrl;
   wire              wr_hold;
   wire              joint_in_prog;
   wire              joint_not_in_prog;
   wire              joint_mux_in_prog;
   wire              wr_page_cross;
   
   //outputs of axim rd   
   wire              load_wr;
   wire [2:0]              load_wr_num;
   wire [1:0]              load_wr_cycle;
   wire [64-1:0]      load_wdata;  
   wire              rd_cmd_split; 
   wire              rd_cmd_line;
   wire [2:0]              rd_cmd_num;
   wire              rd_cmd_pending_joint;
   wire              rd_cmd_pending;
   wire              rd_cmd_full_joint;
   wire              ch_fifo_wr;
   wire [64-1:0]      ch_fifo_wdata;
   wire [4-1:0]      ch_fifo_wsize;
   wire [2:0]              ch_fifo_wr_num;
   wire              rd_clr_line;
   wire [2:0]              rd_clr_line_num;
   wire              rd_burst_cmd;
   wire              rd_cmd_full;
   wire              rd_slverr;
   wire              rd_decerr;
   wire              rd_clr;
   wire              rd_clr_last;
   wire              rd_clr_load;
   wire [2:0]              rd_ch_num_resp;
   wire              timeout_ar;
   wire [2:0]              timeout_num_ar;
   wire              rd_hold_joint;
   wire              rd_hold_ctrl;
   wire              rd_hold;
   wire              joint_hold;
   wire              rd_page_cross;

   wire              joint_page_cross;
   wire              rd_arbiter_en;
   wire              wr_arbiter_en;

   wire              rd_cmd_port;
   wire              wr_cmd_port;
   
   //outputs of fifo ctrl
   wire [64-1:0]      ch_fifo_rdata;
   wire              ch_fifo_rd_valid;
   wire              ch_fifo_wr_ready;
   wire              FIFO_WR;
   wire              FIFO_RD;
   wire [3+5-3-1:0]  FIFO_WR_ADDR;
   wire [3+5-3-1:0]  FIFO_RD_ADDR;
   wire [64-1:0]      FIFO_DIN;
   wire [8-1:0]      FIFO_BSEL;

   //outputs of fifo wrap
   wire [64-1:0]      FIFO_DOUT;

   wire              clk_en;
   wire              gclk;


   assign              joint_mode = joint_mode_in & 1'b1;
   
   
   assign              rd_arbiter_en        = 1'b1;
   assign              wr_arbiter_en        = !joint_mode;

   assign              rd_ready             = ch_rd_ready[rd_ch_num];
   assign              wr_ready             = ch_wr_ready[wr_ch_num_joint];
   assign              rd_ready_joint       = joint_mode & joint_req ? rd_ready & wr_ready : rd_ready;
   assign              wr_ready_joint       = joint_mode & joint_req ? rd_ready & wr_ready : wr_ready;
   assign              ch_active_joint      = joint_mode ? ch_rd_active | ch_wr_active : ch_rd_active;
   
   assign              joint_page_cross     = (rd_page_cross & rd_ready) | (wr_page_cross & wr_ready);
   
   assign              joint_req            = ch_joint_req[rd_ch_num];
   
   assign              ch_rd_ready_joint    = joint_mode ?
                 (ch_joint_req & ch_rd_ready & ch_wr_ready) | 
                   ((~ch_joint_req) & (ch_rd_ready | ch_wr_ready)) :
                 ch_rd_ready;

   assign              wr_burst_start_joint = joint_mode & joint_req ? rd_burst_start : wr_burst_start;
   
   assign              joint_hold           = joint_mux_in_prog | (joint_in_prog & (~joint_req)) | (joint_not_in_prog & joint_req) | joint_stall | (joint_req & joint_page_cross);
   
   assign              rd_hold_ctrl         = joint_mode ? rd_hold | joint_hold | (joint_in_prog & wr_hold) : rd_hold;
   assign              rd_hold_joint        = joint_mode & (rd_hold_ctrl | rd_ctrl_busy | wr_ctrl_busy);
   assign              wr_hold_ctrl         = joint_mode & (joint_req | joint_in_prog) ? wr_hold | joint_hold : wr_hold;

   assign              rd_ch_go_joint       = rd_ch_go & ch_rd_ready[rd_ch_num] & (~rd_ctrl_busy);
   assign              wr_ch_go_joint       = joint_mode ? (wr_ready & (~wr_ctrl_busy) & 
                                  (joint_req ? rd_ch_go_joint : rd_ch_go & (~rd_ch_go_joint))) : wr_ch_go;
   assign              rd_ch_go_null        = rd_ch_go & (~rd_ch_go_joint) & (joint_mode ? (~wr_ch_go_joint) : 1'b1);

   assign              wr_ch_num_joint      = joint_mode ? rd_ch_num : wr_ch_num;

   assign              wr_ch_last_joint     = joint_mode ? rd_ch_last : wr_ch_last;
   
   assign              rd_finish_joint      = joint_mode ? rd_finish | wr_finish | rd_ch_go_null : rd_finish | rd_ch_go_null;
   
   assign              rd_cmd_full_joint    = joint_mode & joint_req ? wr_cmd_full | rd_cmd_full : rd_cmd_full;
   assign              wr_cmd_full_joint    = joint_mode & joint_req ? wr_cmd_full | rd_cmd_full : wr_cmd_full;
   assign              rd_cmd_pending_joint = joint_mode ? rd_cmd_pending | wr_cmd_pending : rd_cmd_pending;
   assign              wr_cmd_pending_joint = joint_mode & joint_req ? rd_cmd_pending | wr_cmd_pending : wr_cmd_pending;
   
   assign              idle                 = &ch_idle;
   
   assign             gclk = clk;


   dma_ahb64_core0_wdt  dma_ahb64_core0_wdt (
                           .clk(gclk),
                           .reset(reset),
                           .ch_active(ch_active),
                           .rd_burst_start(rd_burst_start),
                           .rd_ch_num(rd_ch_num),
                           .wr_burst_start(wr_burst_start_joint),
                           .wr_ch_num(wr_ch_num_joint),
                           .wdt_timeout(wdt_timeout),
                           .wdt_ch_num(wdt_ch_num)
                           );
   
   
   dma_ahb64_core0_arbiter
   dma_ahb64_core0_arbiter_rd (
                .clk(gclk),
                .reset(reset),
                .enable(rd_arbiter_en),
                .joint_mode(joint_mode),
                .page_cross(joint_page_cross),
                .joint_req(joint_req),
                .prio_top(rd_prio_top),
                .prio_high(rd_prio_high),
                .prio_top_num(rd_prio_top_num),
                .prio_high_num(rd_prio_high_num),
                .hold(rd_hold_joint),
                .ch_ready(ch_rd_ready_joint),
                .ch_active(ch_active_joint),
                .finish(rd_finish_joint),
                .ch_go_out(rd_ch_go),
                .ch_num(rd_ch_num),
                .ch_last(rd_ch_last)
                );
   
   
   dma_ahb64_core0_arbiter
   dma_ahb64_core0_arbiter_wr (
                .clk(gclk),
                .reset(reset),
                .enable(wr_arbiter_en),
                .joint_mode(joint_mode),
                .page_cross(1'b0),
                .joint_req(joint_req),
                .prio_top(wr_prio_top),
                .prio_high(wr_prio_high),
                .prio_top_num(wr_prio_top_num),
                .prio_high_num(wr_prio_high_num),
                .hold(1'b0),
                .ch_ready(ch_wr_ready),
                .ch_active(ch_wr_active),
                .finish(wr_finish),
                .ch_go_out(wr_ch_go),
                .ch_num(wr_ch_num),
                .ch_last(wr_ch_last)
                );
   
   
   dma_ahb64_core0_ctrl  dma_ahb64_core0_ctrl_rd (
                        .clk(gclk),
                        .reset(reset),
                        .ch_go(rd_ch_go_joint),
                        .cmd_full(rd_cmd_full_joint),
                        .cmd_pending(rd_cmd_pending_joint),
                        .joint_req(joint_req),
                        .ch_num(rd_ch_num),
                        .ch_num_resp(rd_ch_num_resp),
                        .go_next_line(rd_go_next_line),
                        .periph_clr_valid(rd_clr_valid),
                        .periph_clr(rd_clr),
                        .periph_clr_last(rd_clr_last),
                        .periph_delay(rd_periph_delay),
                        .clr_stall(rd_clr_stall),
                        .tokens(rd_tokens),
                        .ch_ready(rd_ready_joint),
                        .ch_last(rd_ch_last),
                        .burst_start(rd_burst_start),
                        .finish(rd_finish),
                        .busy(rd_ctrl_busy),
                        .hold(rd_hold_ctrl)
                        );

   
   dma_ahb64_core0_ctrl  dma_ahb64_core0_ctrl_wr (
                        .clk(gclk),
                        .reset(reset),
                        .ch_go(wr_ch_go_joint),
                        .cmd_full(wr_cmd_full_joint),
                        .cmd_pending(wr_cmd_pending_joint),
                        .joint_req(joint_req),
                        .ch_num(wr_ch_num_joint),
                        .ch_num_resp(wr_ch_num_resp),
                        .go_next_line(wr_go_next_line),
                        .periph_clr_valid(wr_clr_valid),
                        .periph_clr(wr_clr),
                        .periph_clr_last(wr_clr_last),
                        .periph_delay(wr_periph_delay),
                        .clr_stall(wr_clr_stall),
                        .tokens(wr_tokens),
                        .ch_ready(wr_ready_joint),
                        .ch_last(wr_ch_last_joint),
                        .burst_start(wr_burst_start),
                        .finish(wr_finish),
                        .busy(wr_ctrl_busy),
                        .hold(wr_hold_ctrl)
                        );

   dma_ahb64_core0_ahbm_wr
   dma_ahb64_core0_ahbm_wr (
             .clk(gclk),
             .reset(reset),
             .joint_req(joint_req),
             .joint_in_prog(joint_in_prog),
             .joint_stall(joint_stall),
             .rd_transfer(rd_transfer),
             .rd_transfer_size(rd_transfer_size),
             .wr_last_cmd(wr_last_cmd),
             .wr_ch_num(wr_ch_num_joint),
             .wr_ch_num_resp(wr_ch_num_resp),
             .wr_port_num(wr_port_num),
             .wr_cmd_port(wr_cmd_port),
             .wr_burst_start(wr_burst_start_joint),
             .wr_burst_addr(wr_burst_addr),
             .wr_burst_size(wr_burst_size),
             .wr_cmd_pending(wr_cmd_pending),
             .wr_cmd_full(wr_cmd_full),
             .wr_line_cmd(wr_line_cmd),
             .wr_clr_line(wr_clr_line),
             .wr_clr_line_num(wr_clr_line_num),
             .ch_fifo_rd(ch_fifo_rd),
             .ch_fifo_rd_num(ch_fifo_rd_num),
             .ch_fifo_rdata(ch_fifo_rdata),
             .ch_fifo_rd_valid(ch_fifo_rd_valid),
             .ch_fifo_rsize(ch_fifo_rsize),
             .ch_fifo_wr_ready(ch_fifo_wr_ready),
             .wr_transfer(wr_transfer),
             .wr_transfer_num(wr_transfer_num),
             .wr_transfer_size(wr_transfer_size),
             .wr_next_size(wr_next_size),
             .wr_slverr(wr_slverr),
             .wr_clr(wr_clr),
             .wr_clr_last(wr_clr_last),
             .wr_hold(wr_hold),
             .ahb_wr_timeout(timeout_aw),
             .ahb_wr_timeout_num(timeout_num_aw),
             .HADDR(WHADDR),
             .HBURST(WHBURST),
             .HSIZE(WHSIZE),
             .HTRANS(WHTRANS),
             .HLAST(WHLAST),
             .HWDATA(WHWDATA),
             .HREADY(WHREADY),
             .HRESP(WHRESP),
             .HOLD(WHOLD),
             .SYNC(WSYNC)
             );

   
   dma_ahb64_core0_ahbm_rd
   dma_ahb64_core0_ahbm_rd (
             .clk(clk),
             .reset(reset),
             .load_wr(load_wr),
             .load_wr_cycle(load_wr_cycle),
             .load_req_in_prog(load_req_in_prog),
             .joint_stall(joint_stall),
             .rd_ch_num(rd_ch_num),
             .rd_port_num(rd_port_num),
             .rd_cmd_port(rd_cmd_port),
             .rd_burst_start(rd_burst_start),
             .rd_burst_addr(rd_burst_addr),
             .rd_burst_size(rd_burst_size),
             .rd_cmd_pending(rd_cmd_pending),
             .rd_cmd_line(rd_cmd_line),
             .rd_line_cmd(rd_line_cmd),
             .rd_cmd_num(rd_cmd_num),
             .rd_clr_line(rd_clr_line),
             .rd_clr_line_num(rd_clr_line_num),
             .ch_fifo_wr(ch_fifo_wr),
             .ch_fifo_wdata(ch_fifo_wdata),
             .ch_fifo_wsize(ch_fifo_wsize),
             .ch_fifo_wr_num(ch_fifo_wr_num),
             .rd_transfer(rd_transfer),
             .rd_transfer_num(rd_transfer_num),
             .rd_transfer_size(rd_transfer_size),
             .rd_slverr(rd_slverr),
             .rd_clr(rd_clr),
             .rd_clr_last(rd_clr_last),
             .rd_clr_load(rd_clr_load),
             .rd_hold(rd_hold),
             .ahb_rd_timeout(timeout_ar),
             .ahb_rd_timeout_num(timeout_num_ar),
             .HADDR(RHADDR),
             .HBURST(RHBURST),
             .HSIZE(RHSIZE),
             .HTRANS(RHTRANS),
             .HLAST(RHLAST),
             .HRDATA(RHRDATA),
             .HREADY(RHREADY),
             .HRESP(RHRESP),
             .HOLD(RHOLD),
             .SYNC(RSYNC)
             );

   //compatible to AXI
   assign             rd_cmd_split           = 1'd0; //needed for OUTS
   assign             wr_cmd_split           = 1'd0; //needed for OUTS
   assign             wr_cmd_num             = 3'd0; //needed for OUTS
   assign             load_wr_num            = ch_fifo_wr_num;
   assign             load_wdata             = ch_fifo_wdata;
   assign             rd_decerr              = 1'b0;
   assign             wr_decerr              = 1'b0;
   assign             rd_ch_num_resp         = rd_transfer_num;
   assign             timeout_w              = 1'd0;
   assign              timeout_num_w          = 3'd0;
   assign             rd_page_cross          = 1'b0;
   assign             wr_page_cross          = 1'b0;
   


   
   dma_ahb64_core0_channels
   dma_ahb64_core0_channels (
              .clk(clk), //non gated
              .reset(reset),
              .scan_en(scan_en),
              .pclk(pclk),
              .clken(clken),
              .pclken(pclken),
              .psel(psel),
              .penable(penable),
              .paddr(paddr[10:0]),
              .pwrite(pwrite),
              .pwdata(pwdata),
              .prdata(prdata),
              .pslverr(pslverr),
              .periph_tx_req(periph_tx_req),
              .periph_tx_clr(periph_tx_clr),
              .periph_rx_req(periph_rx_req),
              .periph_rx_clr(periph_rx_clr),
              .rd_cmd_split(rd_cmd_split),
              .rd_cmd_line(rd_cmd_line),
              .rd_cmd_num(rd_cmd_num),
              .wr_cmd_split(wr_cmd_split),
              .wr_cmd_pending(wr_cmd_pending),
              .wr_cmd_num(wr_cmd_num),
              .rd_clr_valid(rd_clr_valid),
              .wr_clr_valid(wr_clr_valid),
              .rd_clr(rd_clr),
              .rd_clr_load(rd_clr_load),
              .wr_clr(wr_clr),
                  .rd_clr_stall(rd_clr_stall),
                  .wr_clr_stall(wr_clr_stall),
              .load_wr(load_wr),
              .load_wr_num(load_wr_num),
              .load_wr_cycle(load_wr_cycle),
              .rd_ch_num(rd_ch_num),
              .load_req_in_prog(load_req_in_prog),
              .wr_ch_num(wr_ch_num_joint),
              .wr_last_cmd(wr_last_cmd),
              .load_wdata(load_wdata),
              .wr_slverr(wr_slverr),
              .wr_decerr(wr_decerr),
              .wr_ch_num_resp(wr_ch_num_resp),
              .rd_slverr(rd_slverr),
              .rd_decerr(rd_decerr),
              .rd_ch_num_resp(rd_ch_num_resp),
              .wr_clr_last(wr_clr_last),
              .ch_int_all_proc(ch_int_all_proc),
              .ch_start(ch_start),
              .ch_idle(ch_idle),
              .ch_active(ch_active),
              .ch_rd_active(ch_rd_active),
              .ch_wr_active(ch_wr_active),
              .rd_line_cmd(rd_line_cmd),
              .wr_line_cmd(wr_line_cmd),
              .rd_go_next_line(rd_go_next_line),
              .wr_go_next_line(wr_go_next_line),
      
              .timeout_aw(timeout_aw),
              .timeout_w(timeout_w),
              .timeout_ar(timeout_ar),
              .timeout_num_aw(timeout_num_aw),
              .timeout_num_w(timeout_num_w),
              .timeout_num_ar(timeout_num_ar),
              .wdt_timeout(wdt_timeout),
              .wdt_ch_num(wdt_ch_num),
              
              .ch_fifo_wr_num(ch_fifo_wr_num),
              .rd_transfer_num(rd_transfer_num),
              .rd_burst_start(rd_burst_start),
              .ch_rd_ready(ch_rd_ready),
              .rd_burst_addr(rd_burst_addr),
              .rd_burst_size(rd_burst_size),
              .rd_tokens(rd_tokens),
              .rd_cmd_port(rd_cmd_port),
              .rd_periph_delay(rd_periph_delay),
              .rd_transfer(rd_transfer),
              .rd_transfer_size(rd_transfer_size),
              .rd_clr_line(rd_clr_line),
              .rd_clr_line_num(rd_clr_line_num),
              .fifo_rd(ch_fifo_rd),
              .fifo_rsize(ch_fifo_rsize),
              .fifo_rd_valid(ch_fifo_rd_valid),
              .fifo_rdata(ch_fifo_rdata),
              .fifo_wr_ready(ch_fifo_wr_ready),
      
              .ch_fifo_rd_num(ch_fifo_rd_num),
              .wr_burst_start(wr_burst_start_joint),
              .ch_wr_ready(ch_wr_ready),
              .wr_burst_addr(wr_burst_addr),
              .wr_burst_size(wr_burst_size),
              .wr_tokens(wr_tokens),
              .wr_cmd_port(wr_cmd_port),
              .wr_periph_delay(wr_periph_delay),
              .wr_transfer_num(wr_transfer_num),
              .wr_transfer(wr_transfer),
              .wr_transfer_size(wr_transfer_size),
              .wr_next_size(wr_next_size),
              .wr_clr_line(wr_clr_line),
              .wr_clr_line_num(wr_clr_line_num),
              .fifo_wr(ch_fifo_wr),
              .fifo_wdata(ch_fifo_wdata),
              .fifo_wsize(ch_fifo_wsize),

              .joint_mode(joint_mode),
              .joint_remote(joint_remote),
              .rd_page_cross(rd_page_cross),
              .wr_page_cross(wr_page_cross),
              .joint_in_prog(joint_in_prog),
              .joint_not_in_prog(joint_not_in_prog),
              .joint_mux_in_prog(joint_mux_in_prog),
              .ch_joint_req(ch_joint_req)
              );
   
   
   
endmodule




