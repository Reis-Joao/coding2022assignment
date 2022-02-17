* Creating a new directory to save the save the regressions/graphs. IF YOU HAVE ALREADY THE DIRECTORY, DO NOT RUN THIS LINE *
mkdir "C:/Users/Reis_Joao/Desktop/codingassignment/coding_assignment_joaoreis/stata_code/stata_attachments"

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
outreg2 using "C:/Users/Reis_Joao/Desktop/codingassignment/coding_assignment_joaoreis/stata_code/stata_attachments/regression_total_goals_on_total_shots", replace excel dec(5) title("OLS Estimation of Total Goals on Total Shots")

reg total_goals total_shots_on_target, robust
outreg2 using "C:/Users/Reis_Joao/Desktop/codingassignment/coding_assignment_joaoreis/stata_code/stata_attachments/regression_total_goals_on_total_shots_on_target", replace excel dec(5) title("OLS Estimation of Total Goals on Total Shots on Target")

reg total_shots_on_target total_shots, robust
outreg2 using "C:/Users/Reis_Joao/Desktop/codingassignment/coding_assignment_joaoreis/stata_code/stata_attachments/regression_total_shots_on_target_on_total_shots", replace excel dec(5) title("OLS Estimation of Total Shots on Target on Total Shots")

reg total_goals total_shots_on_target total_shots, robust
outreg2 using "C:/Users/Reis_Joao/Desktop/codingassignment/coding_assignment_joaoreis/stata_code/stata_attachments/regression_total_goals_on_total_shots_on_target_and_total_shots", replace excel dec(5) title("OLS Estimation of Total Goals on Total Shots on Target and Total Shots")

gen interaction_term_shots = total_shots * total_shots_on_target

reg total_goals total_shots_on_target total_shots interaction_term_shots, robust
outreg2 using "C:/Users/Reis_Joao/Desktop/codingassignment/coding_assignment_joaoreis/stata_code/stata_attachments/regression_total_goals_on_total_shots_on_target_and_total_shots_int_term", replace excel dec(5) title("OLS Estimation of Total Goals on Total Shots on Target and Total Shots w/ Interaction Term")

scatter total_goals total_shots || lfit total_goals total_shots, title("Relation Between Goals and Shots") xtitle("Total Shots") ytitle("Total Goals") 
graph export "C:/Users/Reis_Joao/Desktop/codingassignment/coding_assignment_joaoreis/stata_code/stata_attachments/scatter_plot_goals_shots.pdf", as(pdf) name("Graph") replace

scatter total_goals total_shots_on_target || lfit total_goals total_shots_on_target, title("Relation Between Goals and Shots on Target") xtitle("Total Shots on Target") ytitle("Total Goals")
graph export "C:/Users/Reis_Joao/Desktop/codingassignment/coding_assignment_joaoreis/stata_code/stata_attachments/scatter_plot_goals_shotsontarget.pdf", as(pdf) name("Graph") replace

scatter total_shots_on_target total_shots || lfit total_shots_on_target total_shots, title("Relation Between Shots on Target and Shots") xtitle("Total Shots") ytitle("Total Shots on Target")
graph export "C:/Users/Reis_Joao/Desktop/codingassignment/coding_assignment_joaoreis/stata_code/stata_attachments/scatter_plot_shots_shotsontarget.pdf", as(pdf) name("Graph") replace

* Saving the data
save "C:/Users/Reis_Joao/Desktop/codingassignment/coding_assignment_joaoreis/stata_code/data_final.dta", replace


