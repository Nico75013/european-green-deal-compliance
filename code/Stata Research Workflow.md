# Stata Research Workflow: EU Green Deal Transposition

This directory contains the Stata scripts (`.do` files) used for data processing, descriptive statistics, and **Survival Analysis** regarding the transposition of European Green Deal directives.

## 📂 Script Pipeline & Logic

The analysis follows a sequential pipeline from raw data to advanced econometric modeling.

### 1. Data Cleaning & Standardization
* **`build_GD_dataset.do`**: The foundational script that prepares the merged dataset for analysis.
    * **Variable Normalization**: Standardizes variable names to a consistent lowercase style (e.g., `celex`, `countrycode`, `gdppercapita`).
    * **Boolean Conversion**: Automatically converts "True/False" string variables into numeric 0/1 dummies for variables like `amending` and `infringementprocedure`.
    * **Institutional Mapping**: Generates dummies for **Federal states** and **Subnational competence** (specifically for Austria, Belgium, and Germany) to test decentralization effects.
    * **Green Deal Cutoff**: Establishes **December 11, 2019**, as the official start of the Green Deal to create the `postgreendeal` indicator.
    * **Labeling**: Provides comprehensive descriptive labels for all 40+ variables, including World Governance Indicators (WGI) and Eurostat data.

### 2. Econometric Modeling (Cox Proportional Hazards)
These scripts estimate the "hazard" (speed) of transposition using the `stset` command with `compliancemonths` as the time variable.

* **`Reg_model_1.do` (Institutional Factors)**: Analyzes the baseline impact of the Green Deal era, amending directives, and subnational competence.
* **`Reg_model_2.do` (Political Ideology)**: Tests the role of cabinet orientation using Left-Right, State-Market, and Liberty-Authority scales.
* **`Reg_model_3.do` (Policy Priorities)**: Focuses on specific government stances toward Environmental Protection, Renewables, and Sustainable Development.
* **`Reg_model_4.do` (Public Salience)**: Examines the influence of climate salience (Google Trends) and public responsiveness (CRP).
* **`Reg_model_5.do` (Governance & Economics)**: Controls for Regulatory Quality, Political Stability, and GDP per capita.

**Model Specifications included in each script:**
* Pooled Cox Models.
* Fixed Effects (Stratified by CELEX or Country).
* Random Effects (Shared Frailty by CELEX or Country).

### 3. Descriptive & Comparative Analysis
* **`Reg_model_6a.do` (Median Times)**: Calculates the median number of months for each country to reach transposition, including an EU-wide median benchmark.
* **`Reg_model_6b.do` (Fragmentation)**: Computes the mean number of national acts adopted per directive to measure legislative fragmentation.
* **`Reg_model_6c.do` (Governance Trends)**: Collapses the dataset to visualize country-year means for governance effectiveness and political stability.

## 🛠 Technical Requirements
* **Software**: Stata 16 or higher.
* **Path Configuration**: Update the `global main` path at the beginning of each script to match your local directory.
* **Outputs**: Scripts are configured to export `.png` Kaplan-Meier curves and `.csv` summary tables.

---
*This workflow ensures the reproducibility of the research regarding EU environmental policy compliance.*
