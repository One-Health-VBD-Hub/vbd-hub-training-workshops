# Saved TPC figures

These figures are generated from named code chunks in the November lesson.
The code is displayed with `eval=FALSE`: website builds copy saved figures
without fitting models or retrieving data. Participants can run every step
in RStudio.

Regenerate figures and the facilitator's numerical report from the repository
root after restoring dependencies:

```sh
Rscript scripts/validate_tpc_materials.R --write-figures --write-report
```

The validator executes the actual lesson code, checks the data and challenge
fits, and writes `fecundity-data.png`, `fecundity-fit.png` and
`fecundity-residuals.png`. `figure_sources.csv` records MD5 hashes of the teaching
data, relevant code chunks and generated images. Text line endings are normalised
so Windows and Unix checkouts agree. Running the validator without
`--write-figures` checks those hashes and rejects stale outputs. Review the
figures as well as the numerical checks when the data or code change.
