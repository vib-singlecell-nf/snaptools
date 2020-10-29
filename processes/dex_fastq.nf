nextflow.preview.dsl=2

// binDir = !params.containsKey("test") ? "${workflow.projectDir}/src/template/bin/" : ""

toolParams = params.sc.atac.snaptools

process SC__SNAPTOOLS__DEX_FASTQ {

    container toolParams.container
    publishDir "${params.global.outdir}/fastq/barcode_demultiplexed", mode: 'symlink'
    label 'compute_resources__default','compute_resources__24hqueue'

    input:
        tuple val(sampleId),
              val(fastq_type),
              path(fastq_read),
              path(fastq_bc)

    output:
        tuple val(sampleId),
              val(fastq_type),
              path("${sampleId}.${fastq_type}.dex.fastq.gz")

    script:
        def sampleParams = params.parseConfig(sampleId, params.global, toolParams)
        processParams = sampleParams.local
        """
        snaptools dex-fastq \
            --input-fastq ${fastq_read} \
            --output-fastq ${sampleId}.${fastq_type}.dex.fastq.gz \
            --index-fastq-list ${fastq_bc}
        """
}

