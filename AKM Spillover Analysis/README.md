## AKM Model & Wage Spillover Effects: Analysis of Coworker Productivity

### Raw Data
- **data2025.dta**  
  - A synthetic dataset that includes matched employer-employee information
  - Each row contains an individual identifier, a firm identifier, and a year of reference
 
### Cooked Data
- **clean_data2025.dta** 
- **akm_fe_results.dta**

### Code Files

 1. 01_data_cleaning.do
  - Clean and preprocess the raw data

 2. 02_akm_model_estimation.do
  -  Estimate the AKM model and calculate coworker fixed effects
    
 3. 03_spillover_analysis.do
  - Analyze spillover effects and interaction with firm size
  
## Output Produced
- **spillo_tbl.tex** Regression results for the spillover effect of coworker productivity on wages
- **inter_spillo_tbl.tex** Regression results for the interaction between spillover effects and firm size
