version 1.2

workflow main {
  input {
    Array[File] infiles
  }

  scatter(infile in infiles){
    call ADD_GREETING {
      input:
        infile = infile
   }

    call ADD_FAREWELL {
      input:
        infile = ADD_GREETING.outfile
    }
  }


  output {
    Array[File] final_letter = ADD_FAREWELL.outfile
    Array[File] debug_file = ADD_GREETING.outfile
  }
}

task ADD_GREETING {
  input {
    File infile
  }

  command <<<
    set -euo pipefail

    base=$(basename ~{infile} .txt)

    echo "Hello," > "${base}_greeting.txt"
    sleep 100
    cat ~{infile} >> "${base}_greeting.txt"
  >>>

  output {
    File outfile = "${basename(infile, '.txt')}_greeting.txt"
  }

  runtime {
    cpu: 1
    memory: "1G"
  }
}

task ADD_FAREWELL {
  input {
    File infile
  }

  command <<<
    set -euo pipefail

    base=$(basename ~{infile} .txt)

    cat ~{infile} >> "${base}_letter.txt"
    sleep 50
    echo "Goodbye!" >> "${base}_letter.txt"
  >>>

  output {
    File outfile = "${basename(infile, '.txt')}_letter.txt"
  }

  runtime {
    cpu: 1
    memory: "1G"
  }
}