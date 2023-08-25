module tb;

logic HCLK, HRESETn;

initial begin
  HCLK = 0;
  forever #5ns HCLK = ~HCLK;
end

AHB_top dut (.*);

initial begin
  RESET();

  repeat(20) @(posedge HCLK);

  $stop();
end

task RESET();
  HRESETn = 1'b0;
  repeat (10) @(posedge HCLK);
  HRESETn = 1'b1;
  repeat (1) @(posedge HCLK);
endtask

endmodule