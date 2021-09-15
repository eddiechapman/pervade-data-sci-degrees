library(dplyr)

degree_path <- file.path('data-raw', 'degree_program_metadata.csv')

degrees_df <- 
  readr::read_csv(degree_path) %>%
  select(
    degree_id = ID, 
    degree_level = 'DEGREE LEVEL',
    degree_name = DEGREE,
    degree_type = 'DEGREE RECODED',
    degree_url = URL, 
    degree_category = CATEGORY,    # what is the difference between `CATEGORY` and DEGREE RECODED?
    degree_data_sci_flag = 'DATA SCIENCE',
    department_name = DEPARTMENT,
    department_type = 'DEPARTMENT RECODED',
    institution_name = UNIVERSITY, 
    institution_carnegie = CARNEGIE,
    institution_state = STATE,
    institution_city = CITY
  ) %>%
  mutate(
    degree_level = recode(degree_level, 'C' = 'certificate', 'B' = 'bachelors', 'M' = 'masters', 'D' = 'doctoral'),
    degree_id = as.numeric(degree_id)
  )


coding_data_path <- file.path('data-raw', 'atlas_coding_data.csv')

quotes_df <- 
  readr::read_csv(coding_data_path) %>%
  mutate(degree_id = as.numeric(substr(document, 1, 4)),
         quote_id = group_indices(., quotation),
         quotation = stringr::str_trim(quotation)) %>%
  select(quote_id, degree_id, quote = quotation, codes, comment)


codes_df <-
  quotes_df %>%
  mutate(codes = stringr::str_split(codes, ', ')) %>%
  tidyr::unnest_longer(codes) %>%
  select(quote_id, degree_id, code = codes)


quotes_df <- select(quotes_df, quote_id, degree_id, quote, comment)


# Output

degrees_out_path <- file.path('data', 'degrees.csv')
quotes_out_path <- file.path('data', 'quotes.csv')
codes_out_path <- file.path('data', 'codes.csv')

readr::write_csv(degrees_df, file = degrees_out_path)
readr::write_csv(quotes_df, file = quotes_out_path)
readr::write_csv(codes_df, file = codes_out_path)
