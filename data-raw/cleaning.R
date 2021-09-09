library(dplyr)

df <- readr::read_csv('data-raw/degree_program_metadata.csv')

# Rename columns and drop unwanted columns
df <- select(df,
  'degree_id' = 'ID', 
  'degree_level' = 'DEGREE LEVEL',
  'degree_name' = 'DEGREE',
  'degree_type' = 'DEGREE RECODED',
  'degree_url' = 'URL', 
  'degree_category' = 'CATEGORY', # what is the difference between `CATEGORY` and 'DEGREE RECODED'?
  'degree_data_sci_flag' = 'DATA SCIENCE',
  'department_name' = 'DEPARTMENT',
  'department_type' = 'DEPARTMENT RECODED',
  'institution_name' = 'UNIVERSITY', 
  'institution_carnegie' = 'CARNEGIE',
  'institution_state' = 'STATE',
  'institution_city' = 'CITY'
)


# Rename the `degree_level` values from abbreviations to full words
df <- mutate(df, 
  degree_level = recode(degree_level, 'C' = 'certificate', 'B' = 'bachelors', 'M' = 'masters', 'D' = 'doctoral')
)

readr::write_csv(df, file='data/degree_programs.csv')
