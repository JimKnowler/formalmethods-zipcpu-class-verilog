# Induction demo

Taken from Symbiyosys documentation

- https://symbiyosys.readthedocs.io/en/latest/quickstart.html#beyond-bounded-model-checks

## Running Proof

```bash
$ sby -f prove.sby
```

## View trace in GTKWave

When proof fails:

```bash
$ gtkwave prove/engine_0/trace.vcd
```