library(ez)
library(reshape)
library(splitstackshape)

options(scipen = 999)

ya = read.csv("ya_vincentiles_costs.csv")
mci = read.csv("MCI_costs_analyses.csv")
healthy = read.csv("Healthy_costs_analyses.csv")

#get the healthy in long format
healthy = melt(healthy,
                  id.vars = c("Subject", "bin"))
colnames(healthy)[3:4] = c("type", "mean")

ya$group = rep("ya")
mci$group = rep("mci")
healthy$group = rep("healthy")

combined = rbind(ya, mci, healthy)

combined$bin = as.character(combined$bin)

##Need to split into local and global groups for testing
#group (h, y, mci) x bin (1-6) x type (rand vs local)
combined2 = cSplit(combined, 'type', sep = "_", type.convert = FALSE)

colnames(combined2)[5:6] = c("pres_type", "cost_type")

local = subset(combined2,
               combined2$cost_type == "local")
global = subset(combined2,
                combined2$cost_type == "global")

##ANOVA TIME!
#local costs
ezANOVA(local,
        dv = mean,
        wid = Subject,
        between = group,
        within = .(bin, pres_type),
        detailed = T,
        type = 3)

#global
ezANOVA(global,
        dv = mean,
        wid = Subject,
        between = group,
        within = .(bin, pres_type),
        detailed = T,
        type = 3)

##No three-way interactions!