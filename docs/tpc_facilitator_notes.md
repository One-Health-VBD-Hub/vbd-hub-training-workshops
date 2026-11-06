# TPC workshop: facilitator notes

## Scope and delivery

This is the 11:30–12:30 workshop on Thursday 12 November 2026. The lesson adapts
Samraat's [MQB notebook](https://mulquabio.github.io/MQB/notebooks/nlls.html),
uses the mosquito fecundity example, and prepares participants for the TPC route
of the challenge. Allometry, manual optimiser implementation, bootstrap
confidence intervals and extensive model selection are outside the hour.

The current model and datasets still need scientific and teaching review by
Chloe and Francis.

The core sequence is trait context → inspect and plot → fit one curve →
interpret the plot and peak → prepare for the challenge. The lesson connects
trait measurements to Wednesday's abundance plots and explains why performance
can peak without treating the Gaussian as a physiological mechanism. It shows
complete raw-Hub-to-fitting steps and a downloadable alternative for participants
working in RStudio without Git. Written explanations and saved plots let
participants follow the concepts while receiving coding help.

The equation and search settings are available in optional detail panels.
Residual diagnostics and removing the hottest observations are extensions for
groups that progress quickly. Prioritise a completed fit and one defensible
interpretation; reserve time for the challenge instructions. Chloe's preferred
emphasis is confidence and a usable skill.

Use the Gaussian model as an accessible first fit: peak, optimum and width are
direct parameters. Its symmetry and lack of finite zero-performance thresholds
must be explicit. The MQB example's handwritten Brière/quadratic functions are
not copied into this practical. A more realistic curve would need additional
evaluation, especially for the sharply declining development response.

## Worked example and expected results

Dataset 474 is adult-female *Aedes aegypti* fecundity from Yang et al. (2009), with
12 digitised records at 10.54–33.41 °C. It matches the repository's existing
VecTraits export and the live `ohvbd` retrieval. The original MQB file additionally
contains Beserra observations; we have retained a single-study example instead
of pooling experiments. See [data provenance](../data/tpc/README.md).

The taught Gaussian fit gives approximately:

- Peak fecundity: **8.98 eggs per female per day**.
- Optimum temperature: **31.06 °C**.
- Width parameter: **7.15 °C**.

These are exploratory estimates conditional on the model, constraints and
summary values. Hot-side coverage is limited, and the helper constrains the
optimum to the observed temperature range. Neither the point estimates nor
successful convergence establish precise knowledge of the biological optimum.
Do not report a finite critical thermal maximum from this model.

The short exercise removes observations above 30 °C and recalculates starting
values and bounds. The fitted optimum then reaches its new upper bound,
27.64 °C. This illustrates both the loss of temperature coverage and the effect
of the changed constraint. It is not evidence of a biological shift in optimum.
Ask participants to reload the original table afterwards.

Use the exercise only if time allows. If the group needs more support, ask them
to identify the fitted peak, state its units and explain why more hot-temperature
measurements would help. They can do this using the saved figure without
completing another fit.

## Challenge candidates for Chloe/Francis to review

Participants see descriptive dataset names and study DOIs, with no retrieval
code or IDs supplied in the challenge prompt. The IDs and saved tables below
are for demonstrators. Both candidates were found in live Hub searches and
retrieved with `ohvbd`; the numerical checks execute the actual lesson fitting
code. They are ready for scientific and teaching review, not an assertion that
the Gaussian model is the best model for either trait.

| Candidate | Dataset ID and fallback file | Observations | Gaussian screening result | Points to discuss |
|---|---|---|---|---|
| *Aedes aegypti* juvenile development rate, Yang et al. (2009) | **473**; `data/tpc/aedes_development_473.csv` | 19 records, 10–40.64 °C; days⁻¹ | Peak ≈0.158 days⁻¹, optimum ≈30.55 °C | Preferred first option. Includes both extremes; symmetry misses the sharp hot-side decline. Juvenile stage excludes eggs. Nearby digitised temperatures need not represent distinct experimental treatments. |
| *Anopheles gambiae* juvenile survival, Bayoh and Lindsay (2003) | **56**; `data/tpc/anopheles_survival_56.csv` | 10 records, 16–34 °C; percent | Peak ≈84.29%, optimum ≈24.00 °C | Independent study/species. Keep values in percent and cap `rmax` at 100. Nonzero predicted tails and residual patterns warrant discussion. A Gaussian least-squares curve is descriptive; the data do not supply the counts needed for a binomial analysis. |

Fecundity dataset 474 remains a fallback repeat of the worked example if a group
needs more support. Avoid presenting it as an independent new dataset.

Other screened data were not selected: dataset 169 has only four temperatures
and several resource treatments; 111 has four temperatures; 293 has only two.
Development-time datasets 57 and 108 include zero durations, whose meaning needs
checking against the original study before taking reciprocals. A recorded
temperature alone does not make a dataset suitable for fitting a whole TPC.

## Demonstrator workflow

Retrieve a specific candidate only after giving participants a chance to find it:

```r
raw <- ohvbd::fetch_vt(473) |> ohvbd::glean()
candidate <- data.frame(temp = raw$Interactor1Temp,
                        rate = raw$OriginalTraitValue)
```

Inspect units and metadata first, then use `candidate` in place of `tpc_data`
throughout the starting-value and fitting steps. For survival, set
`tpc_upper["rmax"] <- 100` before fitting. If retrieval fails, provide the matching
saved CSV and continue the analysis. Saved raw metadata and both source and
curation DOIs remain available for citation.

Check that each group can explain the observational unit, hypothesis, curve
shape, fitted peak and a limitation. Their output should include a labelled
data-and-fit plot and an explanation suited to their chosen audience. Follow
the event organisers' shared presentation instructions.

## Reproducibility and checks

Run from the repository root after `renv::restore()`:

```sh
Rscript scripts/prepare_tpc_data.R
Rscript scripts/validate_tpc_materials.R --live --write-report --write-figures
```

`prepare_tpc_data.R --refresh` retrieves all three datasets through `ohvbd`, saves
the raw fields and regenerates the smaller tables. Review count or metadata
changes before updating the manifest expectations.

The validator executes the lesson's actual code, generates its plots, checks
prepared values against the raw snapshot, fits both challenge candidates and
checks convergence, physical response bounds and different starting samples.
It also verifies that the learner's raw-to-fitting code reproduces the saved
table and tests the reduced-temperature exercise. With `--live`, it checks Hub
discoverability and compares retrieved assay values, units and context with the
snapshot. Results are in [tpc_validation.csv](tpc_validation.csv).

`--write-figures` updates the three PNGs in `images/tpc/` and their source hashes.
Without that flag the validator checks that the saved figures still match the
data and relevant taught code. The website displays saved outputs and
unevaluated code; it does not rerun TPC fitting during CI. Regenerate and review
the figures after changing the data or plotting/fitting code.

The lesson uses 100 starting combinations with a fixed seed. A narrower starting
range initially produced a different local solution for the fecundity example.
The taught wider range recovered the same coefficients across seeds 2026, 7
and 91 in validation. That is a numerical reliability check, not a confidence
interval or a guarantee of a global optimum.

Finally run `bookdown::render_book("index.Rmd")` and check the rendered lesson,
figures, CSV download, optional panels and challenge cross-references. Neither
TPC fitting nor live data retrieval is executed during rendering; the existing
theme may download its Google Fonts. Rehearse the core route within an hour and
confirm the challenge candidates before the event.
