## -- Run this script first to read and clean the childcare_data -- ##
library(tidyverse)
library(broom) 
library(kableExtra)


childcare_data <- read_csv("childcare_data.csv")


class(childcare_data$check_in_time)
class(childcare_data$pick_up_time)

# Converting the child's arrival and pick-up at the center into a date format
childcare_data <- childcare_data %>% 
  mutate(check_in_time = dmy_hms(check_in_time),
         pick_up_time = dmy_hms(pick_up_time))

# Since the shiftid has the shift day, start and end times, I am creating 3 different columns
# - shift_date - The day of the shift in the format 
# - shift_check_in - The start time of the caregiver's shift with the day
# - shift_check_out - The end time of the caregiver's shift with the day

childcare_data <- childcare_data %>%
  mutate(
    # Extract date and times from shiftid
    shift_date = gsub(" .*", "", shiftid),
    shift_check_in = sub(" to.*", "", sub(".*?\\s", "", shiftid)),
    shift_check_out = gsub(".*to ", "", shiftid),
    # Converting noon to 12 p.m. for the shift check in and shift check out
    shift_check_in = ifelse(shift_check_in == "noon", "12 p.m.", shift_check_in),
    shift_check_out = ifelse(shift_check_out == "noon", "12 p.m.", shift_check_out),
    
    # Combine the day with the time, which is still of type string
    shift_check_in = paste(shift_date, shift_check_in),
    shift_check_out = paste(shift_date, shift_check_out),
    
    # Converting a.m. and p.m. to AM and PM to convert them into date format
    shift_check_in = gsub("a.m.", "AM", shift_check_in),
    shift_check_in = gsub("p.m.", "PM", shift_check_in),
    shift_check_out = gsub("a.m.", "AM", shift_check_out),
    shift_check_out = gsub("p.m.", "PM", shift_check_out)
  ) %>%
  
  # Convert the shift_check_in and shift_check_out to day month year hour format and the shift_date as a day month year format
  mutate(
    shift_date = dmy(shift_date),
    shift_check_in = dmy_h(shift_check_in),
    shift_check_out = dmy_h(shift_check_out)
  )

# Adjust for shifts that span midnight to account for the change in day
# 07jun1982 7 p.m. to 4 a.m. -> 07jun1982 7 p.m. to 08jun1982 4 a.m.

childcare_data <- childcare_data %>%
  mutate(
    shift_check_out = if_else(
      shift_check_out < shift_check_in,
      shift_check_out + days(1), 
      shift_check_out
    )
  )


## EDA and understading the dataset before moving on to the questions

# Children are being checked in from 15th May 1982 to 15th July 1982
# The dataset range is for a period of 2 months
range(childcare_data$check_in_time)

range(childcare_data$booked_hours)

# No missing values for the rows we will be focusing on
sum(is.na(childcare_data$booked_hours))
sum(is.na(childcare_data$shiftid))
sum(is.na(childcare_data$check_in_time))
sum(is.na(childcare_data$pick_up_time))


# Planned pick-up time = Check-in time + Booked hours
# Lateness = Pick-up time - Planned pick-up time

childcare_data <- childcare_data %>% 
  mutate(planned_pick_up_time = check_in_time + hours(booked_hours))

# Summarizing the total number of early pickups
childcare_data %>%
  summarize(total_early_pickups = sum(pick_up_time < planned_pick_up_time))

# Summarizing the total number of late pickups
childcare_data %>%
  summarize(total_late_pickups = sum(pick_up_time > planned_pick_up_time))
