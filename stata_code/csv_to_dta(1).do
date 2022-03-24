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