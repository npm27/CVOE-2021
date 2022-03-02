##set up
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

dat = pd.read_csv("vincentiles.csv")

dat['diff'] = dat['Upper'].sub(dat['Lower'])
dat['diff2'] = dat['diff'].div(2)

##set up the initial plot
fig = plt.figure()
fig.set_size_inches(18,30)

fig.subplots_adjust(hspace=.5)

##Make the subplots
ax1 = fig.add_subplot(5, 1, 1)
ax2 = fig.add_subplot(5, 1, 2)
ax3 = fig.add_subplot(5, 1, 3)
ax4 = fig.add_subplot(5, 1, 4)
ax5 = fig.add_subplot(5, 1, 5)

##First subset on trial type
pure = dat[dat['Trial_Type'] == "pure"]
alt_ns = dat[dat['Trial_Type'] == "alt_ns"]
alt_switch = dat[dat['Trial_Type'] == "alt_switch"]
rand_ns = dat[dat['Trial_Type'] == "rand_ns"]
rand_switch = dat[dat['Trial_Type'] == "rand_switch"]

###Start w/ the first plot
##Each plot will have one trial type for each age group
#Pure
pure_ya = pure[pure['Group'] == 'YA']
pure_h = pure[pure['Group'] == 'Healthy']
pure_mci = pure[pure['Group'] == 'MCI']

#YA
x1 = pure_ya.bin.values
y1 = pure_ya.Average.values

ax1.plot(x1, y1, marker = '.', color = 'k', label='Younger')
ax1.errorbar(x1, y1, yerr = (pure_ya['diff2']), fmt='none', c= 'k', capsize=5)

#HEALTHY
x2 = pure_h.bin.values
y2 = pure_h.Average.values

ax1.plot(x2, y2, marker = 's', color = 'navy', label='Healthy')
ax1.errorbar(x2, y2, yerr = (pure_h['diff2']), fmt='none', c= 'navy', capsize=5)

##MCI
x3 = pure_mci.bin.values
y3 = pure_mci.Average.values

ax1.plot(x3, y3, marker = 'v', color = 'dodgerblue', label='MCI')
ax1.errorbar(x3, y3, yerr = (pure_mci['diff2']), fmt='none', c= 'dodgerblue', capsize=5)

##Make the plot spiffy
ax1.set_title('Pure Trials', fontsize = 20, fontweight = 'bold')
ax1.set_ylabel('Mean RT (ms)', fontsize = 18)
ax1.set_xlabel('Vincentile Bin', fontsize = 18)
ax1.tick_params(axis='x', labelsize = 16)
ax1.tick_params(axis='y', labelsize = 16)

ax1.legend()

##Alt-Non-switch
temp_ya = alt_ns[alt_ns['Group'] == 'YA']
temp_h = alt_ns[alt_ns['Group'] == 'Healthy']
temp_mci = alt_ns[alt_ns['Group'] == 'MCI']

#YA
x1 = temp_ya.bin.values
y1 = temp_ya.Average.values

ax2.plot(x1, y1, marker = '.', color = 'k', label='Younger')
ax2.errorbar(x1, y1, yerr = (temp_ya['diff2']), fmt='none', c= 'k', capsize=5)

#HEALTHY
x2 = temp_h.bin.values
y2 = temp_h.Average.values

ax2.plot(x2, y2, marker = 's', color = 'navy', label='Healthy')
ax2.errorbar(x2, y2, yerr = (temp_h['diff2']), fmt='none', c= 'navy', capsize=5)

##MCI
x3 = temp_mci.bin.values
y3 =temp_mci.Average.values

ax2.plot(x3, y3, marker = 'v', color = 'dodgerblue', label='MCI')
ax2.errorbar(x3, y3, yerr = (temp_mci['diff2']), fmt='none', c= 'dodgerblue', capsize=5)

##Make the plot spiffy
ax2.set_title('Alt-Runs Non-Switch Trials', fontsize = 20, fontweight = 'bold')
ax2.set_ylabel('Mean RT (ms)', fontsize = 18)
ax2.set_xlabel('Vincentile Bin', fontsize = 18)
ax2.tick_params(axis='x', labelsize = 16)
ax2.tick_params(axis='y', labelsize = 16)

ax2.legend()

##Rand NS
temp_ya = rand_ns[rand_ns['Group'] == 'YA']
temp_h = rand_ns[rand_ns['Group'] == 'Healthy']
temp_mci = rand_ns[rand_ns['Group'] == 'MCI']

