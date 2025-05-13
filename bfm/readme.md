# BFM

Bus functional model that is a step down from uvm, as the input and output need to be synched in the generation of the output

# components
- scoreboard (views the pins in the bfm)
- bfm (driver/viewer of the pins)
- pkg
- tester (generates test vector)

## coverpoints advanced topics

### coverpoints bin values

creates as many bins needed to fit all of the values specified into their own bins

```systemverilog
bins bin_name[] = {8'h00};
```

create n bins for all of the values
this does mean that EACH bin within the bins needs to be hit in order to be considered covered

```systemverilog
bins bin_name [n] = {[8'h00:8'hFF]};
```

this range just needs to be hit once in order to be considered covered

```systemverilog
bins bin_name = {[8'h00:8'hFF]};
```

create n child bins that each need to be hit 3 times in order for the bins to be considered covered

```systemverilog
bins bin_name [n] = {[8'h00:8'hFF]};
options.at_least = 3;
```

## coverpoints bin sequence

create a bin sequence with one bin

```systemverilog
bins bin_sequence = ([8'h00:8'h10] => [8'h11:8'h20]);
```

evenly split up all of the state transitions to be across n bins

```systemverilog
bins bin_sequence[n] = ([8'h00:8'h10] => [8'h11:8'h20]);
```

make each bin sequence need to be hit 3 times for this bin to be considered covered

```systemverilog
bins bin_sequence[n] = ([8'h00:8'h10] => [8'h11:8'h20]);
options.at_least = 3;
```

wtf is [] for repititon

```systemverilog
9[=N] //value of 9 exactly n repititions
9[*N] //value of 9 exactly n repititions
9[*] //value of 9 zero of more times
9[*2:4] //value of 9 2 to four times
9[->2] //value of 9 after two cycles
```

= is the same as \[*N\], but not IEEE standard