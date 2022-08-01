# NOTE: SummarizedBenchmark seems to require a bit of work to clean up missing data
# NOTE: SeuratObject seems to require a bit of work to use the custom function for conversion
.exclude_rdataclass <- c("AAStringSet", "adductQuantif", "BamFile",
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

.include_rdataclass <- c("bsseq", "BSseq", "DEXSeqDataSet", "ExpressionSet",
    "GSEABase::SummarizedExperiment", "RangedSummarizedExperiment",
    "RGChannelSetExtended", "SeuratObject", "SingleCellExperiment",
    "SpatialExperiment", "SummarizedExperiment")

.ehub_columns_factor <- c("species", "taxonomyid", "coordinate_1_based", "rdataclass", "sourcetype")

#' Tabulate Available Data Sets
#'
#' Tabulate available (supported) data sets.
#'
#' @param ehub An [ExperimentHub()] object.
#'
#' @return A `data.frame` of metadata.
#'
#' @rdname INTERNAL_datasets_available
.datasets_available <- function(ehub) {
    datasets_available_table <- as.data.frame(mcols(ehub))
    # Convert certain columns to factor, allowing DT::datatable to offer selectize in the corresponding search boxes.
    datasets_available_table
}

#' Coerce Data-Frame Columns to Factor
#'
#' @param x A `data.frame` object.
#' @param cols Character vector of column names to coerce to factor.
#'
#' @return An updated `data.frame` object.
#'
#' @rdname INTERNAL_dataset_factor_columns
.dataset_factor_columns <- function(x, cols) {
    for (col in cols) {
        x[[col]] <- as.factor(x[[col]])
    }
    x
}

.rdataclasses_available <- function(ehub) {
    datasets_available_table <- as.data.frame(mcols(ehub))
    rdataclass_available_values <- sort(unique(datasets_available_table$rdataclass))
}
