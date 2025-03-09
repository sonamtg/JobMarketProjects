# Childcare Center Pro

## Required Files

### Data
- **childcare_data.csv**  
  - A simulated 

### Code
- Life Expectancy.Rmd
- Life Expectancy by Race and Edu.Rmd

## Sequence of Running Code Files

1. Run `childcare_data_cleaning.R`
2. Run `census_data_creation.R`
3. Run `census_data_plots.R`
4. Run `logit_model.R`
5. **Note**: Make sure all required packages are installed and set your working directory to the location containing the dataset

## Output Produced
- **Life-Expectancy.pdf**: Contains regression analysis and method to find the life expectancy
- **Life-Expectancy-by-Race-and-Edu.pdf**: Includes the weighting and reweighting methods used to calculate life expectancy by race and education
