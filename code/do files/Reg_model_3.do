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
log using "$models/SurvivalAnalysis_Model_3_`timestamp'.smcl", replace

use "$data", clear

******************************************************
* STEP 2. Preliminary OLS Regression and Multicollinearity Check
* ----------------------------------------------------
* Run a simple OLS regression to inspect linear relations 
* and compute VIF scores for multicollinearity diagnostics.
******************************************************
regress compliancemonths postgreendeal amending ///
        environmentprotection renewables climateenergy sustainabledevelopment

vif, uncentered

vif, uncentered
estat vif
display "Mean VIF: " r(meanvif)

* === Without renewables ===
regress compliancemonths postgreendeal amending ///
        environmentprotection climateenergy sustainabledevelopment

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
    stcox postgreendeal amending environmentprotection climateenergy sustainabledevelopment, hr

* === 4.2 Fixed Effects Model (Stratified by CELEX) ===
eststo polinst_fe_celex: ///
    stcox postgreendeal amending environmentprotection climateenergy sustainabledevelopment, ///
        strata(celex) hr

* === 4.3 Random Effects Model (Shared Frailty by CELEX) ===
eststo polinst_re_celex: ///
    stcox postgreendeal amending environmentprotection climateenergy sustainabledevelopment, ///
        shared(celex) hr

* === 4.4 Fixed Effects Model (Stratified by Country) ===
eststo polinst_fe_country: ///
    stcox postgreendeal amending environmentprotection climateenergy sustainabledevelopment, ///
        strata(country) hr

* === 4.5 Random Effects Model (Shared Frailty by Country) ===
eststo polinst_re_country: ///
    stcox postgreendeal amending environmentprotection climateenergy sustainabledevelopment, ///
        shared(country) hr
		
******************************************************
* STEP 5. Visualising Survival Patterns by Policy Orientation
* ----------------------------------------------------
* Compare survival curves across cabinets' orientations toward
* climate–energy and sustainable development priorities.
******************************************************

* === 5.1 Survival by Cabinet Orientation (Climate–Energy) ===
summarize climateenergy
gen climateenergy_high = (climateenergy >= r(mean))
label define climate_lbl 0 "Low Climate–Energy Orientation" 1 "High Climate–Energy Orientation"
label values climateenergy_high climate_lbl

sts graph, by(climateenergy_high) ///
    title("Transposition Dynamics by Climate–Energy Cabinet Orientation", ///
	justification(center) size(medsmall) margin(medium)) ///
    xtitle("Months since deadline") ///
    ytitle("Probability not yet transposed", margin(medium)) ///
    legend(order(1 "Low Climate Orientation" 2 "High Climate Orientation") ///
    ring(0) position(3) region(lstyle(none))) ///
    plot1opts(lcolor(midblue) lwidth(medthick)) ///
    plot2opts(lcolor(cranberry) lwidth(medthick)) ///
    name(KM_climate, replace) ///
    xlabel(12 50 100 200 400 600) ///
    graphregion(color(white)) bgcolor(white)
graph export "$graphs/KM_climate.png", replace width(1200)


* === 5.2 Survival by Cabinet Orientation (Sustainable Development) ===
summarize sustainabledevelopment
gen sustainabledevelopment_high = (sustainabledevelopment >= r(mean))
label define sustain_lbl 0 "Low SD Orientation" 1 "High SD Orientation"
label values sustainabledevelopment_high sustain_lbl

sts graph, by(sustainabledevelopment_high) ///
    title("Transposition Dynamics by Sustainable Development Orientation", ///
    justification(center) size(medsmall) margin(medium)) ///
    xtitle("Months since deadline") ///
    ytitle("Probability not yet transposed", margin(medium)) ///
    legend(order(1 "Low SD Orientation" 2 "High SD Orientation") ///
    ring(0) position(3) region(lstyle(none))) ///
    plot1opts(lcolor(midblue) lwidth(medthick)) ///
    plot2opts(lcolor(cranberry) lwidth(medthick)) ///
    name(KM_sustain, replace) ///
    xlabel(12 50 100 200 400 600) ///
    graphregion(color(white)) bgcolor(white)

graph export "$graphs/KM_sustain.png", replace width(1200)

log close
