*-------------------------------------------- FIRST PART: Install Packages --------------------------------------------* 

* Install package savesome
ssc describe savesome
ssc install savesome

* Install package isvar
ssc describe isvar
ssc install isvar

* Install package outreg2
ssc describe outreg2
ssc install outreg2

*-------------------------------------------- SECOND PART: Convert data from .csv to .dta --------------------------------------------* 

*Creating a global to the directory*
 global datadir "C:/Users/João Reis/Desktop/codingassignment/coding_assignment_joaoreis"

* Creating a new directory to save the raw .csv data as .dta data, so we can append them easily later*
capture mkdir "${datadir}/footballdata/raw_dta"

* Importing the files as .csv and saving them as .dta
forvalues k = 2008(1)2018{
	import delimited "${datadir}\footballdata\raw\fdata_pl_`k'.csv", clear varnames(1) bindquotes(strict) encoding("utf-8")
	save "${datadir}\footballdata\raw_dta\fdata_pl_`k'.dta", replace
}

* Saving the data
save "${datadir}/stata_code/data_final.dta", replace


*-------------------------------------------- THIRD PART: Merging different datasets --------------------------------------------* 

*Importing the data
use "${datadir}/footballdata/raw_dta/fdata_pl_2008.dta", clear

*Generating a variable to append the documents
generate season = 2008

*Appending all the data from 2008 to 2018 into one document
forvalues k = 2009(1)2018{
	append using "${datadir}\footballdata\raw_dta\fdata_pl_`k'.dta"
	replace season = `k' if missing(season)
}

* Saving the data
save "${datadir}/stata_code/data_final.dta", replace


*-------------------------------------------- FOURTH PART: Cleaning the data --------------------------------------------* 

* Using a macro list function to keep only the variables from the list. I am keeping only the meaningful variables for the analysis in order to reduce the data size and become smoother and easier to work with
local keep date hometeam awayteam fthg ftag ftr hthg htag htr referee hs as hst ast hf af hc ac hy ay hr ar season

*Optional: just to confirm the dataset before dropping variables
ds

local vars `r(varlist)'

local tokeep : list vars & keep

display "`tokeep'"

keep `tokeep'

*Optional: just to confirm the variables were dropped/ketp
ds

* Extracting the day and store it as a float
gen day = real(substr(date, 1, 2))

* Extracting the month and store it as a float
gen month = real(substr(date, 4, 2))

* Keep the observations of the called "Boxing Day" - Games on 26 December
drop if day != 26 | month != 12

* Saving the data
save "${datadir}/stata_code/data_final.dta", replace


*-------------------------------------------- FIFTH PART: Work with the data --------------------------------------------* 

* Creating a new directory to save the save the regressions/graphs*
capture mkdir "${datadir}/stata_code/stata_attachments"

* Creating a variable of total goals scored on the matches
gen total_goals = fthg + ftag

* Creating the variable result as float so we can regress it later 
gen result = 0 if htr == "D"
replace result = 1 if htr == "H"
replace result = 2 if htr == "A"

* Labeling the values of the new variable result so we can easily identify their meaning
label define result_label 0 "Draw" 1 "Home Team Win" 2 "Away Team Win"
label values result result_label

* Observation of the relation between the goals scored and the final result
tab result total_goals

* Generate two variables: total shots and total shots on target
gen total_shots = hs + as
gen total_shots_on_target = hst + ast

* Observing the three variables: total goals, total shots and total shots on target
tab total_goals
tab total_shots
tab total_shots_on_target
sum total_goals, detail
sum total_shots, detail
sum total_shots_on_target, detail

* Some regressions and graphs on the relation between the goals, the shots and the shots on target
reg total_goals total_shots, robust
outreg2 using "${datadir}/stata_code/stata_attachments/regression_total_goals_on_total_shots", replace excel dec(5) title("OLS Estimation of Total Goals on Total Shots")

reg total_goals total_shots_on_target, robust
outreg2 using "${datadir}/stata_code/stata_attachments/regression_total_goals_on_total_shots_on_target", replace excel dec(5) title("OLS Estimation of Total Goals on Total Shots on Target")

reg total_shots_on_target total_shots, robust
outreg2 using "${datadir}/stata_code/stata_attachments/regression_total_shots_on_target_on_total_shots", replace excel dec(5) title("OLS Estimation of Total Shots on Target on Total Shots")

reg total_goals total_shots_on_target total_shots, robust
outreg2 using "${datadir}/stata_code/stata_attachments/regression_total_goals_on_total_shots_on_target_and_total_shots", replace excel dec(5) title("OLS Estimation of Total Goals on Total Shots on Target and Total Shots")

gen interaction_term_shots = total_shots * total_shots_on_target

reg total_goals total_shots_on_target total_shots interaction_term_shots, robust
outreg2 using "${datadir}/stata_code/stata_attachments/regression_total_goals_on_total_shots_on_target_and_total_shots_int_term", replace excel dec(5) title("OLS Estimation of Total Goals on Total Shots on Target and Total Shots w/ Interaction Term")

scatter total_goals total_shots || lfit total_goals total_shots, title("Relation Between Goals and Shots") xtitle("Total Shots") ytitle("Total Goals") 
graph export "${datadir}/stata_code/stata_attachments/scatter_plot_goals_shots.pdf", as(pdf) name("Graph") replace

scatter total_goals total_shots_on_target || lfit total_goals total_shots_on_target, title("Relation Between Goals and Shots on Target") xtitle("Total Shots on Target") ytitle("Total Goals")
graph export "${datadir}/stata_code/stata_attachments/scatter_plot_goals_shotsontarget.pdf", as(pdf) name("Graph") replace

scatter total_shots_on_target total_shots || lfit total_shots_on_target total_shots, title("Relation Between Shots on Target and Shots") xtitle("Total Shots") ytitle("Total Shots on Target")
graph export "${datadir}/stata_code/stata_attachments/scatter_plot_shots_shotsontarget.pdf", as(pdf) name("Graph") replace

* Saving the data
save "${datadir}/stata_code/data_final.dta", replace



