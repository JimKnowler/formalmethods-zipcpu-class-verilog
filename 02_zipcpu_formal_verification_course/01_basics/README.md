# Basics

Examples and exercises from 'Basics' section of verilog class.

## The Careless Assumption

- A careless assumption prevents formal solver from finding bug.

- Edit careless_assumption.sv, remove unhelpful assumeption at line 14, and induction will then fail as expected.

Run Proof
```bash
$ sby -f careless_assumption.sby
```

When proof fails, view trace with GTKWave:

```bash
$ gtkwave careless_assumption/engine_0/trace_induct.vcd
```

## Counter

- If the testbench doesn't have an initial statement, then the solver finds an invalid initial state to fail on.

- Fix the proof by adding an initial statement, and then only apply the assert while not initialising.

Run Proof
```bash
$ sby -f counter.sby
```

When proof fails, view trace with GTKWave:

```bash
$ gtkwave counter/engine_0/trace.vcd
```