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
log using "$models/SurvivalAnalysis_Model_2_`timestamp'.smcl", replace

use "$data", clear


******************************************************
* STEP 2. Preliminary OLS Regression and Multicollinearity Check
* ----------------------------------------------------
* Run a simple OLS regression to inspect linear relations 
* and compute VIF scores for multicollinearity diagnostics.
******************************************************
regress compliancemonths postgreendeal amending leftright statemarket libertyauthority euantipro

vif, uncentered
estat vif
display "Mean VIF: " r(meanvif)


******************************************************
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
    stcox postgreendeal amending leftright statemarket libertyauthority euantipro, hr

* === 4.2 Fixed Effects Model (Stratified by CELEX) ===
eststo polinst_fe_celex: ///
    stcox postgreendeal amending leftright statemarket libertyauthority euantipro, ///
        strata(celex) hr

* === 4.3 Random Effects Model (Shared Frailty by CELEX) ===
eststo polinst_re_celex: ///
    stcox postgreendeal amending leftright statemarket libertyauthority euantipro, ///
        shared(celex) hr

* === 4.4 Fixed Effects Model (Stratified by Country) ===
eststo polinst_fe_country: ///
    stcox postgreendeal amending leftright statemarket libertyauthority euantipro, ///
        strata(country) hr

* === 4.5 Random Effects Model (Shared Frailty by Country) ===
eststo polinst_re_country: ///
    stcox postgreendeal amending leftright statemarket libertyauthority euantipro, ///
        shared(country) hr


******************************************************
* STEP 5. Visualising Survival Patterns by Value Orientation
* ----------------------------------------------------
* Compare survival curves between liberty-oriented and
* authority-oriented cabinets using Kaplan–Meier estimates.
******************************************************

* === 5.1 Survival by Value Orientation (Liberty vs. Authority) ===
summarize libertyauthority
gen libertyauthority_high = (libertyauthority >= r(mean))
label define libauth_lbl 0 "Liberty-oriented" 1 "Authority-oriented"
label values libertyauthority_high libauth_lbl

sts graph, by(libertyauthority_high) ///
    title("Transposition Dynamics by Liberty–Authority Cabinet Orientation") ///
    xtitle("Months since deadline") ///
    ytitle("Probability not yet transposed", margin(large)) ///
    legend(order(1 "Liberty-oriented" 2 "Authority-oriented")) ///
    plot1opts(lcolor(midblue) lwidth(medthick)) ///
    plot2opts(lcolor(cranberry) lwidth(medthick)) ///
	name(KM_libauth, replace) ///
    xlabel(12 50 100 200 400 600) ///
    graphregion(color(white)) bgcolor(white) ///

graph export "$graphs/KM_libauth.png", replace width(1200)

log close
