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

### 3. **Government Dataset (with manifesto weights)**  
Notebook: `datagov_manifesto.ipynb`  
- Matches governments with party positions (DataGov + Manifesto Project).  
- ⚠️ Raw **DataGov** data were incomplete → missing governments were **added manually**.  
- A cleaned dataset `aggregated_governments_with_weighted_avg.csv` is already available on GitHub.  
- This allows skipping the notebook if reproducibility is not required.  

---

### 4. **Media Salience (Media Cloud)**  
Notebook: `media_salience_rcm.ipynb`  
- Builds **annual media salience indicators**:  
  - *Media salience (MC)*  
  - *Climate articles (MC)*  
  - *Total articles (MC)*  
- Outputs: one file per country (`MediaSalience_<country>.csv`).  

---

### 5. **Merge Media Salience with Directives**  
Script: `merge_media_salience.py`  
- Requires that **Media Salience files** have been generated.  
- Produces: `gd_ds_transposition_with_mediacloud.csv`.  

---

### 6. **Relative Climate Salience (RCM, Google Trends)**  
Script: `rcm_builder.py`  
- Computes **RCM = Climate salience / Economy salience** from Google Trends.  
- Outputs: one file per country (`RCM_<country>.csv`).  

---

### 7. **Merge RCM with Directives**  
Script: `merge_rcm_with_transposition.py`  
- Combines directive dataset with Google Trends RCM indicators.  
- Produces: `gd_ds_transposition_mediacloud_rcm.csv`.  

---

### 8. **Add Governments to Directives**  
Script: `merge_directives_with_govs.py`  
- Matches each directive with the **government in power** at publication date.  
- Uses the pre-cleaned dataset `aggregated_governments_with_weighted_avg.csv`.  
- Produces: `gd_ds_transposition_with_govs.csv`.  

---

### 9. **Prepare Dataset for Stata**  
Script: `prepare_stata_dataset.py`  
- Creates shortened variable names (Stata limitation).  
- Flags **infringement procedures**.  
- Extracts **directive short names**.  
- Produces: `gd_ds_transposition_with_govs_infr.csv`.  

---

### 10. **Eurobarometer – Climate Risk Perception (CRP)**  

#### 10.1 Harmonization (Stata Do-files)  
- Raw Eurobarometer data downloaded from [GESIS Eurobarometer](https://www.gesis.org/en/eurobarometer-data-service/survey-series/topics#:~:text=Natural,-Resources%3A%20Energy).  
- Stata do-files extract and harmonize climate risk perception indicators (`climate_risk_perception`).  
- Outputs: harmonised CSVs per wave (2007–2022).  

#### 10.2 Merge Harmonised CSVs  
Notebook: `EB_merger.ipynb`  
- Merges all harmonised Eurobarometer CSVs.  
- Produces: `EB_merged_2007_2022.csv`.  

#### 10.3 Interpolation Panel  
Script: `EB_crp_interpolation.py`  
- Builds a **balanced panel (2004–2025)**.  
- Variables:  
  - `crp_raw` – observed survey values (survey years only)  
  - `crp_interp` – interpolated values (2004–2006 filled from 2007)  
- Produces: `EB_CRPs_interp.csv`.  

---

### 11. **Merge Directives with Eurobarometer CRP**  
Script: `merge_transposition_with_ebcrps.py`  
- Final merge: directives × governments × salience × CRP.  
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
