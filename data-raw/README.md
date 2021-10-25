# `data-raw` directory

> Contains cleaning scripts and raw/intermediate data.


## Instructions

1. Run `cleaning.R`

2. Run `course_cleaning1.Rmd`

3. Import `intermediate/courses_pre_manual_clean.csv` into a spreadsheet 
application and clean each row by hand.

4. Save results of manual cleaning to `intermediate/courses_post_manual_clean.csv`

5. Run `course_cleaning2.Rmd`


## Contents

```
.
├── atlas_coding_data.csv
├── cleaning.R
├── course_cleaning1.Rmd
├── course_cleaning2.Rmd
├── degree_program_metadata.csv
├── intermediate
│   ├── courses.csv
│   ├── courses_post_manual_clean.csv
│   └── courses_pre_manual_clean.csv
└── README.md
```

### `atlas_coding_data.csv`

Export of coding data from Atlas.ti cloud version. 

Contains coded segments: the coded text, the codes assigned, and the documents
that they were drawn from.


### `cleaning.R`

The initial cleaning step. 

Reads in `atlas_coding_data.csv` and `degree_program_metadata.csv`. 
Produces cleaned datasets `codes.csv`, `degrees.csv` and `quotes.csv` all 
located in the `data` directory. Also produces a not-fully-cleaned 
`courses.csv` dataset in the `data-raw/intermediate` directory. 


### `course_cleaning1.Rmd`

Performs additional cleaning on `intermediate/courses.csv`. 

Produces intermediate cleaning file `courses_pre_manual_clean.csv` located in 
the `data-raw/intermediate` directory. 


### `course_cleaning2.Rmd`

Performs cleaning on `intermediate/courses_post_manual_clean.csv`. 

Produces cleaned dataset `data/courses.csv`. 


### `degree_program_metadata.csv`

The data science degree spreadsheet from Google Sheets. 

This is where we collected degree program information such as the
degree ID, the degree level (B, M, D), the type of program, etc.


### `intermediate/courses.csv`

Partially cleaned file containing one row per course per degree.


### `intermediate/courses_pre_manual_clean.csv`

Same as `intermediate/courses.csv` but cleaned futher. Ready for manual
cleaning.


### `intermediate/courses_post_manual_clean.csv`

Same as `intermediate/courses_pre_manual_clean.csv` but after being cleaned
row by row in Google Sheets. 



