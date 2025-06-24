################################################################# Prepare Workspace
# Set WD
 setwd("C:\\Users\\cody_ross\\Desktop\\Workflow\\Replication")

# Load R libraries
 source("code/project_support.R")
 load("data/LiteracyData.RData")

################################################################# Run analyses
# Results in "Descriptive Statistics"
 source("code/descriptive_statistics.R")

# Results in "Human rated metrics"
 source("code/evaluating_human_rated_metrics.R")

# Results in "Human rated metrics"
 source("code/evaluating_AI_rated_metrics.R")
