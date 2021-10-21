library(tidyverse)

data <- read.csv("data.csv")

#quantiles
data2 <- data %>% group_by(subject,condition) %>% summarize(one = quantile(rt, probs = .1),two = quantile(rt, probs = .3),three = quantile(rt, probs = .5),four = quantile(rt, probs = .7), five = quantile(rt, probs = .9))

# vincentiles

num_vins <- 5 # how many vincentiles do you want

data3 <- data %>% group_by(subject,condition) %>% mutate(bin = ntile(rt,  num_vins)) %>% group_by(subject,condition,bin) %>% summarize(mean = mean(rt))
