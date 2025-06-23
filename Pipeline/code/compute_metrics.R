###############################################################################################
# Create AI measures
###############################################################################################
syllables_A = 72
syllables_B = 143

######### Simple Rate data - syllables in prompt divided by time
df$RateA_auto = syllables_A/as.numeric(df$original_duration_A)
df$RateB_auto = syllables_B/as.numeric(df$original_duration_B)

######### True Rate data - syllables in recording divided by time
df$TrueRateA_auto = as.numeric(df$number_of_syllables_A)/as.numeric(df$original_duration_A)
df$TrueRateB_auto = as.numeric(df$number_of_syllables_B)/as.numeric(df$original_duration_B)

######### Speaking Balance
df$BalanceA_auto = as.numeric(df$speaking_duration_A)/as.numeric(df$original_duration_A)
df$BalanceB_auto = as.numeric(df$speaking_duration_B)/as.numeric(df$original_duration_B)

######### Excess of syllables (proxy for repating words, and correcting errors)
bob = (as.numeric(df$number_of_syllables_A)-syllables_A)/syllables_A 
df$ExcessSyllablesA_auto = ifelse(bob > 1, 1, bob)

bob = (as.numeric(df$number_of_syllables_B)-syllables_B)/syllables_B
df$ExcessSyllablesB_auto = ifelse(bob > 1, 1, bob)

######### Pauses per 10 syllables (cap at 10)
bob = 10*(as.numeric(df$number_of_pauses_A)/syllables_A)
df$PausesA_auto = ifelse(bob>10, 10, bob)

bob = 10*(as.numeric(df$number_of_pauses_B)/syllables_B)
df$PausesB_auto = ifelse(bob>10, 10, bob)

