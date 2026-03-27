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
sprocket run workflow.wdl --target main 'infiles=["data/alice.txt","data/bob.txt","data/charlie.txt"]' -o results
less results/runs/main/2026-03-27_155635442910000/outputs.json
```

Where we can get paths to the final files:

```json
{
  "main.final_letter": [
    "/Users/jchang99/github/j23414/test-sprocket/results/runs/main/2026-03-27_155635442910000/calls/ADD_FAREWELL-0/attempts/0/work/alice_greeting_letter.txt",
    "/Users/jchang99/github/j23414/test-sprocket/results/runs/main/2026-03-27_155635442910000/calls/ADD_FAREWELL-1/attempts/0/work/bob_greeting_letter.txt",
    "/Users/jchang99/github/j23414/test-sprocket/results/runs/main/2026-03-27_155635442910000/calls/ADD_FAREWELL-2/attempts/0/work/charlie_greeting_letter.txt"
  ],
  "main.debug_file": [
    "/Users/jchang99/github/j23414/test-sprocket/results/runs/main/2026-03-27_155635442910000/calls/ADD_GREETING-0/attempts/0/work/alice_greeting.txt",
    "/Users/jchang99/github/j23414/test-sprocket/results/runs/main/2026-03-27_155635442910000/calls/ADD_GREETING-1/attempts/0/work/bob_greeting.txt",
    "/Users/jchang99/github/j23414/test-sprocket/results/runs/main/2026-03-27_155635442910000/calls/ADD_GREETING-2/attempts/0/work/charlie_greeting.txt"
  ]
}

```

Also checked on HPC

```bash
module load sprocket
sprocket run workflow.wdl --target main 'infiles=["data/alice.txt","data/bob.txt","data/charlie.txt"]' -o results
#> picked up a standard node, good
#> there is a local sprocket.toml that loads (look up specification)
```


# LSF

Or submit to LSF with

```bash
bsub < submit_job.lsf
# Good: Submitted 1 main job and 3 child jobs for alice, bob, and charlie
```

# Note on parallelization

Preferentially use scatter-gather in the workflow.

* Perhaps explore pros/cons of supporting Terra.bio style data.tables.
* Perhaps explore pros/cons of supporting globs `data/*.txt`
