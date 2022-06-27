##set up
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

dat = pd.read_csv("Vincentiles Costs 3_2_22.csv")

dat['diff'] = dat['Upper'].sub(dat['Lower'])
dat['diff2'] = dat['diff'].div(2)

##set up the initial plot
fig = plt.figure()
fig.set_size_inches(12,16)

##Make the subplots
ax1 = fig.add_subplot(2, 1, 1)
ax2 = fig.add_subplot(2, 1, 2)

fig.subplots_adjust(hspace=.25)

##might need to subset on trial type
alt_local = dat[dat['Trial Type'] == "Alt_Local"]
alt_global = dat[dat['Trial Type'] == "Alt_Global"]
rand_local = dat[dat['Trial Type'] == "Rand_Local"]
rand_global = dat[dat['Trial Type'] == "Rand_Global"]

##alt local
x2 = alt_local.bin.values
y2 = alt_local.Average.values

ax1.plot(x2, y2, '-', marker = 's', color = 'black', label='Alternating Runs')
ax1.errorbar(x2, y2, yerr = (alt_local['diff2']), fmt='none', c= 'black', capsize=5)

##rand local
x3 = rand_local.bin.values
y3 = rand_local.Average.values

ax1.plot(x3, y3, '--', marker = 's', color = 'black', label='Random')
ax1.errorbar(x3, y3, yerr = (rand_local['diff2']), fmt='none', c= 'black', capsize=5)

##Make the plot spiffy
ax1.set_title('Local Switch Costs', fontsize = 24, fontweight = 'bold')
ax1.set_ylabel('Mean RT (ms)', fontsize = 22, fontweight = 'bold')
ax1.set_xlabel('Vincentile Bin', fontsize = 22, fontweight = 'bold')
ax1.tick_params(axis='x', labelsize = 18)
ax1.tick_params(axis='y', labelsize = 18)

ax1.set_ylim([-75, 300])

ax1.legend(borderaxespad = 1, fontsize = 16, frameon = False)


##alt global
x4 = alt_global.bin.values
y4 = alt_global.Average.values

ax2.plot(x4, y4,  '-', marker = 's', color = 'black', label='Alternating Runs')
ax2.errorbar(x4, y4, yerr = (alt_global['diff2']), fmt='none', c= 'black', capsize=5)

##rand global
x5 = rand_global.bin.values
y5 = rand_global.Average.values

ax2.plot(x5, y5, '--', marker = 's', color = 'black', label='Random')
ax2.errorbar(x5, y5, yerr = (rand_global['diff2']), fmt='none', c= 'black', capsize=5)

##Make the plot spiffy
ax2.set_title('Global Switch Costs', fontsize = 24, fontweight = 'bold')
ax2.set_ylabel('Mean RT (ms)', fontsize = 22, fontweight = 'bold')
ax2.set_xlabel('Vincentile Bin', fontsize = 22, fontweight = 'bold')
ax2.tick_params(axis='x', labelsize = 18)
ax2.tick_params(axis='y', labelsize = 18)

ax2.legend(borderaxespad = 1, fontsize = 16, frameon = False)

fig
#fig.savefig('YA_Vincentiles Costs.png')

##Combined Plot
##set up the initial plot
fig2 = plt.figure()
fig2.set_size_inches(13,9)

ax1 = fig2.add_subplot(1, 1, 1)

##plot the things
#alt local
ax1.plot(x2, y2, '-', marker = 's', color = 'black', label='Alt. Runs Local Costs')
ax1.errorbar(x2, y2, yerr = (alt_local['diff2']), fmt='none', c= 'black', capsize=5)

#rand local
ax1.plot(x3, y3, '--', marker = 's', color = 'black', label='Random Local Costs')
ax1.errorbar(x3, y3, yerr = (rand_local['diff2']), fmt='none', c= 'black', capsize=5)

#alt global
ax1.plot(x4, y4,  '-', marker = 'o', color = 'black', label='Alt. Runs Global Costs')
ax1.errorbar(x4, y4, yerr = (alt_global['diff2']), fmt='none', c= 'black', capsize=5)

#rand global
ax1.plot(x5, y5, '--', marker = 'o', color = 'black', label='Random Global Costs')
ax1.errorbar(x5, y5, yerr = (rand_global['diff2']), fmt='none', c= 'black', capsize=5)

##Make the plot spiffy
ax1.set_title('Switch Costs', fontsize = 24, fontweight = 'bold')
ax1.set_ylabel('Mean RT (ms)', fontsize = 22, fontweight = 'bold')
ax1.set_xlabel('Vincentile Bin', fontsize = 22, fontweight = 'bold')
ax1.tick_params(axis='x', labelsize = 18)
ax1.tick_params(axis='y', labelsize = 18)

ax1.legend(borderaxespad = 1, fontsize = 16, frameon = False)

fig2
fig2.savefig('Vincentiles Costs.png')