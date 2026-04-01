******************************************************
* SURVIVAL ANALYSIS – GREEN DEAL DIRECTIVES
* Nicolò Marchini | Analysis #1
******************************************************

clear all
set more off

******************************************************
* STEP 1. Define project paths
* ----------------------------------------------------
* Define global paths for the main project directories:
* - main: root folder of the thesis project
* - data: input folder containing the merged dataset
* - models: output folder for regression estimates
* - graphs: output folder for visualizations
******************************************************
global main "/Users/nicolomarchini/Documents/Universita/Magistrale/Tesi Magistrale"
global data   "$main/Merged Datasets/gd_transposition_ds_v1.3.dta"
global models "$main/Outputs/Models"
global graphs "$main/Outputs/Graphs"

local timestamp : display %tdCCYY-NN-DD = daily("`c(current_date)'", "DMY")
log using "$models/SurvivalAnalysis_Model_1_`timestamp'.smcl", replace

use "$data", clear


******************************************************
* STEP 2. Preliminary regression
* ----------------------------------------------------
* Run a simple OLS regression as a baseline check to explore
* the linear relationship between transposition delay and 
* institutional/political covariates.
******************************************************
regress compliancemonths postgreendeal amending subnatcompetence coalitionsize technicalcabinet

vif, uncentered
estat vif
display "Mean VIF: " r(meanvif)

******************************************************
* STEP 3. Declare survival-time data
* ----------------------------------------------------
* Define the duration variable (compliancemonths) and the
* event indicator (1 if transposed, 0 otherwise).
******************************************************
gen event = !missing(publicationdate)
label var event "Transposition occurred (1=Yes, 0=No)"

stset compliancemonths, failure(event)


******************************************************
* STEP 4. Estimate Cox regressions
* ----------------------------------------------------
* Estimate a series of Cox proportional hazard models with
* alternative specifications to account for both directive-
* and country-level heterogeneity.
*
* Models:
* 4.1 Pooled model (baseline)
* 4.2 Fixed effects (stratified by CELEX)
* 4.3 Random effects (shared frailty by CELEX)
* 4.4 Fixed effects (stratified by country)
* 4.5 Random effects (shared frailty by country)
******************************************************
est clear

* === 4.1 Pooled Model ===
eststo polinst_pooled: ///
    stcox postgreendeal amending subnatcompetence coalitionsize technicalcabinet, hr

* === 4.2 Fixed Effects Model (Stratified by CELEX) ===
eststo polinst_fe_celex: ///
    stcox postgreendeal amending subnatcompetence coalitionsize technicalcabinet, strata(celex) hr

* === 4.3 Random Effects Model (Shared Frailty by CELEX) ===
eststo polinst_re_celex: ///
    stcox postgreendeal amending subnatcompetence coalitionsize technicalcabinet, shared(celex) hr

* === 4.4 Fixed Effects Model (Stratified by Country) ===
eststo polinst_fe_country: ///
    stcox postgreendeal amending subnatcompetence coalitionsize technicalcabinet, strata(country) hr

* === 4.5 Random Effects Model (Shared Frailty by Country) ===
eststo polinst_re_country: ///
    stcox postgreendeal amending subnatcompetence coalitionsize technicalcabinet, shared(country) hr


******************************************************
* STEP 4.6. Interaction test: Green Deal × Amending
* ----------------------------------------------------
* Test whether the post–Green Deal slowdown differs between
* new and amending directives by including an interaction term.
******************************************************
eststo polinst_interaction: ///
    stcox i.postgreendeal##i.amending subnatcompetence coalitionsize technicalcabinet, shared(celex) hr


******************************************************
* STEP 5. Visualizing survival and hazard functions
* ----------------------------------------------------
* Generate Kaplan–Meier survival curves and estimated
* hazard rate plots by key covariates:
* - Amending status
* - Post–Green Deal period
******************************************************

* === 5.1 Survival by Amending Status ===
sts graph, by(amending) ///
    title("Survival by Amending vs. Non-Amending Directives") ///
    xtitle("Months since deadline") ///
    ytitle("Probability of not yet being transposed") ///
    legend(order(1 "Non-Amending" 2 "Amending")) ///
    plot1opts(lwidth(medthick) lcolor(midblue)) ///
    plot2opts(lwidth(medthick) lcolor(cranberry)) ///
    name(KM_amending, replace) ///
	xlabel(12 50 100 200 400 600) ///  
	graphregion(color(white)) bgcolor(white)
graph export "$graphs/KM_amending.png", replace width(1200)

sts graph, by(postgreendeal) ///
    title("Survival Before and After the Green Deal (2019)") ///
    xtitle("Months since deadline") ///
    ytitle("Probability of not yet being transposed") ///
    legend(order(1 "Pre–Green Deal" 2 "Post–Green Deal")) ///
    plot1opts(lwidth(medthick) lcolor(midblue)) ///
    plot2opts(lwidth(medthick) lcolor(cranberry)) ///
    name(KM_postgreendeal, replace) ///
    xlabel(12 50 100 200 400 600) ///  
	graphregion(color(white)) bgcolor(white)
graph export "$graphs/KM_postgreendeal.png", replace width(1200)

sts graph, by(subnatcompetence) ///
    title("Survival by Subnational vs. Central Competence") ///
    xtitle("Months since transposition deadline") ///
    ytitle("Probability of not yet being transposed") ///
    legend(order(1 "Central competence" 2 "Subnational competence")) ///
    plot1opts(lwidth(medthick) lcolor(midblue)) ///
    plot2opts(lwidth(medthick) lcolor(cranberry)) ///
    name(KM_subnat, replace) ///
    xlabel(12 50 100 200 400 600) ///
    graphregion(color(white)) bgcolor(white)
graph export "$graphs/KM_subnatcompetence.png", replace width(1200)

log close
