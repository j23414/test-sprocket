# test-sprocket

Install sprocket on MacOS

```bash
brew install sprocket
```

Install sprocket VSCode extension

Install Docker, for local execution


# Test data

```bash
mkdir data
echo "alice" > data/alice.txt
echo "bob" > data/bob.txt
echo "charlie" > data/charlie.txt
```

# Sprocket

```bash
sprocket run workflow.wdl --target main infile="data/alice.txt" -o results
less results/runs/main/2026-03-26_164453951548000/outputs.json
```

Where we can get paths to the final files:

```json
{
  "main.final_letter": "/Users/jchang99/github/j23414/test-sprocket/results/runs/main/2026-03-26_164453951548000/calls/ADD_FAREWELL/attempts/0/work/alice_greeting_letter.txt",
  "main.debug_file": "/Users/jchang99/github/j23414/test-sprocket/results/runs/main/2026-03-26_164453951548000/calls/ADD_GREETING/attempts/0/work/alice_greeting.txt"
}
```

Also checked on HPC

```bash
module load sprocket
sprocket run workflow.wdl --target main infile="data/alice.txt" -o results
#> picked up a standard node, good
```

TODO

```bash
# sprocket run workflow.wdl --target main infile="data/*.txt" # NOOP, did not expand input files
# TODO figure out how to pass in a data.table of inputs (similar to Terra) to run in parallel
# TODO or if it requires coding in a scatter operation, best practices for defining inputs?
```

# LSF

Or submit to LSF with

```bash
bsub < submit_job.lsf
```

