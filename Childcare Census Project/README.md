# Childcare Center Pro

## Required Files

### Data
- **childcare_data.csv**  
  - A hypothetical data describing the flow of children in a 24-hour childcare center, where parents can drop off children for temporary backup care. Children are assigned to caregivers working in shifts, starting at a set time and staying until all children in their care are picked up (which may occasionally be past the end of their scheduled shift). Children who arrive are assigned to the first available caregiver. If no caregiver is available, a child (and the adult accompanying them) will wait for the first available caregiver.


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
