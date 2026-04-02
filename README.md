# Delivering the European Green Deal: EU Governance and Compliance

**Master’s Thesis** – University of Milan (EPS)  
**Author:** Nicolò Marchini  
**Supervisor:** Prof. Fabio Franchino  
**Academic Year:** 2024-2025  

---

## 📂 Repository Content

- **`code/`**
    - **`python scripts/`**: Notebooks for scraping **EUR-Lex (NIM)**, cleaning, and merging heterogeneous datasets including ParlGov, Manifesto Project, Eurostat, and Google Trends.
    - **`do files/`**: Stata scripts for harmonizing Eurobarometer data, generating the final `.dta` dataset, and performing econometric regressions.
- **`data/`**: Contains the final cleaned dataset ready for analysis ([`gd_transposition_ds_v1.3.dta`](https://github.com/Nico75013/european-green-deal-compliance/blob/main/data/gd_transposition_ds_v1.3.dta)).
- **`tables/`**: Comprehensive regression output tables (Latex/HTML/Excel format), including Hazard Ratios, Standard Errors, and Significance levels for the Cox proportional hazard models.
- **`figures/`**: **Kaplan-Meier** survival curves and comparative visualizations of Member State performance generated from the analysis.

---

## 🔍 Research Question

**"Has the Green Deal sped up compliance?"** This research answers this question through **Survival Analysis** (Cox proportional hazards models), investigating how institutional, political, and administrative factors influence the timing of EU directive transposition.

---

## 🛠️ Methodology & Data Pipeline

The core of this project is a novel dataset built by integrating multiple raw sources:
1. **Compliance Data**: Automated scraping of national implementation measures (NIM) from EUR-Lex.
2. **Political Context**: Government composition and ideological stances from **ParlGov** and the **Manifesto Project**.
3. **Media & Public Salience**: Climate attention tracked via **Google Trends** and **Media Cloud**.
4. **Public Opinion**: Longitudinal climate concern data from **Eurobarometer** surveys (GESIS), harmonized through linear interpolation.
5. **Governance Quality**: World Bank **Worldwide Governance Indicators** (WGI) used to measure administrative effectiveness and political stability.

---

## 📈 Key Findings

Contrary to initial expectations, the empirical analysis reveals:

* **Post-2019 Slowdown**: Directives adopted after the launch of the Green Deal are transposed up to **30 times more slowly** than those before 2019. This reflects increased technical complexity and high politicization.
* **Administrative Capacity**: Countries with efficient bureaucracies and stable political systems transpose directives roughly **twice as fast** as Member States with weaker structures.
* **Ideology Matters**: A cabinet's orientation on the **Liberty-Authority** dimension is a significant predictor; more authoritarian cabinets tend to delay transposition.
* **The Economic Factor (GDP Paradox)**: While higher **GDP per capita** is statistically significant, its impact on speed is minimal. Economic wealth alone does not guarantee faster compliance; its effect is largely mediated by **bureaucratic quality** and state capacity.
* **Public Concern Paradox**: Higher public concern about climate change is associated with **slower transposition**, as governments may approach these sensitive requirements more cautiously to align them with national strategies.

---

## 🌍 Why it Matters

The European Green Deal’s success depends not only on ambitious targets but on **timely national implementation**. This research provides insights into the **political economy of compliance**, demonstrating that the Green Deal has transformed transposition from a technical exercise into a **strategic political test** of EU governance.

---

## 📧 Contact

- **Email:** nicolo.marchini@studenti.unimi.it
- **LinkedIn:** [nicolò-marchini](https://www.linkedin.com/in/nicolò-marchini-189581252)
