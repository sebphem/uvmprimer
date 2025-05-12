# notes

tinyyalu_bfm writes to the command and result monitors



## command monitor

command monitor is a uvm component because they both are being written to directly by the tinyalu bfm, which then broadcasts that to teh analysis port being used by the coverage component and the scoreboard. Coverage needs the data because it will track how many of our bins we're covering and 

