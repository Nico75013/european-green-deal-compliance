******************************************************
* SURVIVAL ANALYSIS – MODEL 5: Governance & Economic Factors
* Nicolò Marchini | Analysis #5
******************************************************

clear all
set more off

******************************************************
* STEP 1. Define project paths
******************************************************
global main "/Users/nicolomarchini/Documents/Universita/Magistrale/Tesi Magistrale"
global data   "$main/Merged Datasets/gd_transposition_ds_v1.3.dta"
global models "$main/Outputs/Models"
global graphs "$main/Outputs/Graphs"

local timestamp : display %tdCCYY-NN-DD = daily("`c(current_date)'", "DMY")
log using "$models/SurvivalAnalysis_Model_5_`timestamp'.smcl", replace

use "$data", clear


******************************************************
* STEP 2. Preliminary OLS regression
* ----------------------------------------------------
* Before estimating survival models, run a simple OLS
* regression as a diagnostic check of linear relationships
* between transposition delay and governance/economic factors.
* Control variables: postgreendeal, amending.
******************************************************
regress compliancemonths ///
    postgreendeal amending ///
    goveffectiveness politicalstability ///
    regulatoryquality gdppercapita

* === Variance Inflation Factor (VIF) checks ===
vif, uncentered
estat vif
display "Mean VIF: " r(meanvif)

******************************************************
* STEP 3. Declare survival-time data
******************************************************
gen event = !missing(publicationdate)
label var event "Transposition occurred (1=Yes, 0=No)"

stset compliancemonths, failure(event)


******************************************************
* STEP 4. Estimate Cox regressions
* ----------------------------------------------------
* Governance & economic effects on transposition speed,
* controlling for postgreendeal and amending.
******************************************************
est clear

* === 5.1 Pooled Model ===
eststo admin_pooled: ///
    stcox postgreendeal amending ///
          goveffectiveness regulatoryquality gdppercapita politicalstability, hr

* === 5.2 Fixed Effects Model (Stratified by CELEX) ===
eststo admin_fe_celex: ///
    stcox postgreendeal amending ///
          goveffectiveness regulatoryquality gdppercapita politicalstability, ///
          strata(celex) hr

* === 5.3 Random Effects Model (Shared Frailty by CELEX) ===
eststo admin_re_celex: ///
    stcox postgreendeal amending ///
          goveffectiveness regulatoryquality gdppercapita politicalstability, ///
          shared(celex) hr

* === 5.4 Fixed Effects Model (Stratified by Country) ===
eststo admin_fe_country: ///
    stcox postgreendeal amending ///
          goveffectiveness regulatoryquality gdppercapita politicalstability, ///
          strata(country) hr

* === 5.5 Random Effects Model (Shared Frailty by Country) ===
eststo admin_re_country: ///
    stcox postgreendeal amending ///
          goveffectiveness regulatoryquality gdppercapita politicalstability, ///
          shared(country) hr


log close
