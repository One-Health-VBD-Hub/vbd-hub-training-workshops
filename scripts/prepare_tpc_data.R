# Run from the repository root: Rscript scripts/prepare_tpc_data.R
# Add --refresh to retrieve the same datasets through ohvbd before preparing them.
spec <- read.csv("data/tpc/datasets.csv", stringsAsFactors = FALSE)
raw_path <- "data/tpc/vectraits_raw.csv"

refresh <- "--refresh" %in% commandArgs(trailingOnly = TRUE)
if (refresh) {
  raw <- ohvbd::fetch_vt(spec$dataset_id) |> ohvbd::glean()
  raw <- as.data.frame(raw)
} else {
  raw <- read.csv(raw_path, stringsAsFactors = FALSE, na.strings = c("", "NA"))
}
stopifnot(!anyDuplicated(raw$Id), setequal(unique(raw$DatasetID), spec$dataset_id))

tables <- list()
for (i in seq_len(nrow(spec))) {
  s <- spec[i, ]
  d <- raw[raw$DatasetID == s$dataset_id, ]
  # Keep one species, trait, life stage, sex and experimental context per curve.
  stopifnot(
    nrow(d) == s$expected_rows,
    all(d$Interactor1 == s$species),
    all(d$OriginalTraitName == s$trait),
    all(d$OriginalTraitUnit == s$unit),
    all(d$Interactor1TempUnit == "Celsius"),
    all(d$DOI == s$source_doi),
    all(is.na(d$SecondStressor)),
    length(unique(d$Interactor1Stage)) == 1L,
    length(unique(d$Interactor1Sex)) == 1L,
    length(unique(d$Location)) == 1L,
    length(unique(d$Interactor1Temp)) == s$expected_temperatures,
    all(is.finite(d$Interactor1Temp)),
    all(is.finite(d$OriginalTraitValue)),
    all(d$OriginalTraitValue >= 0),
    all(d$OriginalTraitValue <= s$performance_cap)
  )
  prepared <- data.frame(
    record_id = d$Id,
    dataset_id = d$DatasetID,
    species = d$Interactor1,
    trait = d$OriginalTraitName,
    temp = d$Interactor1Temp,
    rate = d$OriginalTraitValue,
    unit = d$OriginalTraitUnit,
    source_doi = d$DOI,
    curation_doi = d$CuratedByDOI
  )
  prepared <- prepared[order(prepared$temp, prepared$record_id), ]
  tables[[s$file]] <- prepared
}

# Validate every dataset before replacing any saved files.
if (refresh) {
  write.csv(raw, raw_path, row.names = FALSE, na = "")
  spec$retrieved_on <- as.character(as.Date(Sys.time(), tz = "UTC"))
  write.csv(spec, "data/tpc/datasets.csv", row.names = FALSE, na = "")
}
for (file in names(tables)) {
  write.csv(tables[[file]], file.path("data/tpc", file), row.names = FALSE, na = "")
  message("Prepared ", file, ": ", nrow(tables[[file]]), " records")
}
