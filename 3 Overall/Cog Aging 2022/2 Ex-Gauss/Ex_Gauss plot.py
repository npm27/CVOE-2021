##load libraries
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

##read in data
dat = pd.read_csv("ex_gauss_costs_3_2_22.csv")

#make the 95% confidence intervals
dat['diff'] = dat['Upper'].sub(dat['Lower']) #get the length of the bars
dat['diff2'] = dat['diff'].div(2) #length from end of bar to cap

##split into groups bases on group
dat_ya = dat[dat["group"] == "ya"]
dat_healthy = dat[dat["group"] == "Healthy"]
dat_mci = dat[dat["group"] == "MCI"]

#split again based on mu, sigma, tau
dat_ya_m = dat_ya[dat_ya["parameter"] == "mu"]
dat_ya_s = dat_ya[dat_ya["parameter"] == "sigma"]
dat_ya_t = dat_ya[dat_ya["parameter"] == "tau"]

dat_healthy_m = dat_healthy[dat_healthy["parameter"] == "mu"]
dat_healthy_s = dat_healthy[dat_healthy["parameter"] == "sigma"]
dat_healthy_t = dat_healthy[dat_healthy["parameter"] == "tau"]

dat_mci_m = dat_mci[dat_mci["parameter"] == "mu"]
dat_mci_s = dat_mci[dat_mci["parameter"] == "sigma"]
dat_mci_t = dat_mci[dat_mci["parameter"] == "tau"]

###Now get averages and conf intervals
##averages
#ya
dat_ya_m_average = dat_ya_m["Average"]
dat_ya_m_average2 = dat_ya_m_average.tolist() #convert to list

dat_ya_s_average = dat_ya_s["Average"]
dat_ya_s_average2 = dat_ya_s_average.tolist() #convert to list

dat_ya_t_average = dat_ya_t["Average"]
dat_ya_t_average2 = dat_ya_t_average.tolist() #convert to list

#healthy
dat_healthy_m_average = dat_healthy_m["Average"]
dat_healthy_average_m2 = dat_healthy_m_average.tolist()

dat_healthy_s_average = dat_healthy_s["Average"]
dat_healthy_average_s2 = dat_healthy_s_average.tolist()

dat_healthy_t_average = dat_healthy_t["Average"]
dat_healthy_average_t2 = dat_healthy_t_average.tolist()

#mci
dat_mci_m_average = dat_mci_m["Average"]
dat_mci_average_m2 = dat_mci_m_average.tolist()

dat_mci_s_average = dat_mci_s["Average"]
dat_mci_average_s2 = dat_mci_s_average.tolist()

dat_mci_t_average = dat_mci_t["Average"]
dat_mci_average_t2 = dat_mci_t_average.tolist()

##conf intervals
#ya
ya_m_conf = dat_ya_m["diff2"]
ya_m_conf2 = ya_m_conf.tolist() #convert to list

ya_s_conf = dat_ya_s["diff2"]
ya_s_conf2 = ya_s_conf.tolist() #convert to list

ya_t_conf = dat_ya_t["diff2"]
ya_t_conf2 = ya_t_conf.tolist() #convert to list

#healthy
healthy_m_conf = dat_healthy_m["diff2"]
healthy_m_conf2 = healthy_m_conf.tolist() #convert to list

healthy_s_conf = dat_healthy_s["diff2"]
healthy_s_conf2 = healthy_s_conf.tolist() #convert to list

healthy_t_conf = dat_healthy_t["diff2"]
healthy_t_conf2 = healthy_t_conf.tolist() #convert to list

#mci
mci_m_conf = dat_mci_m["diff2"]
mci_m_conf2 = mci_m_conf.tolist() #convert to list

mci_s_conf = dat_mci_s["diff2"]
mci_s_conf2 = mci_s_conf.tolist() #convert to list

mci_t_conf = dat_mci_t["diff2"]
mci_t_conf2 = mci_t_conf.tolist() #convert to list

##set up the plot
error_fig = plt.figure()
error_fig.set_size_inches(20,18)

error_fig.subplots_adjust(hspace=.40)

####FSet up plot####
bars1 = dat_ya_m_average2
bars2 = dat_healthy_average_m2
bars3 = dat_mci_average_m2

bars4 = dat_ya_s_average2
bars5 = dat_healthy_average_s2
bars6 = dat_mci_average_s2

bars7 = dat_ya_t_average2
bars8 = dat_healthy_average_t2
bars9 = dat_mci_average_t2

##set bar width
barwidth = 0.20 ##ax1

#set bar position
r1 = np.arange(len(bars1))
r2 = [x + barwidth for x in r1]
r3 = [x + barwidth for x in r2]

##make the sub plots
ax1 = error_fig.add_subplot(2, 1, 1)
ax2 = error_fig.add_subplot(2, 1, 2)

####Plot Tau - Local Costs####
##make the plot
rects1 = ax1.bar(r1, bars1, width = barwidth, yerr = ya_t_conf2, capsize = 3, color = 'Silver', edgecolor = 'k',
                label ='Younger Adults')

rects2 = ax1.bar(r2, bars2, width = barwidth, yerr = healthy_t_conf2, capsize = 3, color = 'Dodgerblue', edgecolor = 'k',
                label = 'Healthy Older')

rects3 = ax1.bar(r3, bars3, width = barwidth, yerr = mci_t_conf2, capsize = 3, color = 'Navy', edgecolor = 'k',
                label = 'MCI Older')

##Add labels, legend, and set tick marks
ax1.set_title('Tau: Local Switch Costs', fontsize = 36, fontweight = "bold")
ax1.set_ylabel('RT (ms)', fontsize = 34)
ax1.set_xlabel('Trial Type', fontsize = 34)
ax1.xaxis.labelpad = 7.5
ax1.set_xticks(r2)
ax1.tick_params(axis='x', which = 'major', pad = 2.5) #controls how far labels are from axis
ax1.set_xticklabels(('NS Alt Run', 'NS Rand', 'Switch Alt Run', 'Switch Rand'), fontsize = 24)
ax1.legend()

####Plot sigma####
##make the plot
rects1 = ax2.bar(r1, bars4, width = barwidth, yerr = ya_s_conf2, capsize = 3, color = 'Silver', edgecolor = 'k',
                label ='Younger Adults')

rects2 = ax2.bar(r2, bars5, width = barwidth, yerr = healthy_s_conf2, capsize = 3, color = 'Dodgerblue', edgecolor = 'k',
                label = 'Healthy Older')

rects3 = ax2.bar(r3, bars6, width = barwidth, yerr = mci_s_conf2, capsize = 3, color = 'Navy', edgecolor = 'k',
                label = 'MCI Older')

##Add labels, legend, and set tick marks
ax2.set_title('Tau: Global Switch Costs', fontsize = 26, fontweight = "bold")
ax2.set_ylabel('RT (ms)', fontsize = 20)
ax2.set_xlabel('Trial Type', fontsize = 20)
ax2.xaxis.labelpad = 7.5
ax2.set_xticks(r2)
ax2.tick_params(axis='x', which = 'major', pad = 2.5) #controls how far labels are from axis
ax2.set_xticklabels(('NS Alt Run', 'NS Rand', 'Switch Alt Run', 'Switch Rand'), fontsize = 20)
ax2.legend(loc = "upper left")

##save
error_fig.savefig('Ex_Gauss Tau Costs.png', dip = 10000)
