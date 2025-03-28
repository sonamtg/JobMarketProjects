clear

* Use the clean dataset
use clean_data2025.dta, replace

* Estimate a double fixed effect model with individual and firm fixed effects with controls year dummies, age and age squared
* Also, save the estimated fixed effects for individuals and firms

reghdfe lws age_centered age_centered_sq ib1990.year, absorb(id firm_id, savefe) vce(robust)

* Save the estimated fixed effects

* Rename the saved individual and firm fixed effects
rename __hdfe1__ fe_id
rename __hdfe2__ fe_firm

* Add a label to describe the individual and firm fixed effects
label var fe_id "Individual Fixed Effects"
label var fe_firm "Firm Fixed Effects"

* Calculate the Sum of Coworker Fixed Effects

* For each worker i in firm j at time t, calculate the sum of the fixed effects of all coworkers in the same firm-year, excluding worker i
bysort firm_id year: egen total_fe_id = total(fe_id)
gen sum_coworker_fe = total_fe_id - fe_id

* For each worker i in firm j at time t, calculate the number of workers in the firm
bysort firm_id year: gen firm_size = _N

* Find the average post AKM estimation fixed effects by dividing the sum of the coworkers' fe by the firm size - 1 to exclude the own fe
gen avg_coworker_fe = sum_coworker_fe / firm_size - 1

* Add a label to describe Average Coworker FE
label var avg_coworker_fe "Average Coworker FE"

* Save the dataset with fixed effects
save akm_fe_results.dta, replace
