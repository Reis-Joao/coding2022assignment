import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
import matplotlib.pyplot as plt 


managers_raw_data = pd.read_excel("C:/Users/João Reis/Desktop/codingassignment/coding_assignment_joaoreis/footballdata/raw/managers_epl.xlsx")
print(managers_raw_data.head())
print("Number of coaches per nationality:")
print(managers_raw_data.groupby("Nat.").size())

print()
print()

def clubs_coaches(country, file):
    if country in file["Nat."]
        print (file["Name" , "Club"])
    else: 
        print("There were/are no coaches from that country! Try another one!")
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












