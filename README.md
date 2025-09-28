# Delivering the European Green Deal: EU Governance, Compliance, and Economic Impacts

**Master’s Thesis** – University of Milan (EPS)  
Author: Nicolò Marchini  
Supervisor: Prof. Fabio Franchino  
Year: 2025  
⚠️ *Work in progress — repository and analysis are being continuously updated.*

---
## 📂 Repository Content
- `code/` → scripts for data collection, cleaning, and survival models  
- `data/` → structured into `raw/` and `processed/` (cleaned, shareable datasets)  
- `figures/` → regression outputs  
- `docs/` → Thesis, executive summary

## Research Question
How do EU member states comply with the European Green Deal?  
I study the **transposition of EU directives** using survival analysis (Cox proportional hazards model), focusing on political and institutional factors that influence delays.

---

 ## 🛠️ Methods
The core of this project is **collecting, cleaning, and integrating multiple raw datasets** with Python to build a novel dataset on compliance with the European Green Deal.  

- **Directives & compliance data**:  
  - Raw transposition data scraped from **EUR-Lex** (NIM pages)
- **Political context**:  
  - Government composition & party data from **ParlGov** and **Manifesto Project**  
- **Media & salience**:  
  - Public attention to climate and Green Deal issues from **Google Trends** and **Media Cloud**  
- **Public opinion**:  
  - Eurobarometer survey data (downloaded via **GESIS**)  
- **Data wrangling in Python**:  
  - Parsing HTML from EUR-Lex  
  - Standardizing country codes, party identifiers, and directive IDs  
  - Merging heterogeneous datasets into a unified structure  
  - Creating time-to-event variables for transposition delays  
---

## Key Findings
*(Preliminary — subject to revision as the work progresses)*  
- Institutional design and political coalitions strongly affect transposition times  
- Amending directives behave differently from new ones  
- The Commission’s enforcement role matters more than expected  

---

## Why it Matters
The European Green Deal’s success depends not only on ambitious targets but on **timely national implementation**.  
This research provides insights into the **political economy of compliance**, relevant for policy evaluation, EU governance, and climate politics.

---

## Contact
If you’re interested in this work, feel free to reach out:  
📧 nicolo.marchini@studenti.unimi.it
🔗 www.linkedin.com/in/nicolò-marchini-189581252 
