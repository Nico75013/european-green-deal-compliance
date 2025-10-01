# 📘 EU Green Deal – Dataset Construction Workflow  

This repository contains scripts and notebooks to build a **panel dataset** on EU Green Deal directives, compliance (transposition), salience (media & Google Trends), public opinion (Eurobarometer), and governments’ political characteristics.  

The dataset is progressively constructed by chaining together the following scripts. Each step must be run in the **exact order**.  

---

## ⚙️ **Requirements**  
- Python 3.10+  
- Packages: `pandas`, `numpy`, `beautifulsoup4`, `requests`, `openpyxl`  
- Stata (for harmonizing Eurobarometer raw data – see below)  

---

## 🗂 **Workflow Overview**  

### 1. **Download Directive Data**  
Notebook: `directive_downloader.ipynb`  
- Scrapes **EUR-Lex** to collect all transposition measures of Green Deal directives.  
- Outputs: one CSV per directive (`transposition_<CELEX>.csv`).  

---

### 2. **Build Directive Panel**  
Notebook: `dataframe_build.ipynb`  
- Merges all per-directive CSVs into a **master dataset**.  
- Prepares the transposition panel across EU27.  

---

### 3. **Media Salience (Media Cloud)**  
### 4. **Relative Climate Salience (RCM, Google Trends)**  
Notebook: `media_salience_rcm.ipynb`  
- Builds two sets of indicators:  
  - **Media Salience (MC)**: Media salience, climate articles, total articles (from Media Cloud).  
  - **Relative Climate Salience (RCM)**: Climate salience / Economy salience (from Google Trends).  
- Outputs:  
  - `MediaSalience_<country>.csv` (Media Cloud)  
  - `RCM_<country>.csv` (Google Trends)
    
---
### 5. **Merge Media Salience with Directives**  
Notebook: `dataframe_build.ipynb`  
- Requires the **master directives dataset** produced earlier in the same notebook (e.g., `gd_ds_transposition.csv`).  
- Merges Media Cloud files: `MediaSalience_<country>.csv`.  
- **Output:** `gd_ds_transposition_with_mediacloud.csv`.

---

### 6. **Merge RCM with Directives**  
Notebook: `dataframe_build.ipynb`  
- Requires the dataset from Step 5: `gd_ds_transposition_with_mediacloud.csv`.  
- Merges Google Trends RCM files: `RCM_<country>.csv`.  
- **Output:** `gd_ds_transposition_mediacloud_rcm.csv`.

---

### 7. **Government Dataset (with manifesto weights)**  
Notebook: `datagov_manifesto.ipynb`  
- Matches governments with party positions (DataGov + Manifesto Project).  
- ⚠️ Raw **DataGov** data were incomplete → missing governments were **added manually**.  
- A cleaned dataset [aggregated_governments_with_weighted_avg.csv](https://github.com/Nico75013/european-green-deal-compliance/blob/main/data/aggregated_governments_with_weighted_avg.csv) is already available on GitHub.
- This allows skipping the notebook and go directly to the next step.  

---

### 8. **Add Governments to Directives**  
Notebook: `dataframe_build.ipynb`  
- Matches each directive with the **government in power** at publication date.  
- Uses the pre-cleaned dataset [aggregated_governments_with_weighted_avg.csv]([https://github.com/USERNAME/REPO/blob/main/data/aggregated_governments_with_weighted_avg.csv](https://github.com/Nico75013/european-green-deal-compliance/blob/main/data/aggregated_governments_with_weighted_avg.csv)) 
- Produces: `gd_ds_transposition_with_govs.csv`.  

---

### 9. **Prepare Dataset for Stata**  
Notebook: `dataframe_build.ipynb`  
- Creates shortened variable names (Stata limitation).  
- Flags **infringement procedures**.  
- Extracts **directive short names**.  
- Produces: `gd_ds_transposition_with_govs_infr.csv`.  

---

### 10. **Eurobarometer – Climate Risk Perception (CRP)**  

#### 10.1 Harmonization (Stata Do-files)  
- Raw Eurobarometer data downloaded from [GESIS Eurobarometer](https://www.gesis.org/en/eurobarometer-data-service/survey-series/topics#:~:text=Natural,-Resources%3A%20Energy).  
- Stata do-file extract and harmonize climate risk perception indicators (`climate_risk_perception`).  
- Outputs: harmonised CSVs per wave (2007–2022).  

#### 10.2 Merge Harmonised CSVs  
Notebook: `EB_merger.ipynb`  
- Merges all harmonised Eurobarometer CSVs.  
- Produces: `EB_merged_2007_2022.csv`.  

#### 10.3 Interpolation Panel  
Notebook: `EB_merger.ipynb`  
- Builds a **balanced panel (2004–2025)**.  
- Variables:  
  - `crp_raw` – observed survey values (survey years only)  
  - `crp_interp` – interpolated values (2004–2006 filled from 2007)  
- Produces: `EB_CRPs_interp.csv`.  

---

### 11. **Merge Directives with Eurobarometer CRP**  
Notebook: `dataframe_build.ipynb`  
- Final merge: `gd_ds_transposition_with_govs_infr.csv` × `EB_CRPs_interp.csv`.  
- Exports an **Excel file** for Stata (to avoid numeric/string issues).  
- Produces: `gd_ds_transposition_for_stata.xlsx`.  

---

## ✅ Final Output  
A **Stata-ready dataset** containing:  
- Directive metadata and compliance deadlines.  
- Government political indicators.  
- Media salience (Media Cloud).  
- Google Trends RCM.  
- Eurobarometer CRP (observed + interpolated).  

This dataset supports regression analyses of **EU Green Deal compliance and transposition**.  
