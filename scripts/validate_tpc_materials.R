# Run from the repository root. Uses the actual fitting code in the lesson.
# --live also checks Hub search and ohvbd retrieval against the saved snapshot.
# --write-report saves the numerical screening report for facilitator review.
# --write-figures regenerates the saved lesson figures outside the website build.
args <- commandArgs(trailingOnly = TRUE)
spec <- read.csv("data/tpc/datasets.csv", stringsAsFactors = FALSE)
raw <- read.csv("data/tpc/vectraits_raw.csv", na.strings = c("", "NA"))

# Extract only the named TPC chunks, leaving the other workshops untouched.
lines <- readLines("01-vbd-hub-training-november-2026.Rmd", encoding = "UTF-8")
chunks <- list()
headers <- grep("^```\\{r tpc-", lines)
stopifnot(all(grepl("eval\\s*=\\s*FALSE", lines[headers])))
for (i in headers) {
  label <- sub("^```\\{r (tpc-[^,} ]+).*", "\\1", lines[i])
  end <- i + which(grepl("^```\\s*$", lines[(i + 1L):length(lines)]))[1L]
  chunks[[label]] <- paste(lines[(i + 1L):(end - 1L)], collapse = "\n")
}
run_chunk <- function(label, env) {
  stopifnot(label %in% names(chunks))
  eval(parse(text = chunks[[label]]), envir = env)
}

# Execute the taught code separately from the website build.
lesson <- new.env(parent = globalenv())
plots <- list()
grDevices::pdf(file = tempfile(fileext = ".pdf"))
for (label in c("tpc-setup", "tpc-load", "tpc-inspect", "tpc-raw-plot",
                "tpc-start-values", "tpc-fit", "tpc-parameters",
                "tpc-predictions", "tpc-residuals")) {
  result <- run_chunk(label, lesson)
  if (inherits(result, "ggplot")) {
    plots[[label]] <- result
    print(result)
  }
}
grDevices::dev.off()

# Check that the learner's raw-to-fitting steps reproduce the saved table.
retrieved <- new.env(parent = globalenv())
retrieved$fecundity_raw <- raw[raw$DatasetID == 474, ]
run_chunk("tpc-wrangle", retrieved)
for (field in names(lesson$tpc_data)) {
  stopifnot(identical(as.character(retrieved$tpc_data[[field]]),
                      as.character(lesson$tpc_data[[field]])))
}

reports <- list()
for (i in seq_len(nrow(spec))) {
  s <- spec[i, ]
  env <- new.env(parent = globalenv())
  env$tpc_data <- read.csv(file.path("data/tpc", s$file))
  d <- env$tpc_data
  r <- raw[raw$DatasetID == s$dataset_id, ]
  r <- r[match(d$record_id, r$Id), ]
  stopifnot(
    nrow(d) == s$expected_rows,
    !anyDuplicated(d$record_id),
    length(unique(d$temp)) == s$expected_temperatures,
    all(d$dataset_id == s$dataset_id),
    all(d$species == s$species), all(d$unit == s$unit),
    all(d$temp == r$Interactor1Temp),
    all(d$rate == r$OriginalTraitValue),
    all(d$source_doi == r$DOI),
    all(d$curation_doi == r$CuratedByDOI)
  )
  run_chunk("tpc-start-values", env)
  # The survival route explicitly teaches this extra biological constraint.
  env$tpc_upper["rmax"] <- min(env$tpc_upper["rmax"], s$performance_cap)
  run_chunk("tpc-fit", env)
  fit <- env$tpc_fit
  grid <- data.frame(temp = seq(min(d$temp), max(d$temp), length.out = 200))
  pred <- predict(fit, newdata = grid)
  pars <- coef(fit)
  stopifnot(fit$convInfo$isConv, all(is.finite(pars)),
            all(is.finite(pred)), all(pred >= 0),
            all(pred <= s$performance_cap),
            pars["topt"] >= min(d$temp), pars["topt"] <= max(d$temp))

  # Try genuinely different starts using the same taught fitting call.
  fitting <- parse(text = chunks[["tpc-fit"]])
  stopifnot(identical(fitting[[1L]][[1L]], as.name("set.seed")))
  differences <- numeric()
  for (seed in c(7, 91)) {
    set.seed(seed)
    eval(fitting[-1L], envir = env)
    stopifnot(env$tpc_fit$convInfo$isConv)
    differences <- c(differences, max(abs(coef(env$tpc_fit) - pars)))
  }
  stopifnot(max(differences) < 0.02)
  reports[[i]] <- data.frame(
    dataset_id = s$dataset_id, records = nrow(d),
    distinct_temperatures = length(unique(d$temp)),
    temp_min = min(d$temp), temp_max = max(d$temp),
    rmax = unname(pars["rmax"]), topt = unname(pars["topt"]),
    width = unname(pars["a"]), rss = sum(residuals(fit)^2),
    max_seed_difference = max(differences), converged = fit$convInfo$isConv
  )
}

