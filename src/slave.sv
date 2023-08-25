import util::*;

module slave #(
  parameter WIDTH = 32,
  parameter ID    = 0
)(
  input logic HRESETn,
  input logic HCLK,

  input logic HSELx,

  input logic[WIDTH-1:0] HADDR,
  input logic            HWRITE,
  input logic[2:0]       HSIZE,
  input logic[2:0]       HBURST,
  input logic[3:0]       HPROT,
  input trans_t          HTRANS,
  input logic            HMASTLOCK,
  input logic            HREADY,

  input logic[WIDTH-1:0] HWDATA,

  output logic HREADYOUT,
  output logic HRESP,

  output logic[WIDTH-1:0] HRDATA
);

logic HRESET;
assign HRESET = ~HRESETn;

logic[31:0] mem[32];
initial $readmemh("slave_init.mem", mem);

struct{
  logic[WIDTH-1:0] HADDR;
  logic            HSEL;
  trans_t          HTRANS;
} reg0;

always_ff @(posedge HCLK) begin
  if (HRESET) begin
    reg0.HADDR  <= 0;
    reg0.HSEL   <= 0;
    reg0.HTRANS <= IDLE;
  end else begin
    reg0.HADDR  <= HSELx ? HADDR : reg0.HADDR;
    reg0.HSEL   <= HSELx;
    reg0.HTRANS <= HTRANS;
  end
end

struct {
  logic hit;
  logic is_ready;
  logic is_noop;
} comb1;

always_comb begin
  comb1.hit      = ( ( reg0.HADDR[31:5] == ID ) & reg0.HSEL );
  comb1.is_ready = comb1.hit | ~reg0.HSEL;
  comb1.is_noop  = (reg0.HTRANS == IDLE) | (reg0.HTRANS == BUSY);
end

logic[2:0] hold_counter;
always_ff @(posedge HCLK) begin
  if (HRESET | (HTRANS == NONSEQ) | (HTRANS == SEQ) ) begin
    hold_counter <= $random % 4;
  end else begin
    hold_counter <= hold_counter - 1;
  end
end

always_ff @(posedge HCLK) begin
  if (HRESET) begin
    HREADYOUT <= 1'b1;
    HRESP     <= 1'b0;
  end else begin
    HREADYOUT <= ( comb1.is_ready | comb1.is_noop ) & (hold_counter == 0);
    HRESP     <= ~comb1.hit & reg0.HSEL & ~comb1.is_noop;

    mem[reg0.HADDR[4:0]] <= (HWRITE & ~HRESP & ~comb1.is_noop) ? HWDATA : mem[reg0.HADDR[4:0]];
  end
end

assign HRDATA = mem[reg0.HADDR[4:0]];

endmodule