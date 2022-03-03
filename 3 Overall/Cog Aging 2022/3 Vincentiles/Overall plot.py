##set up
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

dat = pd.read_csv("vincentiles Costs 3_2_22.csv")

dat['diff'] = dat['Upper'].sub(dat['Lower'])
dat['diff2'] = dat['diff'].div(2)

##set up the initial plot
fig = plt.figure()
fig.set_size_inches(25,15)

fig.subplots_adjust(hspace=.40)

##Make the subplots
ax1 = fig.add_subplot(2, 2, 1)
ax2 = fig.add_subplot(2, 2, 2)
ax3 = fig.add_subplot(2, 2, 3)
ax4 = fig.add_subplot(2, 2, 4)


##First subset on trial type
alt_G = dat[dat['Trial Type'] == "Alt_Global"]
alt_L = dat[dat['Trial Type'] == "Alt_Local"]
rand_G = dat[dat['Trial Type'] == "Rand_Global"]
rand_L = dat[dat['Trial Type'] == "Rand_Local"]

###Start w/ the first plot
##Each plot will have one trial type for each age group
#Pure

##Alt-Local
temp_ya = alt_L[alt_L['Group'] == 'YA']
temp_h = alt_L[alt_L['Group'] == 'Healthy']
temp_mci = alt_L[alt_L['Group'] == 'MCI']

#YA
x1 = temp_ya.bin.values
y1 = temp_ya.Average.values

ax1.plot(x1, y1, marker = '.', color = 'k', label='Younger Adults')
ax1.errorbar(x1, y1, yerr = (temp_ya['diff2']), fmt='none', c= 'k', capsize=5)

#HEALTHY
x2 = temp_h.bin.values
y2 = temp_h.Average.values

ax1.plot(x2, y2, marker = 's', color = 'dodgerblue', label='Healthy Older')
ax1.errorbar(x2, y2, yerr = (temp_h['diff2']), fmt='none', c= 'dodgerblue', capsize=5)

##MCI
x3 = temp_mci.bin.values
y3 = temp_mci.Average.values

ax1.plot(x3, y3, marker = 'v', color = 'navy', label='MCI Older')
ax1.errorbar(x3, y3, yerr = (temp_mci['diff2']), fmt='none', c= 'navy', capsize=5)

##Make the plot spiffy
ax1.set_title('Alternating Runs', fontsize = 34, fontweight = 'bold')
ax1.set_ylabel('Mean RT (ms)', fontsize = 28)
ax1.set_xlabel('Vincentile Bin', fontsize = 28)
ax1.tick_params(axis='x', labelsize = 28)
ax1.tick_params(axis='y', labelsize = 28)

#ax1.set_ylim([0, 2500])
ax1.legend(borderaxespad = 1, fontsize = 18, frameon = False)

##Random Local
temp_ya = rand_L[rand_L['Group'] == 'YA']
temp_h = rand_L[rand_L['Group'] == 'Healthy']
temp_mci = rand_L[rand_L['Group'] == 'MCI']

#YA
x1 = temp_ya.bin.values
y1 = temp_ya.Average.values

ax2.plot(x1, y1, marker = '.', color = 'k', label='Younger Adults')
ax2.errorbar(x1, y1, yerr = (temp_ya['diff2']), fmt='none', c= 'k', capsize=5)

#HEALTHY
x2 = temp_h.bin.values
y2 = temp_h.Average.values

ax2.plot(x2, y2, marker = 's', color = 'dodgerblue', label='Healthy Older')
ax2.errorbar(x2, y2, yerr = (temp_h['diff2']), fmt='none', c= 'dodgerblue', capsize=5)

##MCI
x3 = temp_mci.bin.values
y3 =temp_mci.Average.values

ax2.plot(x3, y3, marker = 'v', color = 'navy', label='MCI Older')
ax2.errorbar(x3, y3, yerr = (temp_mci['diff2']), fmt='none', c= 'navy', capsize=5)

