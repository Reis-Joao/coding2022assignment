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
save "C:/Users/Reis_Joao/Desktop/codingassignment/coding_assignment_joaoreis/stata_code/data_final.dta", replace
