clear

* Load the clean data with fixed effects and spillover effect
save akm_model_results.dta, replace

* Using the estimated fixed effects, explore whether workers' wages are affected by the productivity of their coworkers
reghdfe lws fe_id fe_firm avg_coworker_fe age_centered age_centered_sq ib1990.year, vce(robust)

* Store the model with the spillover effect for later use
estimates store spillover_model

* Export the spillover effect regression results to a LaTeX table
esttab spillover_model using "number_6_table.tex", replace ///
    label booktabs b(5) se(5) ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    title("Spillover-effect Regression Results") ///
    addnotes("Robust standard errors in parentheses." "*** p<0.01, ** p<0.05, * p<0.10") ///
	drop(1990.year) // Exclude baseline groups 
	
* Explore whether the spillover effect estimated in the model aboove differs for workers in small versus large firms

* Create a binary variable to distinguish between small and large firms
* A firm is considered "large" if it has more than 50 employees
gen large_firm = firm_size > 50

* Add a label to describe the large_firm variable
label var large_firm "Large Firm or Small Firm"

* Define value labels for the large_firm variable
label define firm_label 1 "Large Firm" 0 "Small Firm"
label values large_firm firm_label

* Run a regression to explore whether the spillover effect differs for workers in large versus small firms
reghdfe lws fe_id fe_firm c.avg_coworker_fe#i.large_firm age_centered age_centered_sq ib1990.year, vce(robust)

* Store the regression results for later use
estimates store interaction_spillover_model

* Export the spillover effects with an interaction regression results to a LaTeX table
esttab interaction_spillover_model using "number_7_table.tex", replace ///
    label booktabs b(5) se(5) ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    title("Spillover effects with interaction Regression Results") ///
    addnotes("Robust standard errors in parentheses." "*** p<0.01, ** p<0.05, * p<0.10") ///
	drop(1990.year) // Exclude baseline groups 
