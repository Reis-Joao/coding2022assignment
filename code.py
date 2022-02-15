from itertools import count
import pandas as pd
import numpy as np
import os
import ctypes
from sklearn.linear_model import LinearRegression
import matplotlib.pyplot as plt 


def only_data_files(filepath):
    for filename in os.listdir(filepath):
        if filename[-4:]==".csv" or filename[-5:]==".xlsx":
            print(filename)
        else:
            try:
                ctypes.windll.user32.MessageBoxW(0, "You have an unnecessary file in the folder: "+filename, "Warning", 0)
            except:
                continue
only_data_files("C:/Users/João Reis/Desktop/codingassignment/coding_assignment_joaoreis/footballdata/raw")

managers_raw_data = pd.read_excel("C:/Users/João Reis/Desktop/codingassignment/coding_assignment_joaoreis/footballdata/raw/managers_epl.xlsx")
print(managers_raw_data.head())
print(managers_raw_data.groupby("Nat.").size())

epl_2007_raw_data = pd.read_excel("C:/Users/João Reis/Desktop/codingassignment/coding_assignment_joaoreis/footballdata/raw/epl_2007.xlsx")
epl_2007_raw_data.sort_values(by="team_points_season",ascending=False,inplace=True)
epl_2007_raw_data["Final Classification"]=np.arange(1,len(epl_2007_raw_data)+1)
print(epl_2007_raw_data)

X = epl_2007_raw_data['team_goaldiff_season']
Y = epl_2007_raw_data['team_points_season']
X = np.reshape(np.array(X),(-1, 1))
reg = LinearRegression().fit(X,Y)
intercept, coefficients = reg.intercept_, reg.coef_
print(intercept, coefficients)
plt.plot(X,Y,"o")
plt.plot(X, intercept + coefficients*X)
plt.xlabel('Team Goal Difference on 2007 Season')
plt.ylabel('Team Points on 2007 Season')
plt.show()












