import util::*;

module master #(
  parameter WIDTH = 32
)(
  input logic HRESETn,
  input logic HCLK,

  input logic HREADY,
  input logic HRESP,

  input logic[WIDTH-1:0] HRDATA,

  output logic[WIDTH-1:0] HADDR,
  
  output logic            HWRITE,
  output logic[2:0]       HSIZE,
  output logic[2:0]       HBURST,
  output logic[3:0]       HPROT,
  output trans_t          HTRANS,
  output logic            HMASTLOCK,

  output logic[WIDTH-1:0] HWDATA
);

logic HRESET;
assign HRESET = ~HRESETn;

logic[2:0]       index;
logic[WIDTH-1:0] data[8];
logic[WIDTH-1:0] addr[8];
trans_t          ttype[8];
logic[WIDTH-1:0] buffer;

initial $readmemh("master_data_init.mem ", data);
initial $readmemh("master_addr_init.mem ", addr);
initial $readmemh("master_trans_init.mem", ttype);

logic update_index_counter;

assign update_index_counter = HREADY & ~HRESP;

always_ff @(posedge HCLK) begin
  if (HRESET) begin
    HWRITE    <= 0;
    HSIZE     <= 0;
    HBURST    <= 0;
    HPROT     <= 0;
    HMASTLOCK <= 0;

    index  <= 0;
    buffer <= 0;
  end else begin
    index  <= update_index_counter ? index + 1 : index;
    buffer <= ( HREADY & (HTRANS != BUSY) & (HTRANS != IDLE) ) ? HRDATA : buffer;
  end
end

assign HWDATA = data[index];
assign HADDR  = addr[index];
assign HTRANS = ttype[index];

endmodule