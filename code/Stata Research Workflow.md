# Stata Research Workflow: EU Green Deal Transposition

This directory contains the Stata scripts (`.do` files) used for data processing, descriptive statistics, and **Survival Analysis** regarding the transposition of European Green Deal directives.

## 📂 Script Pipeline & Logic

The analysis follows a sequential pipeline from raw data to advanced econometric modeling.

### 1. Data Cleaning & Standardization
* [cite_start]**`build_GD_dataset.do`**: The foundational script that prepares the merged dataset for analysis[cite: 1].
    * [cite_start]**Variable Normalization**: Standardizes variable names to a consistent lowercase style (e.g., `celex`, `countrycode`, `gdppercapita`)[cite: 2, 6].
    * [cite_start]**Boolean Conversion**: Automatically converts "True/False" string variables into numeric $0/1$ dummies for variables like `amending` and `infringementprocedure`[cite: 7, 8].
    * [cite_start]**Institutional Mapping**: Generates dummies for **Federal states** and **Subnational competence** (specifically for Austria, Belgium, and Germany) to test decentralization effects[cite: 9, 10].
    * [cite_start]**Green Deal Cutoff**: Establishes **December 11, 2019**, as the official start of the Green Deal to create the `postgreendeal` indicator[cite: 10].
    * [cite_start]**Labeling**: Provides comprehensive descriptive labels for all 40+ variables, including World Governance Indicators (WGI) and Eurostat data[cite: 14, 20].

### 2. Econometric Modeling (Cox Proportional Hazards)
[cite_start]These scripts estimate the "hazard" (speed) of transposition using the `stset` command with `compliancemonths` as the time variable[cite: 24, 32, 38, 44, 52].

* [cite_start]**`Reg_model_1.do` (Institutional Factors)**: Analyzes the baseline impact of the Green Deal era, amending directives, and subnational competence[cite: 21, 25].
* [cite_start]**`Reg_model_2.do` (Political Ideology)**: Tests the role of cabinet orientation using Left-Right, State-Market, and Liberty-Authority scales[cite: 31, 33].
* [cite_start]**`Reg_model_3.do` (Policy Priorities)**: Focuses on specific government stances toward Environmental Protection, Renewables, and Sustainable Development[cite: 36, 39].
* [cite_start]**`Reg_model_4.do` (Public Salience)**: Examines the influence of climate salience (Google Trends) and public responsiveness (CRP)[cite: 43, 45].
* [cite_start]**`Reg_model_5.do` (Governance & Economics)**: Controls for Regulatory Quality, Political Stability, and GDP per capita[cite: 49, 52].

**Model Specifications included in each script:**
* [cite_start]Pooled Cox Models[cite: 25, 33, 39, 45, 52].
* [cite_start]Fixed Effects (Stratified by CELEX or Country)[cite: 25, 33, 34, 39, 53].
* [cite_start]Random Effects (Shared Frailty by CELEX or Country)[cite: 26, 33, 39, 46, 54].

### 3. Descriptive & Comparative Analysis
* [cite_start]**`Reg_model_6a.do` (Median Times)**: Calculates the median number of months for each country to reach transposition, including an EU-wide median benchmark[cite: 55, 59].
* [cite_start]**`Reg_model_6b.do` (Fragmentation)**: Computes the mean number of national acts adopted per directive to measure legislative fragmentation[cite: 61, 62].
* [cite_start]**`Reg_model_6c.do` (Governance Trends)**: Collapses the dataset to visualize country-year means for governance effectiveness and political stability[cite: 64].

## 🛠 Technical Requirements
* **Software**: Stata 16 or higher.
* [cite_start]**Path Configuration**: Update the `global main` path at the beginning of each script to match your local directory[cite: 22, 31, 36, 43, 50, 55, 61, 64].
* [cite_start]**Outputs**: Scripts are configured to export `.png` Kaplan-Meier curves and `.csv` summary tables[cite: 29, 35, 41, 47, 48, 63].

---
*This workflow ensures the reproducibility of the research regarding EU environmental policy compliance.*
