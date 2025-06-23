measuring_literacy
========
Machine-rated measurement of literacy from vocal recordings of reading prompts
 ------

Install:
--------------
First install Python and run the following from command prompt to get Python dependencies:
```{cmd}
pip install soundfile
pip install scipy
pip install pydub
pip install torchaudio

pip install deepfilternet
pip install my-voice-analysis
```

--------------
Then check that you have the R dependencies, install with install.packages() if needed:
```{R}
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
```

Run:
--------------
1) Download this repository as zip.
2) Unzip it.
3) Then paste your WAV or MP3 of trimmed audio into the audio/trimmed folder.
4) Set the path to your local directory in the main.py and workflow.R files.
5) Follow the workflow in the workflow.R file.
