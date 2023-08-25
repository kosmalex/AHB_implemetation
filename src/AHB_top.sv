import util::*;

module AHB_top #(
  parameter WIDTH = 32
)(
  input logic HCLK, HRESETn
);
logic HRESET;
assign HRESET = ~HRESETn;

// Master I/O
logic[WIDTH-1:0] HWDATA, HRDATA;
logic[WIDTH-1:0] HADDR;
logic            HRESP, HREADY;
logic            HWRITE;
logic[2:0]       HSIZE;
logic[2:0]       HBURST;
logic[3:0]       HPROT;
trans_t          HTRANS;
logic            HMASTLOCK;

// Decoder I/O
logic[2:0] HSELx;

// Slave I/O
logic[2:0][WIDTH-1:0] HRDATAx;
logic[2:0]            HRESPx;
logic[2:0]            HREADYOUTx; 

master master_0 (.*);

decoder decoder_0 (.*);

slave #(.ID(0)) slave_0 (
  .HCLK   (HCLK),
  .HRESETn(HRESETn),
 
  .HSELx (HSELx[0]),

  .HADDR (HADDR),

  .HWRITE    (HWRITE),
  .HSIZE     (HSIZE),
  .HBURST    (HBURST),
  .HPROT     (HPROT),
  .HTRANS    (HTRANS),
  .HMASTLOCK (HMASTLOCK),
  .HREADY    (HREADY),

  .HWDATA (HWDATA),

  .HRDATA    (HRDATAx[0]),
  .HREADYOUT (HREADYOUTx[0]),
  .HRESP     (HRESPx[0])
);

slave #(.ID(1)) slave_1 (
  .*,

  .HSELx (HSELx[1]),

  .HRDATA    (HRDATAx[1]   ),
  .HREADYOUT (HREADYOUTx[1]),
  .HRESP     (HRESPx[1]    )
);

slave #(.ID(2)) slave_2 (
  .*,

  .HSELx (HSELx[2]),

  .HRDATA    (HRDATAx[2]),
  .HREADYOUT (HREADYOUTx[2]),
  .HRESP     (HRESPx[2])
);

struct {
  logic[2:0] HSELx;
} ff;

always_ff @(posedge HCLK) begin
  if (HREADY) begin
    ff.HSELx <= HSELx;
  end
end

multiplexor multiplexor_0 (
  .*,
  .HSELx (ff.HSELx)
);

endmodule