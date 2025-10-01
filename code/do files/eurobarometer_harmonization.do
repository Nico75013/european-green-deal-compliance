************************************************************
* Eurobarometer Harmonization - Climate Risk Perception
* Waves: 2007 → 2022
* Author: Nicolò Marchini
************************************************************

* Introduction:
* This do-file extracts and harmonizes Eurobarometer survey items 
* that measure public concern, salience, or policy priorities 
* regarding climate change.
*
* Selected variables:
* - 2007 (EB 68.2): v477   (Environment worry: climate change)
* - 2009 (EB 71.1): v500   (Serious world problem: climate change)
* - 2011 (EB 75.4): v535   (Serious world problem: climate change)
* - 2013 (EB 80.2): qa1b_1 (Serious world problem: climate change)
* - 2015 (EB 83.4): qa1t_1 (Serious world problem: climate change)
* - 2017 (EB 88.1): qd2_8  (Important environmental issue: climate change)
* - 2019 (EB 92.4): qa3_8  (Serious world problem: climate change)
* - 2020 (Harmonised 2004-2021): issue_14 (Issue the environment/climate/energy)
* - 2021 (EB 95.1): qb1b_1 (Serious world problem: climate change)
* - 2022 (EB 97.3): qc12_4 (EU policy priorities: action against climate change)
*
* Steps:
* 1. Load dataset
* 2. Inspect the variable (tab) to check coding
* 3. Generate climate_risk_perception
* 4. Recode missing values (<0)
* 5. Collapse to country–wave–year average
* 6. Export harmonized CSV
************************************************************

************************************************************
* Inspect coding of "Not mentioned" across Eurobarometer waves
************************************************************

* 2007 (EB 68.2)
use "insert/your/path/68.2_2007.dta", clear
tab v477

* 2009 (EB 71.1)
use "insert/your/path/71.1_2009.dta", clear
tab v500

* 2011 (EB 75.4)
use "insert/your/path/75.4_2011.dta", clear
tab v535

* 2013 (EB 80.2)
use "insert/your/path/80.2_2013.dta", clear
tab qa1b_1

* 2015 (EB 83.4)
use "insert/your/path/83.4_2015.dta", clear
tab qa1t_1

* 2017 (EB 88.1)
use "insert/your/path/88.1_2017.dta", clear
tab qd2_8

* 2019 (EB 92.4)
use "insert/your/path/92.4_2019.dta", clear
tab qa3_8

* 2021 (EB 95.1)
use "insert/your/path/95.1_2021.dta", clear
tab qb1b_1

* 2022 (EB 97.3)
use "insert/your/path/97.3_2022.dta", clear
tab qc12_4

* 2024 (EB 101.4)
use "insert/your/path/101.4_2024.dta", clear
tab qc1_4

************************************************************
* Harmonization and Export
************************************************************

* 2007 (EB 68.2)
use "insert/your/path/68.2_2007.dta", clear
gen climate_risk_perception = v477
replace climate_risk_perception = . if v477 < 0
collapse (mean) climate_risk_perception, by(country eb_wave eb_year)
export delimited using "insert/your/path/EB68.2_2007_harmonised.csv", replace delimiter(",")

* 2009 (EB 71.1)
use "insert/your/path/71.1_2009.dta", clear
gen climate_risk_perception = v500
replace climate_risk_perception = . if v500 < 0
collapse (mean) climate_risk_perception, by(country eb_wave eb_year)
export delimited using "insert/your/path/EB71.1_2009_harmonised.csv", replace delimiter(",")

* 2011 (EB 75.4)
use "insert/your/path/75.4_2011.dta", clear
rename v6 country
gen climate_risk_perception = v535
replace climate_risk_perception = . if v535 < 0
collapse (mean) climate_risk_perception, by(country eb_wave eb_year)
export delimited using "insert/your/path/EB75.4_2011_harmonised.csv", replace delimiter(",")

* 2013 (EB 80.2)
use "insert/your/path/80.2_2013.dta", clear
gen climate_risk_perception = qa1b_1
replace climate_risk_perception = . if qa1b_1 < 0
collapse (mean) climate_risk_perception, by(country eb_wave eb_year)
export delimited using "insert/your/path/EB80.2_2013_harmonised.csv", replace delimiter(",")

* 2015 (EB 83.4)
use "insert/your/path/83.4_2015.dta", clear
gen climate_risk_perception = qa1t_1
replace climate_risk_perception = . if qa1t_1 < 0
collapse (mean) climate_risk_perception, by(country eb_wave eb_year)
export delimited using "insert/your/path/EB83.4_2015_harmonised.csv", replace delimiter(",")

* 2017 (EB 88.1)
use "insert/your/path/88.1_2017.dta", clear
gen climate_risk_perception = qd2_8
replace climate_risk_perception = . if qd2_8 < 0
collapse (mean) climate_risk_perception, by(country eb_wave eb_year)
export delimited using "insert/your/path/EB88.1_2017_harmonised.csv", replace delimiter(",")

* 2019 (EB 92.4)
use "insert/your/path/92.4_2019.dta", clear
gen climate_risk_perception = qa3_8
replace climate_risk_perception = . if qa3_8 < 0
collapse (mean) climate_risk_perception, by(country eb_wave eb_year)
export delimited using "insert/your/path/EB92.4_2019_harmonised.csv", replace delimiter(",")

* 2020 (Harmonised Eurobarometer 2004-2021)
use "insert/your/path/harmonised_2004-2021.dta", clear
gen climate_risk_perception = .
replace climate_risk_perception = 0 if issue_14 == 1   // not mentioned
replace climate_risk_perception = 1 if issue_14 == 2   // mentioned
keep if year == 2020
collapse (mean) climate_risk_perception, by(country year)
export delimited using "insert/your/path/EB2020_harmonised.csv", replace delimiter(",")

* 2021 (EB 95.1)
use "insert/your/path/95.1_2021.dta", clear
gen climate_risk_perception = qb1b_1
replace climate_risk_perception = . if qb1b_1 < 0
collapse (mean) climate_risk_perception, by(country eb_wave eb_year)
export delimited using "insert/your/path/EB95.1_2021_harmonised.csv", replace delimiter(",")

* 2022 (EB 97.3)
use "insert/your/path/97.3_2022.dta", clear
gen climate_risk_perception = .
replace climate_risk_perception = 0 if qc12_4 == 1   // not mentioned
replace climate_risk_perception = 1 if qc12_4 == 2   // mentioned
collapse (mean) climate_risk_perception, by(country eb_wave eb_year)
export delimited using "insert/your/path/EB97.3_2022_harmonised.csv", replace delimiter(",")


