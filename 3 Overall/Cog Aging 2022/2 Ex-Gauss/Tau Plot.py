####set up####
##load libraries
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

##read in data
dat = pd.read_csv("Tau costs.csv")

#make the 95% confidence intervals
dat['diff'] = dat['Upper'].sub(dat['Lower']) #get the length of the bars
dat['diff2'] = dat['diff'].div(2) #length from end of bar to cap

#dat['Average'] = dat['Average'].multiply(100) #Disregard the warnings here
#dat['diff2'] = dat['diff2'].multiply(100)

##split into groups bases on condition
dat_ya = dat[dat["group"] == "ya"]
dat_healthy = dat[dat["group"] == "Healthy"]
dat_mci = dat[dat["group"] == "MCI"]

##set up the plot
error_fig = plt.figure()
error_fig.set_size_inches(15,8)

####First, lets plot errors for pure, nonswitch, and switch trials

##set bar width
barwidth2 = 0.25 ##ax2

##make the sub plots
##ax1 will be pure vs ns vs s
##ax2 will be local vs global
ax2 = error_fig.add_subplot(1, 1, 1)

##get only the variables that are needed
dat_ya3 = dat_ya[ dat_ya["Trial_Type"].isin(["alt_global", "rand_global", "alt_local", "rand_local"])] 
dat_healthy3 = dat_healthy[ dat_healthy["Trial_Type"].isin(["alt_global", "rand_global", "alt_local", "rand_local"])] 
dat_mci3 = dat_mci[ dat_mci["Trial_Type"].isin(["alt_global", "rand_global", "alt_local", "rand_local"])]

##Now get averages and conf intervals
##averages
ya_average3 = dat_ya3["Average"]
ya_average4 = ya_average3.tolist() #convert to list

healthy_average3 = dat_healthy3["Average"]
healthy_average4 = healthy_average3.tolist()

mci_average3 = dat_mci3["Average"]
mci_average4 = mci_average3.tolist()

##get conf intervals
ya_conf3 = dat_ya3["diff2"]
ya_conf4 = ya_conf3.tolist() #convert to list

healthy_conf3 = dat_healthy3["diff2"]
healthy_conf4 = healthy_conf3.tolist()

mci_conf3 = dat_mci3["diff2"]
mci_conf4 = mci_conf3.tolist()

##make the bars
bars4 = ya_average4
bars5 = healthy_average4
bars6 = mci_average4

#set bar position
r4 = np.arange(len(bars4)) + .5
r5 = [x + barwidth2 for x in r4]
r6 = [x + barwidth2 for x in r5]

##make the plot
rects4 = ax2.bar(r4, bars4, width = barwidth2, yerr = ya_conf4, capsize = 3, color = 'silver', edgecolor = 'k',
                label ='Younger Adults')

rects5 = ax2.bar(r5, bars5, width = barwidth2, yerr = healthy_conf4, capsize = 3, color = 'dodgerblue', edgecolor = 'k',
                label = 'Healthy Older')

rects6 = ax2.bar(r6, bars6, width = barwidth2, yerr = mci_conf4, capsize = 3, color = 'Navy', edgecolor = 'k',
                label = 'MCI Older')

##Add labels, legend, and set tick marks
ax2.set_title('Tau: Local and Global Switch Costs', fontsize = 30, fontweight = "bold")
ax2.set_ylabel('Mean Tau', fontsize = 26)
ax2.set_xlabel('Cost Type', fontsize = 26)
ax2.xaxis.labelpad = 7.5
ax2.set_xticks(r5)
ax2.tick_params(axis='x', which = 'major', pad = 2.5) #controls how far labels are from axis
ax2.set_xticklabels(('Global Alt Run', 'Global Rand', 'Local Alt Run', 'Local Rand'), fontsize = 23)
box = ax2.get_position()
#ax2.set_position([box.x0, box.y0, box.width * 0.8, box.height])
ax2.legend(borderaxespad = 1, fontsize = 18, frameon = False)
#ax2.set_ylim([-2, 15])
plt.axhline(y = 0, color='k', linestyle='-')
ax2.tick_params(axis='y', labelsize=23)

##save figure
error_fig.savefig('Tau_errors.png', dip = 10000)
