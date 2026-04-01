******************************************************
* STEP 1. Define paths
* ----------------------------------------------------
* Define main project directories:
******************************************************
global main "/Users/nicolomarchini/Documents/Universita/Magistrale/Tesi Magistrale"
global data   "$main/Merged Datasets/gd_transposition_ds_v1.3.dta"
global models "$main/Outputs/Models"
global graphs "$main/Outputs/Graphs"
global outputs "$main/Outputs"

local timestamp : display %tdCCYY-NN-DD = daily("`c(current_date)'", "DMY")
log using "$models/SurvivalAnalysis_Mean_per_directive_`timestamp'.smcl", replace

use "$data", clear


******************************************************
* STEP 2. Declare Survival-Time Data
* ----------------------------------------------------
* Define survival structure:
* - Time variable: compliancemonths
* - Failure indicator: event = 1 if transposition occurred
******************************************************
gen event = !missing(publicationdate)
label var event "Transposition occurred (1=Yes, 0=No)"
stset compliancemonths, failure(event)


******************************************************
* STEP 3. Mean Number of National Acts per Directive
* ----------------------------------------------------
* Objective: compute how many national acts each country
* adopts on average to transpose one directive.
******************************************************

* 1. Count how many national acts each country uses for each directive
bysort country celex: gen acts_per_dir = _N

* Keep only one observation per (country, directive)
bysort country celex: keep if _n == 1

* 2. Create a numeric dummy to enable counting
gen one = 1

* 3. Collapse by country: compute mean acts per directive
collapse (mean) mean_acts_per_dir = acts_per_dir ///
         (count) num_directives = one, by(country)

* 4. Label the resulting variables
label var mean_acts_per_dir "Mean number of national acts per directive"
label var num_directives "Number of directives observed"

* 5. Display results
list country mean_acts_per_dir num_directives, noobs sepby(country)

* 6. Export results for documentation
export delimited using "$outputs/Mean_Acts_Per_Country.csv", replace

log close
