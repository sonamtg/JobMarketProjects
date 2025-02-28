# Life Expectancy Calculation, Weighting, and Reweighting Analysis

## Required Files

### Data
- **microdata.csv**  
  - This is an individual-level dataset containing two variables for each individual: birth year and death year
  - If an individual is still alive as of the present, the death year is recorded as `NA`
  - This dataset is used for the analysis in the `Life Expectancy.Rmd` file

- **data-task-year-race-education-collapse.csv**  
  - This dataset contains aggregated data on mortality rates and population counts by year, race, education, and age
  - It is used for the analysis in the `Life Expectancy by Race and Edu.Rmd` file

### Code
- Life Expectancy.Rmd
- Life Expectancy by Race and Edu.Rmd

## Sequence of Running Code Files

1. Run `LifeExpectancy.Rmd`
2. Run `Life Expectancy by Race and Edu.Rmd`
3. **Note**: Make sure all required packages are installed and set your working directory to the location containing both datasets

## Output Produced
- **Life-Expectancy.pdf**: Contains regression analysis and method to find the life expectancy
- **Life-Expectancy-by-Race-and-Edu.pdf**: Includes the weighting and reweighting methods used to calculate life expectancy by race and education


