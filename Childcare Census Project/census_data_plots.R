## ---- Run this script third to visualize the census count ---- ##


# Plot how the children count changes as a caregiver's shift progresses and approaches its end
# The line shows all the children under supervision trend for each unique shift by grouping it by caregiver name and shift start time
census_data %>% 
  ggplot(aes(x = shift_remaining_hours, y = census)) +
  geom_line(aes(group = interaction(caregiver_name, shift_check_in)), alpha = 0.5) +
  geom_smooth(se = FALSE, color = "blue", linewidth = 1.2) +
  labs(
    title = "Variation of Census Count (number of children) as Shift Ends",
    x = "Hours Remaining in Shift",
    y = "Number of Children Under Supervision"
  ) +
  theme_bw()




# The plot showing the number of children under supervision for all the unique shifts 
# makes it hard to see the overall trend. Adding a smooth line shows the overall pattern, 
# indicating that the number of children under supervision peaks around 4 hours before the 
# shift ends and declines as the shift approaches its end.


# For each hours remaining in shift, calculate the average number of children under supervision
census_data %>% 
  group_by(shift_remaining_hours) %>%
  summarize(avg_children_count = mean(census, na.rm = TRUE)) %>% 
  ggplot(aes(x = shift_remaining_hours, y = avg_children_count)) +
  geom_line(color = "blue", linewidth = 1) +  
  geom_point(color = "red", size = 2) + 
  labs(
    title = "Average Census Count Over Time",
    x = "Hours remaining in shift",
    y = "Average Number of Children Under Supervision"
  ) +
  theme_bw() 



# Count for the number of observations for each hour remaining in shift
# 10 hours - 48 observations only
census_data %>% 
  group_by(shift_remaining_hours) %>%
  summarize(count = n())

# Find the maximum number of census
max(census_data$census, na.rm = TRUE)


# Find the row with the maximum number of children under supervision
max_row <- census_data[which.max(census_data$census), ]
print(max_row)


# To visualize the trend clearly, I found the average census for each remaining hour in the shift. 
# The average census (number of children under supervision) starts low when approximately 10 hours remain 
# in the shift. As the shift progresses, the average census increases and peaks when there are about 4 hours 
# remaining in the shift. After that, the average census decreases steadily as the end of the shift approaches.

# The maximum number of children under supervision is 17 during Martin's shift from 7.p.m. on 18th June 1982 to 
# 4 a.m. on 19th June 1982.
