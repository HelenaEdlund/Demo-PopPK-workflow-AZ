# This script was used to set up the folder directory as well as download initial scripts
# Script should not be executed again

library(NMprojectAZ)
library(pmworkbench)
library(pmxplore)

# 1. Set up project with tidyprojectAZ
make_project(proj_name = "~/Demo-PopPK-workflow-AZ")
# please note: this creates another .Rproj file, which can just be ignored (do not delete). 


# 2. Download templates for population PK workflow
template_download(overwrite = T) # overwrite does not seem to work


# 3. Write source data and dataspec to file
sourcedata <- pkData
# dataspec <- pdDataSpec
write.csv(sourcedata, file = "SourceData/azd0000_20190102.csv", 
          quote = F, row.names = F, na = ".") 
rm(sourcedata) #, dataspec)
