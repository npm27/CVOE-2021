####set up####
##load libraries
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

##read in data
dat = pd.read_csv("CVOE data 3_2_22.csv")

#make the 95% confidence intervals
dat['diff'] = dat['Upper'].sub(dat['Lower']) #get the length of the bars
dat['diff2'] = dat['diff'].div(2) #length from end of bar to cap

##split the data into RT and Error groups
error_dat = dat[ dat['TYPE'] == "ERROR"]

error_dat['Average'] = error_dat['Average'].multiply(100) #Disregard the warnings here
error_dat['diff2'] = error_dat['diff2'].multiply(100)

##split into groups bases on condition
error_dat_ya = error_dat[ error_dat["Conditon"] == "Younger"]
error_dat_healthy = error_dat[ error_dat["Conditon"] == "Healthy"]
error_dat_mci = error_dat[ error_dat["Conditon"] == "MCI"]

##now get only the variables needed
error_dat_ya2 = error_dat_ya[ error_dat_ya["VAR"].isin(["PURE", "ALT_SWITCH", "ALT_NS", "RAND_SWITCH", "RAND_NS"])] 
error_dat_healthy2 = error_dat_healthy[ error_dat_healthy["VAR"].isin(["PURE", "ALT_SWITCH", "ALT_NS", "RAND_SWITCH", "RAND_NS"])] 
error_dat_mci2 = error_dat_mci[ error_dat_mci["VAR"].isin(["PURE", "ALT_SWITCH", "ALT_NS", "RAND_SWITCH", "RAND_NS"])] 

##now get averages and conf intervals
##averages
ya_average = error_dat_ya2["Average"]
ya_average2 = ya_average.tolist() #convert to list

healthy_average = error_dat_healthy2["Average"]
healthy_average2 = healthy_average.tolist()

mci_average = error_dat_mci2["Average"]
mci_average2 = mci_average.tolist()

##conf intervals
ya_conf = error_dat_ya2["diff2"]
ya_conf2 = ya_conf.tolist() #convert to list

healthy_conf = error_dat_healthy2["diff2"]
healthy_conf2 = healthy_conf.tolist()

mci_conf = error_dat_mci2["diff2"]
mci_conf2 = mci_conf.tolist()

##set up the plot
error_fig = plt.figure()
error_fig.set_size_inches(18,12)
error_fig.subplots_adjust(hspace=.45)

####First, lets plot errors for pure, nonswitch, and switch trials
bars1 = ya_average2
bars2 = healthy_average2
bars3 = mci_average2

##set bar width
barwidth = 0.20 ##ax1
barwidth2 = 0.25 ##ax2

#set bar position
r1 = np.arange(len(bars1))
r2 = [x + barwidth for x in r1]
r3 = [x + barwidth for x in r2]

##make the sub plots
##ax1 will be pure vs ns vs s
##ax2 will be local vs global
ax1 = error_fig.add_subplot(2, 1, 1)
ax2 = error_fig.add_subplot(2, 1, 2)

##make the plot
rects1 = ax1.bar(r1, bars1, width = barwidth, yerr = ya_conf2, capsize = 3, color = 'silver', edgecolor = 'k',
                label ='Younger Adults')

rects2 = ax1.bar(r2, bars2, width = barwidth, yerr = healthy_conf2, capsize = 3, color = 'dodgerblue', edgecolor = 'k',
                label = 'Healthy Older')

rects3 = ax1.bar(r3, bars3, width = barwidth, yerr = mci_conf2, capsize = 3, color = 'navy', edgecolor = 'k',
                label = 'MCI Older')

##Add labels, legend, and set tick marks
ax1.set_title('Mean Error Rates: Pure, Switch, and Non-Switch Trials', fontsize = 30, fontweight = "bold")
ax1.set_ylabel('Mean % Error', fontsize = 26)
ax1.set_xlabel('Trial Type', fontsize = 26)
ax1.xaxis.labelpad = 7.5
ax1.set_xticks(r2)
ax1.tick_params(axis='x', which = 'major', pad = 2.5) #controls how far labels are from axis
ax1.set_xticklabels(('Pure', 'NS Alt Run', 'NS Rand', 'Switch Alt Run', 'Switch Rand'), fontsize = 23)
box = ax1.get_position()
#ax1.set_position([box.x0, box.y0, box.width * 0.8, box.height])
ax1.legend(borderaxespad = 1, fontsize = 18, frameon = False)
ax1.set_ylim([0,35])
ax1.tick_params(axis='y', labelsize=23)


####Now make the graph for local vs global costs####
##get only the variables that are needed
error_dat_ya3 = error_dat_ya[ error_dat_ya["VAR"].isin(["ALT_GLOBAL", "RAND_GLOBAL", "ALT_LOCAL", "RAND_LOCAL"])] 
error_dat_healthy3 = error_dat_healthy[ error_dat_healthy["VAR"].isin(["ALT_GLOBAL", "RAND_GLOBAL", "ALT_LOCAL", "RAND_LOCAL"])] 
error_dat_mci3 = error_dat_mci[ error_dat_mci["VAR"].isin(["ALT_GLOBAL", "RAND_GLOBAL", "ALT_LOCAL", "RAND_LOCAL"])]

##Now get averages and conf intervals
##averages
ya_average3 = error_dat_ya3["Average"]
ya_average4 = ya_average3.tolist() #convert to list

healthy_average3 = error_dat_healthy3["Average"]
healthy_average4 = healthy_average3.tolist()

mci_average3 = error_dat_mci3["Average"]
mci_average4 = mci_average3.tolist()

##get conf intervals
ya_conf3 = error_dat_ya3["diff2"]
ya_conf4 = ya_conf3.tolist() #convert to list

healthy_conf3 = error_dat_healthy3["diff2"]
healthy_conf4 = healthy_conf3.tolist()

mci_conf3 = error_dat_mci3["diff2"]
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
ax2.set_title('Mean Error Rates: Local and Global Switch Costs', fontsize = 30, fontweight = "bold")
ax2.set_ylabel('Mean % Error', fontsize = 26)
ax2.set_xlabel('Cost Type', fontsize = 26)
ax2.xaxis.labelpad = 7.5
ax2.set_xticks(r5)
ax2.tick_params(axis='x', which = 'major', pad = 2.5) #controls how far labels are from axis
ax2.set_xticklabels(('Global Alt Run', 'Global Rand', 'Local Alt Run', 'Local Rand'), fontsize = 23)
box = ax2.get_position()
#ax2.set_position([box.x0, box.y0, box.width * 0.8, box.height])
ax2.legend(borderaxespad = 1, fontsize = 18, frameon = False)
ax2.set_ylim([-2, 15])
plt.axhline(y = 0, color='k', linestyle='-')
ax2.tick_params(axis='y', labelsize=23)

##save figure
error_fig.savefig('CVOE_mean_errors.png', dip = 10000)
