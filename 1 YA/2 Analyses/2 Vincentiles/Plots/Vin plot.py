##set up
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

dat = pd.read_csv("vincentiles.csv")

dat['diff'] = dat['Upper'].sub(dat['Lower'])
dat['diff2'] = dat['diff'].div(2)

##set up the initial plot
fig = plt.figure()
fig.set_size_inches(13,9)

##Make the subplots
ax1 = fig.add_subplot(1, 1, 1)

##might need to subset on trial type
pure = dat[dat['Trial_Type'] == "pure"]
alt_ns = dat[dat['Trial_Type'] == "alt_ns"]
alt_switch = dat[dat['Trial_Type'] == "alt_switch"]
rand_ns = dat[dat['Trial_Type'] == "rand_ns"]
rand_switch = dat[dat['Trial_Type'] == "rand_switch"]

##pure
x1 = pure.bin.values
y1 = pure.Average.values

ax1.plot(x1, y1, marker = '.', color = 'k', label='Pure')
ax1.errorbar(x1, y1, yerr = (pure['diff2']), fmt='none', c= 'k', capsize=5)

##Non-switch alt
x2 = alt_ns.bin.values
y2 = alt_ns.Average.values

ax1.plot(x2, y2, marker = 's', color = 'dimgray', label='Alt Non-Switch')
ax1.errorbar(x2, y2, yerr = (alt_ns['diff2']), fmt='none', c= 'dimgray', capsize=5)

##Switch alt
x3 = alt_switch.bin.values
y3 = alt_switch.Average.values

ax1.plot(x3, y3, marker = 's', color = 'darkgray', label='Alt Switch')
ax1.errorbar(x3, y3, yerr = (alt_switch['diff2']), fmt='none', c= 'darkgray', capsize=5)

##rand ns
x4 = rand_ns.bin.values
y4 = rand_ns.Average.values

ax1.plot(x4, y4,  '--', marker = 'v', color = 'dimgray', label='Random Non-Switch')
ax1.errorbar(x4, y4, yerr = (rand_ns['diff2']), fmt='none', c= 'dimgray', capsize=5)

##rand switch
x5 = rand_switch.bin.values
y5 = rand_switch.Average.values

ax1.plot(x5, y5, '--', marker = 'v', color = 'darkgray', label='Random Switch')
ax1.errorbar(x5, y5, yerr = (rand_switch['diff2']), fmt='none', c= 'darkgray', capsize=5)

##Make the plot spiffy
ax1.set_title('Vincentile Bins', fontsize = 20, fontweight = 'bold')
ax1.set_ylabel('Mean RT (ms)', fontsize = 18)
ax1.set_xlabel('Vincentile Bin', fontsize = 18)
ax1.tick_params(axis='x', labelsize = 16)
ax1.tick_params(axis='y', labelsize = 16)

ax1.legend()

fig
#fig.savefig('YA_Vincentiles.png')