##Make the plot spiffy
ax2.set_title('Random', fontsize = 34, fontweight = 'bold')
#ax2.set_ylabel('Mean RT (ms)', fontsize = 28)
ax2.set_xlabel('Vincentile Bin', fontsize = 28)
ax2.tick_params(axis='x', labelsize = 28)
ax2.tick_params(axis='y', labelsize = 28)

ax2.set_ylim([-50, 400])
ax2.legend(borderaxespad = 1, fontsize = 18, frameon = False)

##Alt Global
temp_ya = alt_G[alt_G['Group'] == 'YA']
temp_h = alt_G[alt_G['Group'] == 'Healthy']
temp_mci = alt_G[alt_G['Group'] == 'MCI']

#YA
x1 = temp_ya.bin.values
y1 = temp_ya.Average.values

ax3.plot(x1, y1, marker = '.', color = 'k', label='Younger Adults')
ax3.errorbar(x1, y1, yerr = (temp_ya['diff2']), fmt='none', c= 'k', capsize=5)

#HEALTHY
x2 = temp_h.bin.values
y2 = temp_h.Average.values

ax3.plot(x2, y2, marker = 's', color = 'dodgerblue', label='Healthy Older')
ax3.errorbar(x2, y2, yerr = (temp_h['diff2']), fmt='none', c= 'dodgerblue', capsize=5)

##MCI
x3 = temp_mci.bin.values
y3 =temp_mci.Average.values

ax3.plot(x3, y3, marker = 'v', color = 'navy', label='MCI Older')
ax3.errorbar(x3, y3, yerr = (temp_mci['diff2']), fmt='none', c= 'navy', capsize=5)

##Make the plot spiffy
ax3.set_title('Alternating Runs', fontsize = 34, fontweight = 'bold')
ax3.set_ylabel('Mean RT (ms)', fontsize = 28)
ax3.set_xlabel('Vincentile Bin', fontsize = 28)
ax3.tick_params(axis='x', labelsize = 28)
ax3.tick_params(axis='y', labelsize = 28)

ax3.set_ylim([0, 2500])
ax3.legend(borderaxespad = 1, fontsize = 18, frameon = False)

##Rand GLOBAL
temp_ya = rand_G[rand_G['Group'] == 'YA']
temp_h = rand_G[rand_G['Group'] == 'Healthy']
temp_mci = rand_G[rand_G['Group'] == 'MCI']

#YA
x1 = temp_ya.bin.values
y1 = temp_ya.Average.values

ax4.plot(x1, y1, marker = '.', color = 'k', label='Younger Adults')
ax4.errorbar(x1, y1, yerr = (temp_ya['diff2']), fmt='none', c= 'k', capsize=5)

#HEALTHY
x2 = temp_h.bin.values
y2 = temp_h.Average.values

ax4.plot(x2, y2, marker = 's', color = 'dodgerblue', label='Healthy Older')
ax4.errorbar(x2, y2, yerr = (temp_h['diff2']), fmt='none', c= 'dodgerblue', capsize=5)

##MCI
x3 = temp_mci.bin.values
y3 =temp_mci.Average.values

ax4.plot(x3, y3, marker = 'v', color = 'navy', label='MCI Older')
ax4.errorbar(x3, y3, yerr = (temp_mci['diff2']), fmt='none', c= 'navy', capsize=5)

##Make the plot spiffy
ax4.set_title('Random', fontsize = 34, fontweight = 'bold')
#ax4.set_ylabel('Mean RT (ms)', fontsize = 28)
ax4.set_xlabel('Vincentile Bin', fontsize = 28)
ax4.tick_params(axis='x', labelsize = 28)
ax4.tick_params(axis='y', labelsize = 28)

ax4.set_ylim([0, 2300])
ax4.legend(borderaxespad = 1, fontsize = 18, frameon = False)

#fig.legend()

##save
fig.savefig('Vincentile Costs.png')