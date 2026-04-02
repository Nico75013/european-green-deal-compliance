# Econometric Analysis: Regression Output Tables

This directory contains the comprehensive results of the **Cox Proportional Hazard Models** estimated to analyze the transposition speed of European Green Deal directives. The analysis explores institutional, political, and socio-economic determinants across five distinct model specifications.

## 📊 Overview of the Models
To ensure the robustness of the results, each table includes findings across five different specifications:
1. **Pooled**: Baseline Cox model assuming homogeneity across countries and directives.
2. **FE (CELEX)**: Fixed Effects stratified by directive (CELEX code), allowing each directive its own baseline hazard.
3. **RE (CELEX)**: Random Effects with shared frailty by directive.
4. **FE (Country)**: Fixed Effects stratified by Member State, focusing on within-country variation.
5. **RE (Country)**: Random Effects with shared frailty by Member State.

---

## 📂 Table Descriptions

### [Table 1: Institutional Factors](https://github.com/Nico75013/european-green-deal-compliance/blob/main/tables/Table%201.jpg)
Examines the impact of core institutional variables on compliance speed.
* **Key Findings**: Directives that **amend** existing legislation show a significantly higher Hazard Ratio ($\approx 1.59$ in pooled models), meaning they are transposed faster. Conversely, **Subnational Competence** (transposition managed by regions or Länder) is associated with slower transposition ($HR \approx 0.88$).

### [Table 2: Political Orientation](https://github.com/Nico75013/european-green-deal-compliance/blob/main/tables/Table%202.jpg)
Tests the influence of a cabinet's general ideological stance on compliance timing.
* **Key Findings**: The **Liberty-Authority** dimension is the primary ideological predictor. Cabinets with higher authoritarian scores exhibit lower Hazard Ratios ($\approx 0.91$), indicating a slower compliance pace. Traditional Left-Right and Pro-EU scales show inconsistent or non-significant effects.

### [Table 3: Orientation towards Environmental Policies](https://github.com/Nico75013/european-green-deal-compliance/blob/main/tables/Table%203.jpg)
Analyzes how specific government stances on climate and sustainability impact speed.
* **Key Findings**: A strong cabinet focus on **Sustainable Development** is consistently associated with slower transposition ($HR \approx 0.96$ to $0.89$). This likely reflects the increased technical complexity and the need for extensive inter-ministerial coordination required for such policies.

### [Table 4: Media Salience and Public Concern](https://github.com/Nico75013/european-green-deal-compliance/blob/main/tables/Table%204.jpg)
Investigates the role of external pressure from the media and public opinion.
* **Key Findings**: **Public Concern (CRP)** is a highly significant predictor of slower transposition, with very low Hazard Ratios ($HR \approx 0.14$ in pooled models). This suggests that governments may act more cautiously and perform more extensive national consultations when public attention to climate issues is high.

### [Table 5: Administrative Quality and Political Stability](https://github.com/Nico75013/european-green-deal-compliance/blob/main/tables/Table%205.jpg)
Focuses on governance indicators and economic capacity.
* **Key Findings**: **Government Effectiveness** and **Political Stability** are strong predictors of speed in country-level models ($HR \approx 2.03$ and $HR \approx 2.90$, respectively). Notably, **GDP per capita** has a negligible impact ($HR \approx 1$), indicating that administrative quality, rather than raw economic wealth, is the primary driver of compliance.

---

## 🛠 Note on Interpretation
* **Hazard Ratio (HR) > 1**: Indicates a factor that **increases** the speed of transposition (faster compliance).
* **Hazard Ratio (HR) < 1**: Indicates a factor that **decreases** the speed of transposition (slower compliance/delays).
* Standard errors are provided in parentheses below the Hazard Ratios.
* Significance levels: *** $p < 0.01$, ** $p < 0.05$, * $p < 0.1$.
