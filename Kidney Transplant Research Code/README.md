# Investigating the impact of transportation logistics on kidney acceptance offer decisions - Summer 2024 Biostatistics Research Project

## Sonam T Gurung, Chronic Disease Research Group (CDRG), Scientific Registry of Organ Transplant (SRTR) 

### flights_data_cleaning.Rmd
This Rmd file reads all the on-time commercial flights in January 2023 and adds the coordinates for the origin and destination airports.

### offer_data_cleaning_deid.Rmd
This Rmd file cleans the kidney offer acceptance dataset, which contains observations from January 2024 to April 2024. The assumptions made during the cleaning process are documented in the Rmd file as comments.
At the end of the file, the coordinates of the donor hospital and transplant center are joined to the cleaned kidney offer acceptance dataset.

### offer_accep_model_data_prep.Rmd
This Rmd file categorizes the features for the LASSO regression. After the categorization process, two matrices are created: one for the response variable and the other for all the features combined to create the predictor matrix.
Finally, a 10-fold cross-validated LASSO regression is run to identify the key predictors.

