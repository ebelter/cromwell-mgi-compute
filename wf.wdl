version 1.0

workflow myWF {

  input {
    File dataTSV
    Array[Array[String]] datasets = read_tsv(dataTSV)
  }

  scatter (dataset in datasets) {
    call prcocssDataset {
      input:
        sampleName=dataset[0],
        inputFile=dataset[1],
        outputFile=dataset[2]
    }
  }
}

task processDataset {
  input {
    String sampleName
    String inputPath
    String outputPath
  }

  command {
     process_data.sh "${sampleName}" "${inputPath}"  "${outputPath}"
  }

  runtime {
    docker: "debian/buster:latest"
    memory: "16 GB"
  }
}
