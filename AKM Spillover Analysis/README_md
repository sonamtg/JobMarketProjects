## AKM Model & Wage Spillover Effects: Analysis of Coworker Productivity

### 1. `01_data_cleaning.do`
- **Purpose**: Cleans and preprocesses the raw data.
- **Steps**:
  - Drops individuals outside the age range (25–55).
  - Drops individuals outside the 1st and 99th percentiles of earnings.
  - Identifies the largest connected set (mobility group).
  - Centers age and generates age-squared.
  - Saves the cleaned dataset as `cleaned_data.dta`.

### 2. `02_akm_model_estimation.do`
- **Purpose**: Estimates the AKM model and calculates coworker fixed effects.
- **Steps**:
  - Estimates the AKM model with individual and firm fixed effects.
  - Saves the estimated fixed effects.
  - Calculates the sum and average of coworker fixed effects.
  - Saves the dataset with fixed effects as `model_results.dta`.

### 3. `03_spillover_analysis.do`
- **Purpose**: Analyzes spillover effects and interaction with firm size.
- **Steps**:
  - Analyzes the spillover effect of coworker productivity on wages.
  - Explores whether the spillover effect differs for workers in small versus large firms.
  - Exports regression results to LaTeX tables (`number_6_table.tex` and `number_7_table.tex`).



