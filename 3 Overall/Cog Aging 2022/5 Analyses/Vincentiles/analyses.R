library(ez)
library(reshape)

costs = read.csv("Vincentiles Costs 3_2_22.csv")
trials = read.csv("Vincentiles 3_2_22.csv")

ezANOVA(trials,
        wid = bin,
        dv = Average,
        between = Group,
        type = 3,
        detailed = T)

ezANOVA(costs,
        wid = bin,
        dv = Average,
        between = Group,
        type = 3,
        detailed = T)
