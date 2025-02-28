# Life Expectancy Calculation, Weighting, and Reweighting Analysis

## Required Files

### Data
- **microdata.csv**  
  - This is an individual-level dataset containing two variables for each individual: birth year and death year.  
  - If an individual is still alive as of the present, the death year is recorded as `NA`.  
  - This dataset is used for the analysis in the `Life Expectancy.Rmd` file.

- **data-task-year-race-education-collapse.csv**  
  - This dataset contains aggregated data on mortality rates and population counts by year, race, education, and age.  
  - It is used for the analysis in the `Life Expectancy by Race and Edu.Rmd` file.

### Code
- **Life Expectancy.Rmd**  
- **Life Expectancy by Race and Edu.Rmd**

## Sequence of running code files

- Run LifeExpectancy.Rmd 
- Run Life Expectancy by Race and Edu.Rmd
- Note: Make sure all packages are installed first and to set your working directory with both the datasets

## Output Produced
Two individual pdf files
Life-Expectancy.pdf - Regression and Life Expectancy
Life-Expectancy-by-Race-and-Edu.pdf - Weighting and Reweighting method to find Life Exppectancy by Race and Education


