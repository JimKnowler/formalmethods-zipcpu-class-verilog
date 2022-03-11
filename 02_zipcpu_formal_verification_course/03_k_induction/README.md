# k Induction

Examples and exercises 'from the k Induction' section of the verilog class.

- number of BMC time-steps setps must be more than the number of inductive time-steps
- register values at the beginning of the inductive step can be anything allowed by your assertions and assumptions
- assertions are treated as assumptions for N steps (i.e. limiting allowable states that formal proof can use)
- induction fails at step N+1 if at all
- we continue to *assume* inputs, and *assert* local state & outputs
    - assume unrealistic inputs will never happen
    - assert any remaining unreachable states are illegal
    - Induction often requires more properties than BMC (bounded model check)
- if you assume *too much* then your design will pass formal verification but still not work
- if your formal properties are not strict enough, induction may start in an unreachable state
- results of k-induction can be inconclusive (if BMC passes and k induction fails)
    - k-induction pass will fail if your design doesn't have enough assertions
- difference in when BMC and induction finish
    - BMC will finish early if the design FAILs
    - induction will finish early if the design PASSes
    - in all other cases, they will take a full depth step

## Counter

- A counter that passes BMC but fails induction
    - BMC only tests states where counter is 0 ... N (where N is < 65000)
    - induction starts with counter = 65000 (which fails assertions), and finds N steps leading to it where counter<6500 (which pass assertions)
        - the trap: formal properties are not strict enough, so induction can start in an unreachable state

```bash
$ sby -f counter.sby
```

## Counter2

- A counter that also passes BMC but fails induction
    - BMC can test first N states, where N can be >500 (the assert) because counter is reset at 22
    - Induction still fails because it can fail at state N by setting counter to 500, and can find N previous states where the assert fails
        - the trap: formal properties are not strict enough, so induction can start in an unreachable state

```bash
$ sby -f counter2.sby
```

## Counter3

- A small change to counter2, that can pass BMC and induction
    - Assert is changed to counter <= 22, which limits states that induction can use
    - Induction can no longer find state N where the assert fails, with N previous steps where the assert passes

```bash
$ sby -f counter3.sby
```