#YA
x1 = temp_ya.bin.values
y1 = temp_ya.Average.values

ax3.plot(x1, y1, marker = '.', color = 'k', label='Younger')
ax3.errorbar(x1, y1, yerr = (temp_ya['diff2']), fmt='none', c= 'k', capsize=5)

#HEALTHY
x2 = temp_h.bin.values
y2 = temp_h.Average.values

ax3.plot(x2, y2, marker = 's', color = 'navy', label='Healthy')
ax3.errorbar(x2, y2, yerr = (temp_h['diff2']), fmt='none', c= 'navy', capsize=5)

##MCI
x3 = temp_mci.bin.values
y3 =temp_mci.Average.values

ax3.plot(x3, y3, marker = 'v', color = 'dodgerblue', label='MCI')
ax3.errorbar(x3, y3, yerr = (temp_mci['diff2']), fmt='none', c= 'dodgerblue', capsize=5)

##Make the plot spiffy
ax3.set_title('Random Non-Switch Trials', fontsize = 20, fontweight = 'bold')
ax3.set_ylabel('Mean RT (ms)', fontsize = 18)
ax3.set_xlabel('Vincentile Bin', fontsize = 18)
ax3.tick_params(axis='x', labelsize = 16)
ax3.tick_params(axis='y', labelsize = 16)

ax3.legend()

##Alt switch
temp_ya = alt_switch[alt_switch['Group'] == 'YA']
temp_h = alt_switch[alt_switch['Group'] == 'Healthy']
temp_mci = alt_switch[alt_switch['Group'] == 'MCI']

#YA
x1 = temp_ya.bin.values
y1 = temp_ya.Average.values

ax4.plot(x1, y1, marker = '.', color = 'k', label='Younger')
ax4.errorbar(x1, y1, yerr = (temp_ya['diff2']), fmt='none', c= 'k', capsize=5)

#HEALTHY
x2 = temp_h.bin.values
y2 = temp_h.Average.values

ax4.plot(x2, y2, marker = 's', color = 'navy', label='Healthy')
ax4.errorbar(x2, y2, yerr = (temp_h['diff2']), fmt='none', c= 'navy', capsize=5)

##MCI
x3 = temp_mci.bin.values
y3 =temp_mci.Average.values

ax4.plot(x3, y3, marker = 'v', color = 'dodgerblue', label='MCI')
ax4.errorbar(x3, y3, yerr = (temp_mci['diff2']), fmt='none', c= 'dodgerblue', capsize=5)

##Make the plot spiffy
ax4.set_title('Alt-Runs Switch Trials', fontsize = 20, fontweight = 'bold')
ax4.set_ylabel('Mean RT (ms)', fontsize = 18)
ax4.set_xlabel('Vincentile Bin', fontsize = 18)
ax4.tick_params(axis='x', labelsize = 16)
ax4.tick_params(axis='y', labelsize = 16)

ax4.legend()

##Rand Switch
temp_ya = rand_switch[rand_switch['Group'] == 'YA']
temp_h = rand_switch[rand_switch['Group'] == 'Healthy']
temp_mci = rand_switch[rand_switch['Group'] == 'MCI']

#YA
x1 = temp_ya.bin.values
y1 = temp_ya.Average.values

ax5.plot(x1, y1, marker = '.', color = 'k', label='Younger')
ax5.errorbar(x1, y1, yerr = (temp_ya['diff2']), fmt='none', c= 'k', capsize=5)

#HEALTHY
x2 = temp_h.bin.values
y2 = temp_h.Average.values

ax5.plot(x2, y2, marker = 's', color = 'navy', label='Healthy')
ax5.errorbar(x2, y2, yerr = (temp_h['diff2']), fmt='none', c= 'navy', capsize=5)

##MCI
x3 = temp_mci.bin.values
y3 =temp_mci.Average.values

ax5.plot(x3, y3, marker = 'v', color = 'dodgerblue', label='MCI')
ax5.errorbar(x3, y3, yerr = (temp_mci['diff2']), fmt='none', c= 'dodgerblue', capsize=5)

##Make the plot spiffy
ax5.set_title('Random Switch Trials', fontsize = 20, fontweight = 'bold')
ax5.set_ylabel('Mean RT (ms)', fontsize = 18)
ax5.set_xlabel('Vincentile Bin', fontsize = 18)
ax5.tick_params(axis='x', labelsize = 16)
ax5.tick_params(axis='y', labelsize = 16)

ax5.legend()

##save
fig.savefig('Overall_Vincentiles.png')