## -------- Run this script fourth to fit and interpret a logit model -------- ##


# On what day of the week are parents most likely to be late to pick up a child relative to the 
# number of hours they booked


# is_late = The parent is late if the pick up time is later than the planned pick up time
# This is going to be the response variable for my logit model
childcare_data <- childcare_data %>% 
  mutate(is_late = ifelse(pick_up_time > planned_pick_up_time, 1, 0))

# wday function gives the day of the week of the day of the shift, which is in the format daymonthyear
# label = FALSE ensures the variables are 1 to 7 instead of Sun to Sat
# This is the going to be my categorical predictor variable for my logit model
childcare_data <- childcare_data %>% 
  mutate(day_of_the_week = wday(shift_date, label = FALSE))

sum(childcare_data$is_late == 1)
sum(childcare_data$is_late == 0)

# dataset is imbalanced as 6736 parents are on-time compared to 2095 parents being late
# Realistically, this makes sense. Parents are more likely to pick up their child on time

# Converting the day of the week into a factor
childcare_data$day_of_the_week <- as.factor(childcare_data$day_of_the_week)


# Check whether it is a factor
class(childcare_data$day_of_the_week)

# The number of observations for every day of the week is balanced
table(childcare_data$day_of_the_week)
table(childcare_data$day_of_the_week)


# Logit model
logit_model <- glm(is_late ~ day_of_the_week + booked_hours, family = "binomial", data = childcare_data)

summary(logit_model)


# Tidy up the variable names output using broom
logit_results <- tidy(logit_model) %>%
  mutate(
    term = case_when(
      term == "(Intercept)" ~ "Intercept",
      term == "day_of_the_week2" ~ "Monday",
      term == "day_of_the_week3" ~ "Tuesday",
      term == "day_of_the_week4" ~ "Wednesday",
      term == "day_of_the_week5" ~ "Thursday",
      term == "day_of_the_week6" ~ "Friday",
      term == "day_of_the_week7" ~ "Saturday",
      term == "booked_hours" ~ "Booked Hours"
    ),
    odds_ratio = exp(estimate) # Calculate odds ratios
  )

# Create a good-looking table using kable
logit_results %>%
  select(term, estimate, std.error, statistic, p.value, odds_ratio) %>%
  kable(
    caption = "Logit Model: Predicting Likelihood of Being Late",
    col.names = c("Variable", "Coefficient", "Std. Error", "z-value", "p-value", "Odds Ratio"),
    digits = c(0, 3, 3, 3, 3, 3)) %>%
  kable_styling(
    bootstrap_options = c("striped", "hover", "condensed")
  ) %>%
save_kable("logit_results.png")


# I created an indicator variable to find whether a parent is late in picking up their child. 
# To do this, I found the planned pick up time by adding the check-in time to the booked hours. 
# If the actual pick up time is later than the planned pick up time, the parent is considered late. 
# Next, I utilized the wday function from the lubridate package to find the day of the week, ranging 
# from 1 (Sunday) to 7 (Saturday).

# Next, I built a logistic regression model, with the response indicating whether the parent is late 
# and the predictor variable being the day of the week and the number of hours booked included as a 
# control variable. In the model, Sunday serves as the base day. The coefficients for Monday through 
# Saturday are all negative.

# To interpret the odds of being late, I exponentiated the coefficients. The results indicate that, 
# for all days from Monday to Saturday, the odds of a parent being late are lower compared to Sunday:
  
#Monday: 37.3% lower odds of being late than Sunday.

#Tuesday: 34.3% lower odds of being late than Sunday.

#Wednesday: 35.1% lower odds of being late than Sunday.

#Thursday: 24.6% lower odds of being late than Sunday.

#Friday: 41.1% lower odds of being late than Sunday. 

#Saturday: 40.1% lower odds of being late than Sunday.


#All coefficients are statistically significant at the 0.05 significance level. 

#In conclusion, parents are most likely to be late in picking up their child on Sunday after 
# controlling for the number of booked hours and the all the differences are statistically significant.

# Predicting the odds of the parent being late for each observation using the logit model
childcare_data$predicted_lateness <- predict(logit_model, type = "response")

# A bar chart to visualize the mean predicted lateness through the logit model for all days of the week 
ggplot(childcare_data, aes(x = day_of_the_week, y = predicted_lateness)) +
  geom_bar(stat = "summary", fun = "mean", fill = "skyblue") +
  labs(x = "Day of the Week", y = "Predicted Probability of Being Late") +
  theme_bw()


# Using the model, the average predicted probability of being late is also highest on Sunday. 
# However, the highest predicted probability is only around 0.48 indicating that the model's issue to 
# distinguish between late and on-time observations. The dataset is imbalanced with 6736 late observations 
# compared to 2095 on-time observations, which may affect the classification. The imbalance could be addressed 
# by oversampling the on-time observations and rebuilding the logit model. 

# The primary focus is on statistical inference and significance rather than classification accuracy. 
# So, I did not include the code for balancing the dataset.
