# Basics

Examples and exercises from 'Basics' section of verilog class.

## The Careless Assumption

- A careless assumption prevents prover from finding bug.

- Edit careless_assumption.sv, remove unhelpful assumeption at line 14, and induction will then fail as expected.

Run Proof
```bash
$ sby -f careless_assumption.sby
```

When proof fails, view trace with GTKWave:

```bash
$ gtkwave careless_assumption/engine_0/trace_induct.vcd
```