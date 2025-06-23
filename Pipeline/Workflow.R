################################################################# Prepare Workspace
# Set WD
 setwd("C:\\Users\\cody_ross\\Desktop\\Workflow\\Pipeline")
# Set your own path here and at the top of the main.py file as well

# Drop WAV or MP3 of trimmed audio into the audio/trimmed folder. 
# The filenames should be of the form: "X3T_A.wav", where the first code is the person ID code, then an underscore, then the prompt ID code.
# Then run:

# Load R libraries
 source("code/project_support.R")

# Deploy audio pipeline using Python workflow
 source("code/deploy_audio_pipeline.R") # This will process the audios into text files in the data/ratings folder

 source("code/process_audio_pipeline_output.R") # This will read in the text files, and create a data.frame of results
 # This script assumes that the user has two prompts per respodent, and will need slight modification for other study designs.

# Merge the literacy data into an existing database
 d = read.csv("data/individual_level_data.csv") # Any other data you might have for each PID
 df = merge(merge(d, res_A, by="PID", all=TRUE), res_B, by="PID", all=TRUE)

# Append the literacy measures defined in the paper into the df object
# This assumes two prompts, users will also need to edit the syllable counts inside for their own prompts
 source("code/compute_metrics.R")

