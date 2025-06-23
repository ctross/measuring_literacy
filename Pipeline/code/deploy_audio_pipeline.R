##########################################################################
# Deploy Python pipeline from R
##########################################################################
files_to_read = list.files("audio/trimmed",full.names=TRUE)
files_to_read_short = list.files("audio/trimmed",full.names=FALSE)

files_to_read = files_to_read[which(files_to_read != "audio/trimmed/readme.txt")]
files_to_read_short = files_to_read_short[which(files_to_read_short != "readme.txt")]

# Deploy pipeline from R
for(i in 1:length(files_to_read)){
 system(paste0("python main.py ",files_to_read[i]))
}

