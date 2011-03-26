//---------------------------------------------------------
//-- File generated by RobustVerilog parser
//-- Version: 1.0
//-- Invoked Fri Mar 25 23:33:02 2011
//--
//-- Source file: prgen_min3.v
//---------------------------------------------------------



module prgen_min3(clk,reset,a,b,c,min);

   parameter             WIDTH = 8;

   input          clk;
   input          reset;
   input [WIDTH-1:0]      a;
   input [WIDTH-1:0]      b;
   input [WIDTH-1:0]      c;

   output [WIDTH-1:0]      min;

   wire [WIDTH-1:0]      min_ab_pre;
   reg [WIDTH-1:0]      min_ab;
   reg [WIDTH-1:0]      min_c;
     

   prgen_min2 #(WIDTH) min2_ab(
                 .a(a),
                 .b(b),
                 .min(min_ab_pre)
                 );
   
   prgen_min2 #(WIDTH) min2_abc(
                  .a(min_ab),
                  .b(min_c),
                  .min(min)
                  );

   always @(posedge clk or posedge reset)
     if (reset)
       begin
      min_ab <= #1 {WIDTH{1'b0}};
      min_c  <= #1 {WIDTH{1'b0}};
       end
     else
       begin
      min_ab <= #1 min_ab_pre;
      min_c  <= #1 c;
       end
   
endmodule


   


