module decoder #(
  parameter WIDTH = 32
)(
  input logic[WIDTH-1:0] HADDR,

  output logic[2:0] HSELx
);

always_comb begin
  case (HADDR[31:5])
    27'd0:    HSELx = 3'b001;
    27'd1:    HSELx = 3'b010;
    27'd2:    HSELx = 3'b100;

    // This shouldn't be here a extra `default` slave must be in its place
    default: HSELx = 3'b000;
  endcase
end

endmodule