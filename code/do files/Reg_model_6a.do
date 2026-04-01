clear all
set more off

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
log using "$models/SurvivalAnalysis_MedianTimes_`timestamp'.smcl", replace

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
* STEP 3. Prepare temporary results file
* ----------------------------------------------------
* Create a temporary file to store median transposition 
* time by country.
******************************************************
tempfile results
postfile handle str3 countrycode double median_months using `results', replace


******************************************************
* STEP 4. Compute median time to transposition by country
******************************************************
levelsof countrycode, local(countries)

foreach c of local countries {
    preserve
        keep if countrycode == "`c'"
        quietly {
            stset compliancemonths, failure(event)
            capture drop S
            sts gen S = s
            summarize _t if S <= 0.5, meanonly
            local med = r(min)
            if missing(`med') local med = .
        }
        post handle ("`c'") (`med')
    restore
}

postclose handle


******************************************************
* STEP 5. Load and clean results
******************************************************
use `results', clear
replace median_months = round(median_months, 0.1)

******************************************************
* STEP 5bis. Compute EU-wide median (of country medians)
******************************************************
tempvar mednum
gen double `mednum' = median_months
quietly summarize `mednum', detail
local eu_median = r(p50)

set obs `=_N + 1'
replace countrycode = "EU" in L
replace median_months = round(`eu_median', 0.1) in L

******************************************************
* STEP 6. Order countries by median months (ascending)
******************************************************
sort median_months

******************************************************
* STEP 7. Replace missing medians with readable text
******************************************************
tostring median_months, replace force format("%9.1f")
replace median_months = "not reached" if median_months == "."
list countrycode median_months, clean

log close
