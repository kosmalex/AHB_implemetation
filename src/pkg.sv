package util;
  typedef enum logic[1:0] {IDLE, BUSY, NONSEQ, SEQ} trans_t;
  typedef enum logic[2:0] {SINGLE, INCR, WRAP4, INCR4, WRAP8, INCR8, WRAP16, INCR16} burst_t;
endpackage