# Selecting the right engine

Following tutorial in Symbiyosys documentation

- https://symbiyosys.readthedocs.io/en/latest/quickstart.html#selecting-the-right-engine

## Running Proof

```bash
$ sby -f memory.sby
```

## View trace in GTKWave

When proof fails:

```bash
$ gtkwave memory/engine_0/trace.vcd
```