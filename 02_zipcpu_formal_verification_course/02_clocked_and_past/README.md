# Clocked and $past

Examples and exercises from 'Clocked and $past' section of verilog class.

- $past(X) - value of X one clock ago
- $past(X,N) - value of x N clocks ago
- $past must be associated with a clock
- only use $past as a precondition
- use f_past_valid to avoid assumptions/assertions on state before the beginning of time

## Past Assert

- modification of counter where counter is initialised to 0
- assume that i_start_signal is never received, so counter should remain at 0
- r_counter is unconstrained before time starts, so solver can give it any value it wants in order to make things fail, and this will not show in the VCD file

```bash
$ sby -f pastassert.sby
```


