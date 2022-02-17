* Creating a new directory to save the raw .csv data as .dta data, so we can append them easily later. IF YOU HAVE ALREADY THE DIRECTORY, DO NOT RUN THIS LINE *
mkdir "C:/Users/Reis_Joao/Desktop/codingassignment/coding_assignment_joaoreis/footballdata/raw_dta"

* Importing the files as .csv and saving them as .dta
forvalues k = 2008(1)2018{
	import delimited C:\Users\Reis_Joao\Desktop\codingassignment\coding_assignment_joaoreis\footballdata\raw\fdata_pl_`k'.csv, clear varnames(1) bindquotes(strict) encoding("utf-8")
	save C:\Users\Reis_Joao\Desktop\codingassignment\coding_assignment_joaoreis\footballdata\raw_dta\fdata_pl_`k'.dta, replace
}

* Saving the data
save "C:/Users/Reis_Joao/Desktop/codingassignment/coding_assignment_joaoreis/stata_code/data_final.dta", replace