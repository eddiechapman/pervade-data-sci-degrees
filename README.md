# PERVADE Degree Programs Analysis

## Workflow

1. Download updates to the project from Github with `git pull`

2. Run `renv::restore()` to load the state of the project from `renv.lock`

3. Make changes to the code

4. Run `renv::snapshot()` to save the state of the project to `renv.lock`

6. Save your changes to version control with `git commit`

7. Upload the changes to GitHub with `git push`


## Project structure

### `data-raw/`

Contains our raw data and the scripts used to transform and clean raw data.

If we make changes to the spreadsheet on Google Drive, we download a new version and drop it in `data-raw/` without doing any manual editing. 

### `data/`

This is where our cleaned data is saved. The cleaning scripts in `data-raw/` should save their results to this folder.


### `analyses/`

This is where we put our scripts and notebooks for analyzing the cleaned data from `data/`.



## Sources on reproducibility in R:

[Introduction to renv](https://rstudio.github.io/renv/)

[Snapshot Project Dependencies and Restore Them](https://environments.rstudio.com/snapshot.html)

[Reproducible Research Data and Project Management in R](https://annakrystalli.me/rrresearchACCE20/)

[Example of R data analysis folder layout](https://github.com/Pakillo/template)

