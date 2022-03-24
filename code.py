import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
import matplotlib.pyplot as plt 
import os

managers_raw_data = pd.read_excel("C:/Users/João Reis/Desktop/codingassignment/coding_assignment_joaoreis/footballdata/raw/managers_epl.xlsx")
print(managers_raw_data.head())
print("Number of coaches per nationality:")
print(managers_raw_data.groupby("Nat.").size())

print()
print()

def clubs_coaches(country, file):
    if country in file["Nat."]:
        print (file["Name" , "Club"])
    else: 
        print("There were/are no coaches from that country! Try another one!")
        clubs_coaches(input("Choose coaches' country of origin: "),managers_raw_data)
clubs_coaches(input("Choose coaches' country of origin: "),managers_raw_data)

print()
print()

epl_2007_raw_data = pd.read_excel("C:/Users/João Reis/Desktop/codingassignment/coding_assignment_joaoreis/footballdata/raw/epl_2007.xlsx")
epl_2007_raw_data.sort_values(by="team_points_season",ascending=False,inplace=True)
epl_2007_raw_data["Final Classification"]=np.arange(1,len(epl_2007_raw_data)+1)
print(epl_2007_raw_data)

print()
print()

X = epl_2007_raw_data['team_goaldiff_season']
Y = epl_2007_raw_data['team_points_season']
X = np.reshape(np.array(X),(-1, 1))
reg = LinearRegression().fit(X,Y)
intercept, slopecoefficient = reg.intercept_, reg.coef_
print("The intercept equals", intercept, ".", "The slope coefficient is equal to", slopecoefficient)
plt.plot(X,Y,"o")
plt.plot(X, intercept + slopecoefficient*X)
plt.xlabel('Team Goal Difference on 2007 Season')
plt.ylabel('Team Points on 2007 Season')
plt.show()

#def adding_clarifications(filepath, file_name):
#    for file_name in os.listdir(filepath):
#        f_data_pl = pd.read_csv(file_name)
#        f_data_pl["Meanings"] = "FTHG : Full time home goals / FTAG : Full time away goals / FTR : Full time Result / HTHG : Half time home goals / HTAG : Half time away goals / HTR : Half time home goals / HS : Home team shots / AS : Away team shots / HST : Home team shots on target / AST : Away team shots on target / HC : Home team corners / AC : Away team corners / HF : Home team Fouls / AF : Away team Fouls / HY : Home team yellow cards / AY : Away team yellow cards / HR : Home team red cards / AR : Away team red cards"
#        print(f_data_pl.head(2))
#adding_clarifications("C:/Users/João Reis/Desktop/codingassignment/coding_assignment_joaoreis/footballdata/raw", "fdata_pl_20**.csv")

f_data_pl = pd.read_csv("C:/Users/João Reis/Desktop/codingassignment/coding_assignment_joaoreis/footballdata/raw/fdata_pl_2008.csv")
print(f_data_pl.head(2))

f_data_pl = pd.read_csv("C:/Users/João Reis/Desktop/codingassignment/coding_assignment_joaoreis/footballdata/raw/fdata_pl_2008.csv")
f_data_pl["Meanings"] = "FTHG : Full time home goals / FTAG : Full time away goals / FTR : Full time Result / HTHG : Half time home goals / HTAG : Half time away goals / HTR : Half time home goals / HS : Home team shots / AS : Away team shots / HST : Home team shots on target / AST : Away team shots on target / HC : Home team corners / AC : Away team corners / HF : Home team Fouls / AF : Away team Fouls / HY : Home team yellow cards / AY : Away team yellow cards / HR : Home team red cards / AR : Away team red cards"
print(f_data_pl.head(2))








