module fifo #(parameter WIDTH = 16, DEPTH = 256)
    (
    input i_Rst_L,
    input                     i_Clk,
    // write signals
    input                     i_Wr_DV,
    input [WIDTH-1:0]         i_Wr_Data,
    input [$clog2(DEPTH):0] i_AF_Level,
    output                    o_AF_Flag,
    output                    o_Full,
    // read signals
    input                     i_Rd_En,
    output reg                o_Rd_DV,
    output reg [WIDTH-1:0]    o_Rd_Data,
    input [$clog2(DEPTH):0] i_AE_Level,
    output                    o_AE_Flag,
    output                    o_Empty
    );

    reg [$clog2(DEPTH)-1:0] r_Wr_Addr;
    reg [$clog2(DEPTH)-1:0] r_Rd_Addr;
    reg [$clog2(DEPTH):0] r_Count;

   reg [WIDTH-1:0] r_Mem[DEPTH-1:0];

   always @(posedge i_Clk or negedge i_Rst_L)
     begin
        if (~i_Rst_L)
           begin
              r_Wr_Addr <= 0;
              r_Rd_Addr <= 0;
              r_Count <= 0;
           end
        else
          begin
             if (i_Wr_DV)
               begin
                  // write the data
                  r_Mem[r_Wr_Addr] <= i_Wr_Data;
                  
                  // increment address accounting for roll over
                  if (r_Wr_Addr == DEPTH-1)
                    begin
                        r_Wr_Addr <= 0;
                    end
                  else
                    begin
                        r_Wr_Addr <= r_Wr_Addr + 1;
                    end
               end
             
             if (i_Rd_En)
               begin
                  // read the data
                  o_Rd_Data <= r_Mem[r_Rd_Addr];
                  o_Rd_DV <= i_Rd_En;

                  // increment address accounting for roll over
                  if (r_Rd_Addr == DEPTH-1)
                     begin
                        r_Rd_Addr <= 0;
                    end
                  else
                    begin
                        r_Rd_Addr <= r_Rd_Addr + 1;
                    end
               end

             // now update count
             if (i_Rd_En & ~i_Wr_DV)
               begin
                  if (r_Count != 0)
                    begin
                       r_Count <= r_Count - 1;
                    end
               end
             else if (i_Wr_DV & ~i_Rd_En)
               begin
                  if (r_Count != DEPTH)
                    begin
                       r_Count <= r_Count + 1;
                    end
               end
          end // else: !if(~i_Rst_L)
     end // always @ (posedge i_Clk or negedge i_Rst_L)

   // now update flags
   assign o_Full = (r_Count == DEPTH) || (r_Count == DEPTH-1 && i_Wr_DV && !i_Rd_En);
   assign o_Empty = (r_Count == 0);
   assign o_AF_Flag = (r_Count >=  i_AF_Level);
   assign o_AE_Flag = (r_Count <= i_AE_Level);

endmodule // ram_2port
