'''
Author: Madeline Melichar
University of Arizona
Date: November 16, 2021

Using Python and the data file tucson_rain.csv, summarize the total 
raining amount from gauges of good quality readings for each month of 
2019 and 2020 and compare the monthly results (monthly sum and difference 
between the two years). Print the results with a table format. Report the
results (screenshot is acceptable) and Python codes (text format) that 
generate the results.
Bonus: calculate the monthly average, taking account of the missing 
(unreported) zeros of some gauges. 
'''


import pandas as pd


dt = pd.read_csv('tucson_rain.csv', index_col=0)

summary = []

for year in ('2019','2020'):
    for month in range (1,13):
        month_dt = dt[(dt['readingDate'].str.contains(year+'-'+str(month))) & (dt['quality']=='Good')]
        
        total_rain = sum(month_dt['rainAmount'])
        
        if len(month_dt) != 0:
            avg = total_rain/len(month_dt)
        else:
            avg = 0
              
        summary.append([year, month, total_rain, avg, ])

ans = pd.DataFrame(summary,columns=['year', 'month', 'total rain', 'average rain'])

dif19 = []
dif20 = []

for month in range (1,13):
    x,y = ans[ans['month']==month]['average rain'].values
    dif19.append(x-y)
    dif20.append(y-x)
    
dif19.extend(dif20)

ans['Difference'] = dif19

print(ans)
    



