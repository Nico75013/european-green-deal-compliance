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

use "$data", clear

* --- 1. Create temporary year variable (not saved in dataset) ---
tempvar year
gen `year' = year(publicationdate)

* --- 2. Keep only relevant variables ---
keep country `year' goveffectiveness politicalstability
drop if missing(goveffectiveness)

* --- 3. Collapse to country-year means (if multiple transpositions per year) ---
collapse (mean) goveffectiveness politicalstability, by(country `year')

* --- 4. Sort and display preview ---
sort country `year'
list country `year' goveffectiveness politicalstability, sepby(country)

collapse (mean) goveffectiveness politicalstability, by(country)

sort country
list country goveffectiveness politicalstability, sepby(country)
