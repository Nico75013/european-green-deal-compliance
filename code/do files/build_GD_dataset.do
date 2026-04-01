****************************************************
*  Clean EU Green Deal Transposition Dataset
*  Author: Nicolò Marchini
*  Purpose: Standardize variable names, convert booleans,
*           add labels, and reorder variables
****************************************************

* Clear memory
clear all

global main "your_path"
global data "$main/Merged Datasets/gd_ds_transposition_for_stata_final.xlsx"
global output "$main/Merged Datasets"

import excel "$data", firstrow clear

****************************************************
* STEP 1. Rename variables to consistent style
* - All lowercase, no underscores, concatenated words
****************************************************
rename CELEX                celex
rename DirectiveName_short  directivename
rename AmendedName_short    amendedname
rename Dateofdocument       docdate
rename Dateofeffect         effectdate
rename Amending             amending
rename CountryCode          countrycode
rename Country              country
rename MeasureTitle_short   measuretitle
rename TranspositionDeadline transpositiondeadline
rename PublicationDate      publicationdate
rename Subjectmatter        subject
rename Compliance_days      compliancedays
rename Compliance_weeks     complianceweeks
rename Compliance_months    compliancemonths
rename Infringement_Procedure infringementprocedure
rename Infringement_Name    infrprocedname
rename PublicationYear      publicationyear
rename MediasalienceMC      mediasaliencemc
rename ClimatearticlesMC    climatearticlesmc
rename TotalarticlesMC      totalarticlesmc
rename year                 year
rename ClimatesalienceGT    climatesaliencegt
rename EconomysalienceGT    economysaliencegt
rename RelativeClimatesalienceRCM rcmclimatesalience
rename Cabinet              cabinetname
rename StartDate            startdate
rename CoalitionSize        coalitionsize
rename TechnicalCabinet     technicalcabinet
rename TotalSeats           totalseats
rename TotalVoteShare       totalvoteshare
rename LeftRight            leftright
rename StateMarket          statemarket
rename LibertyAuthority     libertyauthority
rename EUAntiPro            euantipro
rename EnvironmentProtection environmentprotection
rename NuclearEnergy        nuclearenergy
rename ClimateEnergy        climateenergy
rename Renewables           renewables
rename SustainableDevelopment sustainabledevelopment
rename WelfareState         welfarestate
rename InternationalPeace   internationalpeace
rename eb_wave              ebwave
rename crp_interp           crp
rename cc                   controlcorruption
rename ge                   goveffectiveness
rename pv                   politicalstability
rename rl                   ruleoflaw
rename rq                   regulatoryquality
rename va                   voicaccountability
rename gdp_per_capita      gdppercapita

drop year publicationyear Unnamed4 crp_raw compliancedays complianceweeks iso3 country_x country_y nuclearenergy economysaliencegt totalarticlesmc climatesaliencegt economysaliencegt climatearticlesmc welfarestate internationalpeace

****************************************************
* STEP 2. Convert booleans ("True"/"False") into 0/1
****************************************************
foreach var in amending infringementprocedure technicalcabinet {
    capture confirm string variable `var'
    if !_rc {
        gen `var'_num = .
        replace `var'_num = 1 if lower(trim(`var')) == "true"
        replace `var'_num = 0 if lower(trim(`var')) == "false"
        label variable `var'_num "`var' (1=True, 0=False)"
        drop `var'
        rename `var'_num `var'
    }
}

****************************************************
* STEP 3. Generate dummy for federal and subnational competence
* 1 = regions/Länder have competence for transposition
* 0 = competence is central (state-level)
****************************************************

gen subnatcompetence = 0
replace subnatcompetence = 1 if country=="Austria" | country=="Belgium" 

gen federal = 0
replace federal = 1 if country=="Germany" | country=="Austria" | country=="Belgium"

******************************************************
* STEP 4. Define the date of the European Green Deal
******************************************************
* Official communication of the European Green Deal: 11 December 2019
local greendealdate = mdy(12,11,2019)

******************************************************
* STEP 5. Create a dummy "postgreendeal" for transpositions occurring after the Green Deal
******************************************************
gen postgreendeal = 0
replace postgreendeal = 1 if publicationdate >= `greendealdate'

******************************************************
* STEP 6. Destring renamed variables
******************************************************

foreach var in compliancemonths mediasaliencemc rcmclimatesalience ///
    coalitionsize technicalcabinet totalseats totalvoteshare ///
    leftright statemarket libertyauthority euantipro ///
    renewables environmentprotection climateenergy sustainabledevelopment crp {

    capture confirm numeric variable `var'
    if _rc {
        di as txt "→ Converting `var' from string to numeric..."
        destring `var', replace ignore(" ")
    }
    else {
        di as result "✓ `var' is already numeric, skipped."
    }
}

