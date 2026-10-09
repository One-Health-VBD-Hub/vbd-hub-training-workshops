# Using renv

[renv](https://rstudio.github.io/renv/index.html) is a package management solution for R projects. This repo uses renv to manage dependencies and propagate them up to the CI build pipeline.

## Using renv

`renv` is fairly early to use, but requires a few modifications to your workflow, particularly when first setting up

Before you clone the repo, you will need to make sure you have renv installed as a package.

When you have cloned the repo, you will notice a `renv.lock` file. This contains all the package information required to generate this book.

To build this into a functional library for the project on your own machine, run the command `renv::restore()`. This should download and install the relevant packages and install them into a new local library.

If you need to add an extra package to the renv installation, you can just use `install.packages()` as usual and renv SHOULD also update the lockfile accordingly.

If renv is throwing an error about a package being included in the lockfile but not used (check this using `renv::status()`), you can add a `library()` call to `dependencies.R` to force renv to recognise that the package is used.

---

When you commit after making changes to the packages used in the book, *make sure that you commit the updated renv.lock file*!