# Check the short exercise: removing hot observations loses peak information.
exercise <- new.env(parent = globalenv())
exercise$tpc_data <- subset(lesson$tpc_data, temp <= 30)
run_chunk("tpc-start-values", exercise)
run_chunk("tpc-fit", exercise)
stopifnot(exercise$tpc_fit$convInfo$isConv,
          exercise$tpc_upper["topt"] < lesson$tpc_upper["topt"],
          abs(coef(exercise$tpc_fit)["topt"] -
                exercise$tpc_upper["topt"]) < 0.01)
message("Exercise: reduced-data optimum reaches the new upper bound (",
        round(exercise$tpc_upper["topt"], 2), " °C).")

if ("--live" %in% args) {
  live <- ohvbd::fetch_vt(spec$dataset_id) |> ohvbd::glean()
  live <- as.data.frame(live)
  stopifnot(nrow(live) == nrow(raw), !anyDuplicated(live$Id),
            setequal(live$Id, raw$Id))
  live <- live[match(raw$Id, live$Id), ]
  fields <- c("Id", "DatasetID", "Interactor1", "OriginalTraitName",
              "Interactor1Temp", "Interactor1TempUnit", "OriginalTraitValue",
              "OriginalTraitUnit", "Interactor1Stage", "Interactor1Sex",
              "Location", "SecondStressor", "DOI", "CuratedByDOI")
  for (field in fields) {
    stopifnot(isTRUE(all.equal(as.character(live[[field]]),
                               as.character(raw[[field]]))))
  }
  for (species in unique(spec$species)) {
    ids <- ohvbd::search_hub(species, db = "vt")
    stopifnot(all(spec$dataset_id[spec$species == species] %in% as.integer(ids)))
  }
  message("Live ohvbd retrieval and Hub discovery match all three snapshots.")
}

report <- do.call(rbind, reports)
print(report, row.names = FALSE)

# Keep pre-rendered figures tied to the actual taught code and saved data.
figures <- c("tpc-raw-plot" = "fecundity-data.png",
             "tpc-predictions" = "fecundity-fit.png",
             "tpc-residuals" = "fecundity-residuals.png")
figure_dir <- "images/tpc"
if ("--write-figures" %in% args) {
  dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)
  for (label in names(figures)) {
    ggplot2::ggsave(file.path(figure_dir, figures[[label]]),
                    plot = plots[[label]], width = 7,
                    height = if (label == "tpc-residuals") 3.5 else 4,
                    dpi = 144, bg = "white")
  }
}
figure_paths <- file.path(figure_dir, unname(figures))
stopifnot(all(file.exists(figure_paths)))
hash_text <- function(text) {
  file <- tempfile()
  on.exit(unlink(file))
  # Normalise text line endings so Git checkouts on Windows give the same hash.
  text <- paste0(paste(text, collapse = "\n"), "\n")
  writeBin(charToRaw(enc2utf8(text)), file)
  unname(tools::md5sum(file))
}
figure_chunks <- c("tpc-setup", "tpc-load", "tpc-raw-plot", "tpc-start-values",
                   "tpc-fit", "tpc-predictions", "tpc-residuals")
data_path <- "data/tpc/aedes_fecundity_474.csv"
sources <- data.frame(
  input = c(data_path, paste0("chunk:", figure_chunks), figure_paths),
  md5 = c(hash_text(readLines(data_path, encoding = "UTF-8")),
          vapply(figure_chunks, function(label) hash_text(chunks[[label]]), character(1)),
          unname(tools::md5sum(figure_paths))), row.names = NULL
)
manifest <- file.path(figure_dir, "figure_sources.csv")
if ("--write-figures" %in% args) {
  write.csv(sources, manifest, row.names = FALSE)
}
if (!file.exists(manifest) || !identical(read.csv(manifest), sources)) {
  stop("Saved figures are out of date. Rerun with --write-figures and review them.")
}
if ("--write-report" %in% args) {
  write.csv(report, "docs/tpc_validation.csv", row.names = FALSE)
}
message("TPC lesson, challenge fits, raw-data mapping and saved-figure checks passed.")
