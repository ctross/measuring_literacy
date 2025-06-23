##########################################################################
# Process Python output
##########################################################################
files_to_read = list.files("data/ratings",full.names=TRUE)
files_to_read_short = list.files("data/ratings",full.names=FALSE)

files_to_read = files_to_read[which(files_to_read != "data/ratings/readme.txt")]
files_to_read_short = files_to_read_short[which(files_to_read_short != "readme.txt")]

output = matrix(NA, nrow=length(files_to_read), ncol=14)


for(i in 1:length(files_to_read)){
 output[i,] = table_to_vector(files_to_read[i])$Value
}

colnames(output) = table_to_vector(files_to_read[1])$Name


headers = matrix(NA, nrow=length(files_to_read), ncol=2)
colnames(headers) = c("PID", "Prompt")

ftrs2 = sub('\\.txt$', '', files_to_read_short) 
ftrs2 = strsplit(ftrs2, split = "_")

for(i in 1:length(files_to_read)){
headers[i,] = unlist(ftrs2[[i]])
}

res = data.frame(cbind(headers,output))

######################################## Users will need to tweak the lines below if they have more than 2 prompts
res_A = res[which(res$Prompt=="A"),]
res_B = res[which(res$Prompt=="B"),]

colnames(res_A) = c("PID", "Prompt_A", "number_of_syllables_A", "number_of_pauses_A", 
"rate_of_speech_A", "articulation_rate_A", "speaking_duration_A", "original_duration_A", 
"balance_A", "f0_mean_A", "f0_std_A", "f0_median_A", "f0_min_A", "f0_max_A", 
"f0_quantile25_A", "f0_quan75_A")

colnames(res_B) = c("PID", "Prompt_B", "number_of_syllables_B", "number_of_pauses_B", 
"rate_of_speech_B", "articulation_rate_B", "speaking_duration_B", "original_duration_B", 
"balance_B", "f0_mean_B", "f0_std_B", "f0_median_B", "f0_min_B", "f0_max_B", 
"f0_quantile25_B", "f0_quan75_B")

