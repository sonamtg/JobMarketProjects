# Childcare Center Project

## Required Files

### Data
- **childcare_data.csv**  
  - A hypothetical data describing the flow of children in a 24-hour childcare center, where parents can drop off children for temporary backup care.
  - Children are assigned to caregivers working in shifts, starting at a set time and staying until all children in their care are picked up (which may occasionally be past the end of their scheduled shift). Children who arrive are assigned to the first available caregiver.
  - If no caregiver is available, a child (and the adult accompanying them) will wait for the first available caregiver.

### Variables
- stay_num: Identifier for the child's stay
- caregiver_name: Name of the caregiver
- shiftid: String variable indicating the date and start and end times of the caregiver’s shift. If the shift crosses midnight, the date corresponds to the start time.
- check_in_time: Date and time of child's arrival at the center
- pick_up_time: Date and time of child's pick-up
- booked_hours: number of hours booked by parent at drop-off

## Sequence of Running Code Files

1. Run childcare_data_cleaning.R
2. Run census_data_creation.R
3. Run census_data_plots.R
4. Run logit_model.R
5. **Note**: Make sure all required packages are installed and set your working directory to the location containing the childcare_dataset.csv

## Output Produced
- **census_data.csv**: Dataset recording the “census” (i.e., the number of children under a caregiver's supervision who have checked in and not yet been picked up) during each caregiver’s shift
