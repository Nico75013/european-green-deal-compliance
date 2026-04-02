# Visual Analysis: Kaplan-Meier Survival Curves

This directory contains the **Kaplan-Meier survival curves** generated to visually estimate the probability of a directive remaining untransposed over time. Each figure compares different groups of directives or Member States based on key institutional, political, and social covariates.

---

## 📊 Core Policy Findings

### [Survival Before and After the Green Deal (2019)](https://github.com/Nico75013/european-green-deal-compliance/blob/main/figures/KM_postgreendeal.png)
* **Description**: Compares the speed of transposition for directives adopted before (blue) and after (red) the launch of the European Green Deal on December 11, 2019.
* **Key Insight**: The "Post-Green Deal" curve declines more gradually, visually confirming that directives adopted after 2019 remain untransposed for longer periods compared to earlier ones.

### [Survival by Amending vs. Non-Amending Directives](https://github.com/Nico75013/european-green-deal-compliance/blob/main/figures/KM_amending.png)
* **Description**: Differentiates between brand-new directives and those that modify existing legislation.
* **Key Insight**: The "Amending" curve (red) drops much faster than the "Non-Amending" curve (blue), demonstrating that updates to existing laws are transposed significantly more quickly.

---

## 🏛️ Institutional & Administrative Capacity

### [Survival by Government Effectiveness](https://github.com/Nico75013/european-green-deal-compliance/blob/main/figures/KM_goveffectiveness.png)
* **Description**: Segregates Member States by high vs. low administrative capacity scores from the World Bank WGI indicators.
* **Key Insight**: Countries with higher government effectiveness (blue line) show a faster drop in the probability of non-compliance, particularly in the first 100 months.

### [Survival by Subnational vs. Central Competence](https://github.com/Nico75013/european-green-deal-compliance/blob/main/figures/KM_subnatcompetence.png)
* **Description**: Compares transposition times when managed by regional/subnational authorities (e.g., Austria and Belgium) versus central state control.
* **Key Insight**: Directives delegated to subnational entities tend to remain untransposed longer, likely due to increased coordination complexity.

---

## 🗳️ Political & Public Opinion Dynamics

### [Liberty–Authority Cabinet Orientation](https://github.com/Nico75013/european-green-deal-compliance/blob/main/figures/KM_libauth.png)
* **Description**: Plots survival based on the cultural and value orientation of governing cabinets.
* **Key Insight**: Authoritarian-oriented cabinets (red) consistently sit slightly above the liberty-oriented curve, indicating a slower transposition pace for these governments.

### [Climate Concern (Public Concern / CRP)](https://github.com/Nico75013/european-green-deal-compliance/blob/main/figures/KM_crp.png)
* **Description**: Uses Eurobarometer data to compare countries where citizens express high versus low concern about climate change.
* **Key Insight**: High public concern (red) is paradoxically associated with a slower transposition curve, suggesting that governments may approach these politically sensitive files more cautiously.

### [Policy Orientations (Climate & Sustainable Development)](https://github.com/Nico75013/european-green-deal-compliance/blob/main/figures/KM_climate.png)
* **Description**: These figures ([Climate Orientation](https://github.com/Nico75013/european-green-deal-compliance/blob/main/figures/KM_climate.png) and [Sustainable Development Orientation](https://github.com/Nico75013/european-green-deal-compliance/blob/main/figures/KM_sustain.png)) examine if progressive environmental agendas accelerate speed.
* **Key Insight**: Cabinets strongly committed to these goals actually show slower transposition rates, likely because they put more effort into ensuring new EU rules align correctly with their national strategies.

---

## 🛠 Note on Reading Kaplan-Meier Curves
* **Y-axis**: The probability of the directive **not yet** being transposed ($1.00 = 100\%$ untransposed).
* **X-axis**: Analysis time measured in **months** since the transposition deadline.
* **Vertical Drops**: Each drop represents one or more transposition events (directives being implemented).
