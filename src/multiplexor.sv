module multiplexor #(
  parameter WIDTH = 32
)(
  input logic[2:0]            HSELx,

  input logic[2:0][WIDTH-1:0] HRDATAx,
  input logic[2:0]            HRESPx,
  input logic[2:0]            HREADYOUTx,
  
  output logic            HREADY,
  output logic            HRESP,
  output logic[WIDTH-1:0] HRDATA
);

always_comb begin
  case (HSELx)
    3'b001: begin 
      HRDATA = HRDATAx[0];
      HRESP  = HRESPx[0];
      HREADY = HREADYOUTx[0];
    end
    
    3'b010: begin 
      HRDATA = HRDATAx[1];
      HRESP  = HRESPx[1];
      HREADY = HREADYOUTx[1];
    end
    
    3'b100: begin 
      HRDATA = HRDATAx[2];
      HRESP  = HRESPx[2];
      HREADY = HREADYOUTx[2];
    end

    // This shouldn't be here a extra `default` slave must be in its place
    default: begin 
      HRDATA = 0;
      HRESP  = 0;
      HREADY = 1;
    end
  endcase
end

endmodule