## AKM Model & Wage Spillover Effects: Analysis of Coworker Productivity

### Raw Data
- **data2025.dta**  
  - A synthetic dataset that includes matched employer-employee information
  - Each row contains an individual identifier, a firm identifier and a year of reference
 
### Cooked Data
- **clean_data2025.dta**
- **akm_fe_results.dta**

### 1. 01_data_cleaning.do
- **Purpose**: Clean and preprocess the raw data
  - Saves the cleaned dataset as cleaned_data.dta

### 2. 02_akm_model_estimation.do
- **Purpose**: Estimate the AKM model and calculate coworker fixed effects
  - Saves the dataset with fixed effects as model_results.dta

### 3. `03_spillover_analysis.do`
- **Purpose**: Analyze spillover effects and interaction with firm size
  - Exports regression results to LaTeX tables (spillo_tbl.tex` and inter_spillo_tbl.tex`)
 
  



