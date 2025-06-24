# Libraries
 library(dplyr)          # for data manipulation
 library(plyr)           # for data manipulation
 library(tidyr)          # for data manipulation
 library(magrittr)       # for easier syntax in one or two areas
 library(gridExtra)      # for generating the bin width comparison plot
 library(ggplot2)        # for generating the visualization
 library(reticulate)     # for Python
 library(xtable)         # for tex outputs
 library(psych)          # for PCA
 library(stargazer)      # for latex output
 library(broom)          # for latex output
 library(MuMIn)          # for data dredging

# Helper function for printing model estimates
 make_res = function(x, y, z){
  res = c(y,z, round(x$coeff[2,c(1,4)],3), round(x$r.squared,3))
   return(res)
 }

# A helper function to clean output file
table_to_vector = function(y){
  x = readLines(y)
  x[3] = gsub("number_ of_syllables", "number_of_syllables", x[3])
  res = strsplit(x, "\\s+")
  res2 = data.frame(Name = NA, Value=NA)
  for(i in 3:16)
  res2[i-2,] = res[[i]]
  return(res2)
}

mix_mean = function(x,y,na.rm=TRUE){
  z = rep(NA, length(x))
    for(i in 1:length(x)){
        z[i] = mean(c(x[i],y[i]),na.rm=na.rm)
    }
  return(z)
}
