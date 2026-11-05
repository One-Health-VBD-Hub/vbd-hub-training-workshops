# VBD hub training workshops 2026

## November workshop: Thermal performance curves

The TPC lesson and its challenge route are in
[`01-vbd-hub-training-november-2026.Rmd`](01-vbd-hub-training-november-2026.Rmd).
The one-hour practical adapts the [MQB nonlinear fitting notebook](https://mulquabio.github.io/MQB/notebooks/nlls.html)
to use `rTPC`, `nls.multstart` and a single-study mosquito fecundity example from
VecTraits. Allometry is outside this session.

Open `vbd-hub-training-workshops.Rproj` and run `renv::restore()` to install the
locked dependencies. The website displays saved figures and runnable teaching
code without executing TPC fits or live Hub retrieval. Participants can use the
course page and a downloadable example without Git. See
[data provenance and preparation](data/tpc/README.md) and
[facilitator notes and challenge candidates](docs/tpc_facilitator_notes.md).

From the repository root, validate the taught code and challenge fits with:

```sh
Rscript scripts/validate_tpc_materials.R
```

Add `--live` to check Hub discovery and `ohvbd` retrieval against the snapshots,
`--write-report` to update `docs/tpc_validation.csv`, or `--write-figures` to
regenerate the [saved figures](images/tpc/README.md) after editing the taught
code or data. The validator rejects stale figures. Build the complete site with
`bookdown::render_book("index.Rmd")` in R. The existing theme may download Google
Fonts on the first build.

## Workshop 1: Data visualisations in R
### Learning objectives: By the of of this workshop, you should be able to:
Generate accessible visualisations to communicate complex data to different audiences and stakeholders.\
Formulate data-driven hypotheses from effective data visualisations.\
Build collaborative, professional connections within the VBD community.

### Prerequisites
Foundational knowledge of programming in R.\
Experience of formatting data and statistics in R.\
Basic understanding of VBDs.

## Workshop 2: Data wrangling with hub search and ohvbd
### Learning objectives: By the of of this workshop, you should be able to:
Use VBD Hub resources to access shared VBD datasets.\
Effectively wrangle real-world VDB datasets ready for further analysis.\
Build collaborative, professional connections within the VBD community.

### Prerequisites
Foundational knowledge of programming in R.\
Experience of formatting data and statistics in R.\
Basic understanding of VBDs.

