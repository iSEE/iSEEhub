# NOTE: SummarizedBenchmark seems to require a bit of work to clean up missing data
# NOTE: SeuratObject seems to require a bit of work to use the custom function for conversion
.exclude_rdataclass <- sort(c("AAStringSet", "adductQuantif", "BamFile",
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
    "TENxMatrix", "tibble", "vector", "Vector"))

.include_rdataclass <- sort(c("bsseq", "BSseq", "DEXSeqDataSet", "ExpressionSet",
    "GSEABase::SummarizedExperiment", "RangedSummarizedExperiment",
    "RGChannelSetExtended", "SeuratObject", "SingleCellExperiment",
    "SpatialExperiment", "SummarizedExperiment"))

.ehub_columns_factor <- c("species", "taxonomyid", "coordinate_1_based", "rdataclass", "sourcetype")

#' Available Data Sets
#'
#' Fetch and format information available (supported) data sets.
#'
#' @param ehub An [ExperimentHub()] object.
#'
#' @return
#' `.datasets_available()` returns the `data.frame` of metadata in `ehub`.
#'
#' @rdname INTERNAL_datasets_available
.datasets_available <- function(ehub) {
    datasets_available_table <- as.data.frame(mcols(ehub))
    # Convert certain columns to factor, allowing DT::datatable to offer selectize in the corresponding search boxes.
    datasets_available_table
}

#' @return
#' `.rdataclasses_available()` returns a `character` vector of R data classes
#'
#'
#' @rdname INTERNAL_datasets_available
.rdataclasses_available <- function(ehub) {
    datasets_available_table <- as.data.frame(mcols(ehub))
    rdataclass_available_values <- sort(unique(datasets_available_table$rdataclass))
    rdataclass_available_values
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