* Quick check
summarize compliancemonths mediasaliencemc rcmclimatesalience coalitionsize technicalcabinet ///
          totalseats totalvoteshare leftright statemarket libertyauthority ///
          euantipro renewables environmentprotection climateenergy sustainabledevelopment crp
		  
******************************************************
* STEP 7. Fix negative time values for the dependent variable
******************************************************

* Set negative values of compliancemonths to 0
replace compliancemonths = 0 if compliancemonths < 0

****************************************************
* STEP 8. Reorder variables to original logical order
****************************************************
order celex directivename amendedname docdate effectdate amending ///
      countrycode country federal subnatcompetence measuretitle transpositiondeadline ///
      publicationdate subject compliancemonths ///
      postgreendeal infringementprocedure infrprocedname ///
	  cabinetname startdate coalitionsize technicalcabinet totalseats totalvoteshare ///
      leftright statemarket libertyauthority euantipro  ///
      environmentprotection climateenergy renewables sustainabledevelopment ///
	  mediasaliencemc rcmclimatesalience ebwave crp ///
      controlcorruption goveffectiveness politicalstability ruleoflaw regulatoryquality voicaccountability gdppercapita
      
****************************************************
* STEP 9. Add descriptive labels to variables
****************************************************

label variable celex                  "CELEX code of directive"
label variable directivename          "Directive name"
label variable amendedname            "Amended directive name"
label variable docdate                "Date of directive"
label variable effectdate             "Date of effect"
label variable amending               "Amending directive (1=Yes, 0=No)"
label variable countrycode            "ISO country code"
label variable country                "Country name"
label variable federal                "Federal state (1=federal, 0=unitary)"
label variable subnatcompetence       "Subnational competence in transposition (1=subnational, 0=central)"
label variable measuretitle           "National measure title"
label variable transpositiondeadline  "Deadline for transposition"
label variable publicationdate        "Publication date of national measure"
label variable subject                "Subject matter"
label variable compliancemonths       "Compliance time (months, negatives set to 0)"
label variable postgreendeal          "1=Transposition after Green Deal, 0=Before Green Deal"
label variable infringementprocedure  "Infringement procedure opened (1=Yes, 0=No)"
label variable infrprocedname         "Infringement procedure name"
label variable cabinetname            "Cabinet name"
label variable startdate              "Cabinet start date"
label variable coalitionsize          "Coalition size (number of parties)"
label variable technicalcabinet       "Technical cabinet (1=Yes, 0=No)"
label variable totalseats             "Total seats in parliament"
label variable totalvoteshare         "Total vote share of cabinet parties"
label variable leftright              "Government ideology: Left–Right"
label variable statemarket            "Government ideology: State–Market"
label variable libertyauthority       "Government ideology: Liberty–Authority"
label variable euantipro              "Government position on EU (pro/anti)"
label variable environmentprotection  "Government position on Environment"
label variable climateenergy          "Government position on Climate/Energy"
label variable renewables             "Government position on Renewables"
label variable sustainabledevelopment "Government position on Sustainable Development"
label variable mediasaliencemc        "Media salience (Media Cloud)"
label variable rcmclimatesalience     "Relative climate salience (Google Trends & Media)"
label variable ebwave                 "Eurobarometer wave"
label variable crp                    "Comparative responsiveness (interpolated across waves)"
label variable controlcorruption      "Control of Corruption (WGI)"
label variable goveffectiveness       "Government Effectiveness (WGI)"
label variable politicalstability     "Political Stability and Absence of Violence/Terrorism (WGI)"
label variable ruleoflaw              "Rule of Law (WGI)"
label variable regulatoryquality      "Regulatory Quality (WGI)"
label variable voicaccountability     "Voice and Accountability (WGI)"
label variable gdppercapita           "GDP per capita (Eurostat)"


drop CountryCode1 Country1

****************************************************
* STEP 10. Save cleaned dataset
****************************************************

* Display message
display as text ">> Dataset cleaned and ready :-)"

* Save final dataset
save "$output/gd_transposition_ds.dta", replace
