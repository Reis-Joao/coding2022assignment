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