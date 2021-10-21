####create an answer key####
##setup
dat = read.csv("CVOE 9_22.csv")

pure = subset(dat,
              dat$block_type == "oe" | dat$block_type == "cv")
switch = subset(dat,
                dat$block_type == "alt" | dat$block_type == "shuf")

library(tidyr)
library(magicfor)

for (i in dat$STIM){
  
  num.chars = nchar(i)
  
}

####switch trials####
string1 = as.character(switch$STIM)
  
starts = seq(1, num.chars, by = 2)

##make letter and number columns
switch$letter = substr(string1, 0, 1)
switch$number = substr(string1, 4, 4)

##subset based on cv or oe
switch.cv = subset(switch,
                   switch$CVOE == "CV")
switch.oe = subset(switch,
                   switch$CVOE == "OE")


##denote whether letter is consonant or vowel
list.vowel = c("A", "E", "I", "O", "U")
list.con = c("D", "J", "H", "P", "S")

##denote whether number is odd or even
list.even = c("0", "2", "4", "6", "8")
list.odd = c("1", "3", "5", "7", "9")

##make c or v column for switch.cv
magic_for(print, silent = TRUE)

for (value in switch.cv$letter) {
  
  print(match(value, list.vowel))
  
}

cv = magic_result_as_vector()
switch.cv$c_or_v = cv

##make o or e column for switch.oe
for (value in switch.oe$number) {
  
  print(match(value, list.even))
  
}

oe = magic_result_as_vector()
switch.oe$o_or_e = oe
oe = as.character(oe)

##get rid of the NAs (oe)
switch.oe["o_or_e"][is.na(switch.oe["o_or_e"])] = "o"

##make 1, 2, 3, 4, and 5 into e
switch.oe$o_or_e[switch.oe$o_or_e == "1"] = "e"
switch.oe$o_or_e[switch.oe$o_or_e == "2"] = "e"
switch.oe$o_or_e[switch.oe$o_or_e == "3"] = "e"
switch.oe$o_or_e[switch.oe$o_or_e == "4"] = "e"
switch.oe$o_or_e[switch.oe$o_or_e == "5"] = "e"

table(switch.oe$o_or_e)

##get rid of the NAs (cv)
switch.cv["c_or_v"][is.na(switch.cv["c_or_v"])] = "c"

##make 1, 2, 3, 4, and 5 into V
switch.cv$c_or_v[switch.cv$c_or_v == "1"] = "v"
switch.cv$c_or_v[switch.cv$c_or_v == "2"] = "v"
switch.cv$c_or_v[switch.cv$c_or_v == "3"] = "v"
switch.cv$c_or_v[switch.cv$c_or_v == "4"] = "v"
switch.cv$c_or_v[switch.cv$c_or_v == "5"] = "v"

table(switch.cv$c_or_v)

##convert o e column to o's and e's
switch.oe$response2 = switch.oe$Response
switch.oe$response2 = as.numeric(switch.oe$response2)
switch.oe$response2 = as.character(switch.oe$response2)

switch.oe$response2[switch.oe$response2 == "1"] = "e"
switch.oe$response2[switch.oe$response2 == "2"] = "o"

##make answer key columns for oe
switch.oe$match2 = switch.oe$response2 == switch.oe$o_or_e
switch.oe$score2 = as.numeric(switch.oe$match2)

##convert p q column to c's and v's
switch.cv$response2 = switch.cv$Response
switch.cv$response2 = as.numeric(switch.cv$response2)
switch.cv$response2 = as.character(switch.cv$response2)

switch.cv$response2[switch.cv$response2 == "1"] = "v"
switch.cv$response2[switch.cv$response2 == "2"] = "c"

##make answer key columns for cv
switch.cv$match2 = switch.cv$response2 == switch.cv$c_or_v
switch.cv$score2 = as.numeric(switch.cv$match2)

####pure trials####
##make letter and number columns
string2 = as.character(pure$STIM)

pure$letter = substr(string2, 0, 1)
pure$number = substr(string2, 4, 4)

##subset based on cv or oe
pure.cv = subset(pure,
                   pure$CVOE == "CV")
pure.oe = subset(pure,
                   pure$CVOE == "OE")

##make c or v column for pure.cv
magic_for(print, silent = TRUE)

for (value in pure.cv$letter) {
  
  print(match(value, list.vowel))
  
}

cv2 = magic_result_as_vector()
pure.cv$c_or_v = cv2

##make o or e column for pure.oe
magic_for(print, silent = TRUE)

for (value in pure.oe$number) {
  
  print(match(value, list.even))
  
}

oe2 = magic_result_as_vector()
pure.oe$o_or_e = oe2

##get rid of the NAs (oe)
pure.oe["o_or_e"][is.na(pure.oe["o_or_e"])] = "o"

##make 1, 2, 3, 4, and 5 into e
pure.oe$o_or_e[pure.oe$o_or_e == "1"] = "e"
pure.oe$o_or_e[pure.oe$o_or_e == "2"] = "e"
pure.oe$o_or_e[pure.oe$o_or_e == "3"] = "e"
pure.oe$o_or_e[pure.oe$o_or_e == "4"] = "e"
pure.oe$o_or_e[pure.oe$o_or_e == "5"] = "e"

table(pure.oe$o_or_e)

##get rid of the NAs (cv)
pure.cv["c_or_v"][is.na(pure.cv["c_or_v"])] = "c"

##make 1, 2, 3, 4, and 5 into v
pure.cv$c_or_v[pure.cv$c_or_v == "1"] = "v"
pure.cv$c_or_v[pure.cv$c_or_v == "2"] = "v"
pure.cv$c_or_v[pure.cv$c_or_v == "3"] = "v"
pure.cv$c_or_v[pure.cv$c_or_v == "4"] = "v"
pure.cv$c_or_v[pure.cv$c_or_v == "5"] = "v"

table(pure.cv$c_or_v)

##convert p q column to c's and v's
pure.cv$response2 = pure.cv$Response
pure.cv$response2 = as.numeric(pure.cv$response2)
pure.cv$response2 = as.character(pure.cv$response2)

pure.cv$response2[pure.cv$response2 == "1"] = "v"
pure.cv$response2[pure.cv$response2 == "2"] = "c"

##make answer key columns for cv
pure.cv$match2 = pure.cv$response2 == pure.cv$c_or_v
pure.cv$score2 = as.numeric(pure.cv$match2)

##convert p q column to o's and e's
pure.oe$response2 = pure.oe$Response
pure.oe$response2 = as.numeric(pure.oe$response2)
pure.oe$response2 = as.character(pure.oe$response2)

pure.oe$response2[pure.oe$response2 == "1"] = "e"
pure.oe$response2[pure.oe$response2 == "2"] = "o"

##make answer key columns for oe
pure.oe$match2 = pure.oe$response2 == pure.oe$o_or_e
pure.oe$score2 = as.numeric(pure.oe$match2)

####put everything back together####
##match column names
colnames(pure.cv)[16] = "key2"
colnames(pure.oe)[16] = "key2"
colnames(switch.cv)[16] = "key2"
colnames(switch.oe)[16] = "key2"

final = rbind(pure.cv, pure.oe, switch.cv, switch.oe)

#write.csv(final, file = "scored 9_22.csv")
