clear
* Load in the synthetic data by ensuring the dataset is in the working directory
use data2025.dta, clear

* Drop individuals who are below 25 years old and above 55
drop if age < 25 | age > 55

* Drop individuals whose earnings are below the first percentile or above the 99th percentile

* Calculate the 1st and 99th percentiles
_pctile lws, p(1 99)

* Store the percentiles in local macros
local p1 = r(r1)
local p99 = r(r2)

* Drop observations outside the 1st and 99th percentiles
drop if lws < `p1' | lws > `p99'

* Identify the largest connected set (i.e., mobility group) and keep only those observations (look into the "groupvar()" option of the reghdfe command).

* Generate a placeholder variable for the dependent variable
gen cons = 1

* Run the reghdfe command to identify mobility groups
* The groupvar option generates a variable indicating the mobility group for each row
reghdfe cons, absorb(id firm_id) groupvar(mobility_grp)

* Count the number of observations per group
bysort mobility_grp: gen count = _N

* Find the largest group
egen max_count = max(count)

* Keep the largest mobility group
keep if count == max_count

* Find the mean age in the dataset to recenter the age variable
summarize age, meanonly
local mean_age = r(mean)

* Summarize age
sum age

* Since the range for age is from 25 to 55, I am going to center the age using the mean age value

* Create a centered age variable by subtracting the mean age from the original age
gen age_centered = age - `mean_age'

* Generate the squared term of the centered age 
gen age_centered_sq = age_centered^2

* Add labels to the nw age_centered and age_centered_sq variables
label var age_centered "Age Centered"
label var age_centered_sq "Age Centered Squared"

* Define value labels for year
label define year_labels 1990 "1990" 1991 "1991" 1992 "1992" 1993 "1993" 1994 "1994"

* Apply the labels to the year variable
label values year year_labels
label var year "Year"

* Log wage label for the variable lws
label var lws "Log Wage"
