##--------- Run this script second to create the census data -----------##


# This gives the number of unique shifts
childcare_data %>% 
  group_by(caregiver_name, shift_check_in, shift_check_out) %>% 
  summarize(count = n())


# 1. For each caregiver's shift, create hourly intervals for the shift by referencing the 1st row of each group
# - The 1st row is used because all rows in the same group share the same start and end times
# 2. Expand the hourly intervals into separate rows, one for each hour within the shift using the unnest function

# Since the same shift can appear multiple times due to multiple children being supervised, 
# I create identical time intervals for all observations within the same shift. 
# This ensures that I can eventually calculate the census count accurately.

# 3. Calculate the remaining hours until the shift ends for each hourly interval
# 4. Remove the grouping for accurate next steps


hourly_data <- childcare_data %>% 
  group_by(caregiver_name, shift_check_in, shift_check_out) %>% 
  mutate(
    hourly_intervals = list(seq.POSIXt(from = shift_check_in[1], to = shift_check_out[1], by = "hour")),
    
  ) %>%
  unnest(hourly_intervals) %>% 
  ungroup() %>% 
  mutate(shift_remaining_hours = as.numeric(shift_check_out - hourly_intervals, units = "hours")
  )

# Group by each shift's hour, and count by summing up the number of children who have not yet left
# Census count - A child is still there if the check in time is earlier than or equal to the current hour right and their pick up time is later than the current hour

# Example of what the code does:-
# If a caregiver has a shift from 9 AM to 12 PM and two children:
# Child A: Checked in at 8:30 AM, picked up at 10:30 AM.
# Child B: Checked in at 9:15 AM, picked up at 11:45 AM.
# During the 9 AM interval, only child A meets the condition, so the count is 1.
# During the 10 AM interval, both children still meet the condition, so the count is 2.
# During the 11 AM interval, both children still meet the condition, so the count is 2.
# During the 12 PM interval, both children have left, so the count is 0.

hourly_data <- hourly_data %>% 
  group_by(caregiver_name, shift_check_in, shift_check_out, hourly_intervals) %>% 
  mutate(
    census = sum(check_in_time <= hourly_intervals & pick_up_time >= hourly_intervals, na.rm = TRUE)
  ) %>%
  ungroup()

# Multiple rows exist for the same hour of the same shift due to multiple children being present
# Since the children count is the same for all rows within a given hour of the same shift, I kept only the first unique row for each hour of the shift

census_data <- hourly_data %>%
  distinct(caregiver_name, shift_check_in, shift_check_out, hourly_intervals, census, .keep_all = TRUE) %>% 
  select(-booked_hours, -check_in_time, -pick_up_time)

write_csv(census_data, "census_data.csv")
