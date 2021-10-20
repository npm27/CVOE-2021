##set up
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

dat = pd.read_csv("vincentiles.csv")

dat['diff'] = dat['Upper'].sub(dat['Lower'])
dat['diff2'] = dat['diff'].div(2)

##set up the initial plot
fig = plt.figure()
fig.set_size_inches(11,8)

major_ticks = np.arange(0, 101, 20)

fig.text(0.5, 0.04, 'Bin', ha = 'center', fontsize=18)
fig.text(0.04, 0.5, 'RT', va = 'center', rotation='vertical', fontsize=18)

##might need to subset on trial type
pure = dat[dat['Trial_Type'] == "pure"]
alt_ns = dat[dat['Trial_Type'] == "alt_ns"]
alt_switch = dat[dat['Trial_Type'] == "alt_switch"]
rand_ns = dat[dat['Trial_Type'] == "rand_ns"]
rand_switch = dat[dat['Trial_Type'] == "rand_switch"]

##pure
x1 = pure.bin.values
y1 = pure.Average.values

fig.plot(x1, y1, marker = '.', color = 'k')

fig.set_xticks(major_ticks)
fig.set_yticks(major_ticks)


fig.errorbar(x1, y1, yerr = (pure['diff2']), fmt='none', c= 'k', capsize=5)

##backward
x2 = datB.JOL_Bin.values
y2 = datB.Average.values

ax2.plot(dot_line, 'k--')
ax2.plot(x2, y2, marker = '.', color = 'k')

ax2.set_xticks(major_ticks)
ax2.set_yticks(major_ticks)

ax2.set_title("Backward", fontsize = 16)

ax2.errorbar(x2, y2, yerr=(datB['diff2']), fmt='none', c= 'k', capsize=5)

##symmetrical
x3 = datS.JOL_Bin.values
y3 = datS.Average.values

ax3.plot(dot_line, 'k--')
ax3.plot(x3, y3, marker = '.', color = 'k')

ax3.set_xticks(major_ticks)
ax3.set_yticks(major_ticks)

ax3.set_title("Symmetrical", fontsize = 16)

ax3.errorbar(x3, y3, yerr=(datS['diff2']), fmt='none', c= 'k', capsize=5)

##unrelated
x4 = datU.JOL_Bin.values
y4 = datU.Average.values

ax4.plot(dot_line, 'k--')
ax4.plot(x4, y4, marker = '.', color = 'k')

ax4.set_xticks(major_ticks)
ax4.set_yticks(major_ticks)

ax4.set_title("Unrelated", fontsize = 16)

ax4.errorbar(x4, y4, yerr=(datU['diff2']), fmt='none', c= 'k', capsize=5)

fig.suptitle('Item-Specific Group', fontsize=20)

##save figure
fig
fig.savefig('Ex1_IS_smoothed2.png')
