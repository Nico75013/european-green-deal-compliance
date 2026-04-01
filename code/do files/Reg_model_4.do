clear all
set more off

******************************************************
* STEP 1. Define paths
* ----------------------------------------------------
* Set the main project directories for:
* - main: root folder
* - data: input dataset (merged transposition file)
* - models: output folder for regression results
******************************************************
global main "/Users/nicolomarchini/Documents/Universita/Magistrale/Tesi Magistrale"
global data   "$main/Merged Datasets/gd_transposition_ds_v1.3.dta"
global models "$main/Outputs/Models"
global graphs "$main/Outputs/Graphs"

local timestamp : display %tdCCYY-NN-DD = daily("`c(current_date)'", "DMY")
log using "$models/SurvivalAnalysis_Model_4_`timestamp'.smcl", replace

use "$data", clear


******************************************************
* STEP 2. Preliminary OLS Regression and Multicollinearity Check
* ----------------------------------------------------
* Run a simple OLS regression to inspect linear relations 
* and compute VIF scores for multicollinearity diagnostics.
******************************************************
regress compliancemonths postgreendeal amending rcmclimatesalience crp

vif, uncentered
estat vif
display "Mean VIF: " r(meanvif)

*****************************************************
* STEP 3. Declare Survival-Time Data
* ----------------------------------------------------
* Define survival structure:
* - Time variable: compliancemonths
* - Failure indicator: event = 1 if transposition occurred
******************************************************
gen event = !missing(publicationdate)
label var event "Transposition occurred (1=Yes, 0=No)"

stset compliancemonths, failure(event)


******************************************************
* STEP 4. Cox Proportional Hazards Models
* ----------------------------------------------------
* Estimate models testing the role of political orientation 
* in transposition speed under alternative specifications:
* - Pooled model (baseline)
* - Stratified (fixed effects) by directive and by country
* - Shared frailty (random effects) by directive and by country
******************************************************

* === 4.1 Pooled Model ===
eststo polinst_pooled: ///
    stcox postgreendeal amending rcmclimatesalience crp, hr

* === 4.2 Fixed Effects Model (Stratified by CELEX) ===
eststo polinst_fe_celex: ///
    stcox postgreendeal amending rcmclimatesalience crp, ///
        strata(celex) hr

* === 4.3 Random Effects Model (Shared Frailty by CELEX) ===
eststo polinst_re_celex: ///
    stcox postgreendeal amending rcmclimatesalience crp, ///
        shared(celex) hr

* === 4.4 Fixed Effects Model (Stratified by Country) ===
eststo polinst_fe_country: ///
    stcox postgreendeal amending rcmclimatesalience crp, ///
        strata(country) hr

* === 4.5 Random Effects Model (Shared Frailty by Country) ===
eststo polinst_re_country: ///
    stcox postgreendeal amending rcmclimatesalience crp, ///
        shared(country) hr

******************************************************
* STEP 5. Visualising Survival Patterns by Climate Indicators
* ----------------------------------------------------
* Compare survival curves by:
* - Relative Climate Salience (Google Trends)
* - Comparative Responsiveness (Climate Concern / CRP)
******************************************************

* === 5.1 Survival by Relative Climate Salience (Google Trends) ===
summarize rcmclimatesalience
gen rcmclimatesalience_high = (rcmclimatesalience >= r(mean))
label define clim_lbl 0 "Low climate salience" 1 "High climate salience"
label values rcmclimatesalience_high clim_lbl

sts graph, by(rcmclimatesalience_high) ///
    title("Transposition Dynamics by Climate Salience (Google Trends)") ///
    xtitle("Months since deadline") ///
    ytitle("Probability not yet transposed", margin(medium)) ///
    legend(order(1 "Low salience" 2 "High salience")) ///
    plot1opts(lcolor(midblue) lwidth(medthick)) ///
    plot2opts(lcolor(cranberry) lwidth(medthick)) ///
    xlabel(12 50 100 200 400 600) ///
    graphregion(color(white)) bgcolor(white)
graph export "$graphs/KM_climatesalience.png", replace width(1200)

* === 5.2 Survival by Comparative Responsiveness (Climate Concern / CRP) ===
summarize crp
gen crp_high = (crp >= r(mean))
label define crp_lbl 0 "Low climate concern (CRP)" 1 "High climate concern (CRP)"
label values crp_high crp_lbl

sts graph, by(crp_high) ///
    title("Transposition Dynamics by Climate Concern (CRP)", size(medsmall)) ///
    xtitle("Months since deadline") ///
    ytitle("Probability not yet transposed", margin(medium)) ///
    legend(order(1 "Low CRP" 2 "High CRP")) ///
    plot1opts(lcolor(midblue) lwidth(medthick)) ///
    plot2opts(lcolor(cranberry) lwidth(medthick)) ///
    xlabel(12 50 100 200 400 600) ///
    graphregion(color(white)) bgcolor(white)
graph export "$graphs/KM_crp.png", replace width(1200)

log close
