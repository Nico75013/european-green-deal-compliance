****************************************************
*  Clean EU Green Deal Transposition Dataset
*  Author: Nicolò Marchini
*  Purpose: Standardize variable names, convert booleans,
*           add labels, and reorder variables
****************************************************

* Clear memory
clear all

* Import the dataset (adjust path if needed)
import excel ///
    "/Users/nicolomarchini/Documents/Università/Magistrale/Tesi Magistrale/Merged Datasets/gd_ds_transposition_for_stata.xlsx", ///
    firstrow clear
	
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

drop year publicationyear Unnamed4 crp_raw

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
* STEP 3. Generate a dummy for federal countries
****************************************************

gen federal = 0
replace federal = 1 if country=="Germany" | country=="Austria" | country=="Belgium"


****************************************************
* STEP 4. Reorder variables to original logical order
****************************************************
order celex directivename amendedname docdate effectdate amending ///
      countrycode country federal measuretitle transpositiondeadline ///
      publicationdate subject compliancedays complianceweeks compliancemonths ///
      infringementprocedure infrprocedname ///
      mediasaliencemc climatearticlesmc totalarticlesmc ///
      climatesaliencegt economysaliencegt rcmclimatesalience ///
      cabinetname startdate coalitionsize technicalcabinet totalseats totalvoteshare ///
      leftright statemarket libertyauthority euantipro environmentprotection ///
      nuclearenergy climateenergy renewables sustainabledevelopment ///
      welfarestate internationalpeace ebwave crp
	  
****************************************************
* STEP 5. Add descriptive labels to variables
****************************************************

label variable celex                  "CELEX code of directive"
label variable directivename          "Directive name"
label variable amendedname            "Amended directive name"
label variable docdate                "Date of directive"
label variable effectdate             "Date of effect"
label variable amending               "Amending directive (1=Yes, 0=No)"
label variable countrycode            "ISO country code"
label variable country                "Country name"
label variable federal                "Federal state dummy"
label variable measuretitle           "National measure title"
label variable transpositiondeadline  "Deadline for transposition"
label variable publicationdate        "Publication date of national measure"
label variable subject                "Subject matter"
label variable compliancedays         "Compliance time (days)"
label variable complianceweeks        "Compliance time (weeks)"
label variable compliancemonths       "Compliance time (months)"
label variable infringementprocedure  "Infringement procedure opened (1=Yes, 0=No)"
label variable infrprocedname         "Infringement procedure name"
label variable mediasaliencemc        "Media salience (Media Cloud)"
label variable climatearticlesmc      "Climate-related articles (Media Cloud)"
label variable totalarticlesmc        "Total articles (Media Cloud)"
label variable climatesaliencegt      "Climate salience (Google Trends)"
label variable economysaliencegt      "Economy salience (Google Trends)"
label variable rcmclimatesalience     "Relative climate salience (RCM)"
label variable cabinetname            "Cabinet name"
label variable startdate              "Cabinet start date"
label variable coalitionsize          "Coalition size (number of parties)"
label variable technicalcabinet       "Technical cabinet (1=Yes, 0=No)"
label variable totalseats             "Total seats in parliament"
label variable totalvoteshare         "Total vote share of cabinet parties"
label variable leftright              "Government ideology: Left-Right"
label variable statemarket            "Government ideology: State-Market"
label variable libertyauthority       "Government ideology: Liberty-Authority"
label variable euantipro              "Government position on EU (pro/anti)"
label variable environmentprotection  "Government position on Environment"
label variable nuclearenergy          "Government position on Nuclear Energy"
label variable climateenergy          "Government position on Climate/Energy"
label variable renewables             "Government position on Renewables"
label variable sustainabledevelopment "Government position on Sustainable Development"
label variable welfarestate           "Government position on Welfare State"
label variable internationalpeace     "Government position on International Peace"
label variable ebwave                 "Eurobarometer wave"
label variable crp                    "Comparative responsiveness  (forward fill, backward substituted with youngest value)"


save "/Users/nicolomarchini/Documents/Università/Magistrale/Tesi Magistrale/Merged Datasets/gd_transposition_ds_final.dta", replace
