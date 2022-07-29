.datasets_available <- function(ehub) {
    datasets_available_table <- as.data.frame(mcols(ehub))
    exclude_rdataclass <- c("AAStringSet", "adductQuantif", "BamFile",
        "boosting", "caretStack", "CellMapperList", "character", "Character",
        "CompressedCharacterList", "CytoImageList", "Data Frame", "data.frame",
        "data.table", "data.table data.frame",  "DataFrame", "Dframe", "DFrame",
        "dgCMatrix", "DNAStringSet", "EBImage", "environment", "FaFile",
        "FilePath", "flowSet", "GAlignmentPairs",  "gds.class",
        "GeneRegionTrack", "GenomicRanges", "GenomicRatioSet",  "GFF3File",
        "GRanges", "GSEABase::GeneSetCollection", "H5File",
        "HDF5-SummarizedExperiment", "HDF5Database", "HDF5Matrix", "Int",
        "InteractionSet", "list", "List", "list with 4 GRanges", "Lists",
        "magick-image", "matrix", "Matrix", "matrix array", "MIAME", "mzXML",
        "numeric", "preProcess", "QFeatures", "RaggedExperiment",
        "randomForest", "SigDF", "SigSet", "Spectra",
        "SpatialFeatureExperiment", "SummarizedBenchmark",  "tbl",
        "TENxMatrix", "tibble", "vector", "Vector")
    # TODO: switch to include_rdataclass when all possible types are checked
    include_rdataclass <- c("ExpressionSet", "RangedSummarizedExperiment",
        "SummarizedExperiment",  "bsseq", "SingleCellExperiment",
        "RGChannelSetExtended", "BSseq",  "SeuratObject",
        "GSEABase::SummarizedExperiment", "SpatialExperiment",
        "DEXSeqDataSet")
    # NOTE: SummarizedBenchmark seems to require a bit of work to clean up missing data
    # NOTE: SeuratObject seems to require a bit of work to use the custom function for conversion
    datasets_available_table <- datasets_available_table[which(datasets_available_table$rdataclass %in% include_rdataclass), ]
    # Convert certain columns to factor, allowing DT::datatable to offer selectize in the corresponding search boxes.
    datasets_available_table$species <- as.factor(datasets_available_table$species)
    datasets_available_table$taxonomyid <- as.factor(datasets_available_table$taxonomyid)
    datasets_available_table$coordinate_1_based <- as.factor(datasets_available_table$coordinate_1_based)
    datasets_available_table$rdataclass <- as.factor(datasets_available_table$rdataclass)
    datasets_available_table$sourcetype <- as.factor(datasets_available_table$sourcetype)
    datasets_available_table
}
