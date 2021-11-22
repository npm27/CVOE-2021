##load libraries
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

##read in data
dat_ya = pd.read_csv("ex_gauss_ya.csv")

#make the 95% confidence intervals
dat_ya['diff'] = dat_ya['Upper'].sub(dat_ya['Lower']) #get the length of the bars
dat_ya['diff2'] = dat_ya['diff'].div(2) #length from end of bar to cap

#split again based on mu, sigma, tau
dat_ya_m = dat_ya[dat_ya["parameter"] == "mu"]
dat_ya_s = dat_ya[dat_ya["parameter"] == "sigma"]
dat_ya_t = dat_ya[dat_ya["parameter"] == "tau"]


###Now get averages and conf intervals
##averages
#ya
dat_ya_m_average = dat_ya_m["Average"]
dat_ya_m_average2 = dat_ya_m_average.tolist() #convert to list

dat_ya_s_average = dat_ya_s["Average"]
dat_ya_s_average2 = dat_ya_s_average.tolist() #convert to list

dat_ya_t_average = dat_ya_t["Average"]
dat_ya_t_average2 = dat_ya_t_average.tolist() #convert to list

##conf intervals
#ya
ya_m_conf = dat_ya_m["diff2"]
ya_m_conf2 = ya_m_conf.tolist() #convert to list

ya_s_conf = dat_ya_s["diff2"]
ya_s_conf2 = ya_s_conf.tolist() #convert to list

ya_t_conf = dat_ya_t["diff2"]
ya_t_conf2 = ya_t_conf.tolist() #convert to list


##set up the plot
error_fig = plt.figure()
error_fig.set_size_inches(12,20)

####FSet up plot####
bars1 = dat_ya_m_average2

bars4 = dat_ya_s_average2

bars7 = dat_ya_t_average2

##set bar width
barwidth = 0.20 ##ax1

#set bar position
r1 = np.arange(len(bars1))
r2 = [x + barwidth for x in r1]
r3 = [x + barwidth for x in r2]

##make the sub plots
ax1 = error_fig.add_subplot(3, 1, 1)
ax2 = error_fig.add_subplot(3, 1, 2)
ax3 = error_fig.add_subplot(3, 1, 3)

####Plot Mu####
##make the plot
rects1 = ax1.bar(r1, bars1, width = barwidth, yerr = ya_m_conf2, capsize = 3, color = 'gray', edgecolor = 'k',
                label ='Younger Adults')

##Add labels, legend, and set tick marks
ax1.set_title('Mu: Pure, Switch, and Non-Switch Trials', fontsize = 18)
ax1.set_ylabel('RT (ms)', fontsize = 16)
ax1.set_xlabel('Trial Type', fontsize = 16)
ax1.xaxis.labelpad = 7.5
ax1.set_xticks(r2)
ax1.tick_params(axis='x', which = 'major', pad = 2.5) #controls how far labels are from axis
ax1.set_xticklabels(('Pure', 'Nonswitch Alt Run', 'Nonswitch Rand', 'Switch Alt Run', 'Switch Rand'), fontsize = 10)
ax1.legend()

####Plot sigma####
##make the plot
rects1 = ax2.bar(r1, bars4, width = barwidth, yerr = ya_s_conf2, capsize = 3, color = 'gray', edgecolor = 'k',
                label ='Younger Adults')

##Add labels, legend, and set tick marks
ax2.set_title('Sigma: Pure, Switch, and Non-Switch Trials', fontsize = 18)
ax2.set_ylabel('RT (ms)', fontsize = 16)
ax2.set_xlabel('Trial Type', fontsize = 16)
ax2.xaxis.labelpad = 7.5
ax2.set_xticks(r2)
ax2.tick_params(axis='x', which = 'major', pad = 2.5) #controls how far labels are from axis
ax2.set_xticklabels(('Pure', 'Nonswitch Alt Run', 'Nonswitch Rand', 'Switch Alt Run', 'Switch Rand'), fontsize = 10)
ax2.legend(loc = "upper left")

##Tau
####Plot Tau####
##make the plot
rects1 = ax3.bar(r1, bars7, width = barwidth, yerr = ya_t_conf2, capsize = 3, color = 'gray', edgecolor = 'k',
                label ='Younger Adults')

##Add labels, legend, and set tick marks
ax3.set_title('Tau: Pure, Switch, and Non-Switch Trials', fontsize = 18)
ax3.set_ylabel('RT (ms)', fontsize = 16)
ax3.set_xlabel('Trial Type', fontsize = 16)
ax3.xaxis.labelpad = 7.5
ax3.set_xticks(r2)
ax3.tick_params(axis='x', which = 'major', pad = 2.5) #controls how far labels are from axis
ax3.set_xticklabels(('Pure', 'Nonswitch Alt Run', 'Nonswitch Rand', 'Switch Alt Run', 'Switch Rand'), fontsize = 10)
ax3.legend()

##save
#error_fig.savefig('Ex_Gauss.pdf', dip = 10000)
