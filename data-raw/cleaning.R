library(dplyr)
library(stringr)

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
         quotation = str_trim(quotation)) %>%
  select(quote_id, degree_id, quote = quotation, codes, comment)


codes_df <-
  quotes_df %>%
  mutate(codes = str_split(codes, ', ')) %>%
  tidyr::unnest_longer(codes) %>%
  select(quote_id, degree_id, code = codes)


quotes_df <- select(quotes_df, quote_id, degree_id, quote, comment)

courses_df <-
  quotes_df %>%
  left_join(codes_df) %>%
  filter(code == 'Courses') %>%
  mutate(course = str_split(quote, '\n')) %>%
  tidyr::unnest_longer(course) %>%
  mutate(length = str_length(course)) %>%
  filter(length < 80) %>%
  mutate(course = str_remove(course, regex('winter|spring|fall|summer', ignore_case = TRUE))) %>%
  filter(length > 10) %>%
  filter(str_detect(course, regex('\\d{3,}'))) %>%
  filter(str_detect(course, regex('[:alpha:]{5,}'))) %>%
  mutate(course = str_remove(course, regex('^[:alpha:]{2,5}[:blank:]?[:digit:]{3,4}[:blank:]?[:punct:]?[:blank:]?', ignore_case = TRUE)),
         course = str_remove(course, regex('[\\(\\[].*[\\)\\]]'))) %>%
  filter(!str_detect(course, regex('[:space:]or[:space:]', ignore_case = TRUE))) %>%
  mutate(course = str_remove(course, regex('^[:alpha:]{2,5}[:blank:]?[:digit:]{3,4}[:blank:]?[:punct:]?[:blank:]?', ignore_case = TRUE)),
         course = str_remove(course, regex(' semester | credit | credits | cr | hrs | hours ', ignore_case = TRUE)),
         course = str_remove(course, regex('^\\w*\\d[\\w\\d[:punct:]]+[[:space:]]?[[:punct:]]?[[:space:]]?')),
         course = str_remove(course, regex('^[[:space:]]?[[:punct:]]+[[:space:]]?')),
         course = str_remove(course, regex('^.*\\d+[[:punct:]]?[[:space:]]\\b')),
         length = str_length(course)) %>%
  filter(length > 8) %>%
  select(degree_id, quote_id, length, course) %>%
  arrange(length)

# Output

degrees_out_path <- file.path('data', 'degrees.csv')
quotes_out_path <- file.path('data', 'quotes.csv')
codes_out_path <- file.path('data', 'codes.csv')
courses_out_path <- file.path('data', 'courses.csv')

readr::write_csv(degrees_df, file = degrees_out_path)
readr::write_csv(quotes_df, file = quotes_out_path)
readr::write_csv(codes_df, file = codes_out_path)
readr::write_csv(courses_df, file = courses_out_path)
