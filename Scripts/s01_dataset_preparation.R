###################################################
# s01_dataset_preparation.R
# 
# Author: Helena Edlund
# Created on: 2019-01-03
# Description: Dataset preparation
# Dependencies: All scripts in Setup 
###################################################

# -----------------------------------------------
# Prepare environment
# -----------------------------------------------
library(pmworkbench)
source_dir("./Scripts/Setup")
source_dir("./Scripts/Functions")


# -----------------------------------------------
# Read in dataset
# -----------------------------------------------
# Data should b eplaced in the SourceData dir and not modified
rawdata <- read.csv(file=file.path(all_dir[["source_data_dir"]], sourcedata_filename),
                    stringsAsFactors=F, na.strings = c(".", "NA", "-99"))

# remove C=C  (original data still in "rawdata")
data <- rawdata %>% filter(is.na(C) | C !="C")


# -----------------------------------------------
# Write function for addition of flags and additional 
#   variables for plotting and subsetting
# -----------------------------------------------
add_variables <- function(dataset){
  # 1. REGIMEN FLAG
  dataset$REGIMEN <- paste(as.character(dataset$DOSE), " mg")
  dataset$REGIMEN <- factor(dataset$REGIMEN)
  
  # 2. Does flag: Single/first dose vs multiple dose (Day 1 vs 15)
  dataset$DOSEFLAG <- rep(NA, nrow(dataset))
  
  dataset$DOSEFLAG[!is.na(dataset$OCC) & dataset$OCC==1] <- "Day 1"
  dataset$DOSEFLAG[!is.na(dataset$OCC) & dataset$OCC==2] <- "Day 15"
  dataset$DOSEFLAG <- factor(dataset$DOSEFLAG, levels = c("Day 1", "Day 15"))
  
  return(dataset)
}

# -----------------------------------------------
# Set the structure and add variables
# -----------------------------------------------
data  <- 
  r_data_structure(data,
                   data_spec = file.path(all_dir[["source_data_dir"]], dataspec_filename))
# str(data)
data  <- add_variables(data)




# ------------------------------------------------------------------
#  Subsetting of data for graphical visualisation 
#  (used in EDA. Subsets saved as lists to work better with ggplot)
# ------------------------------------------------------------------
# 1: Baseline data for covariate evaluation 
# (this selects the first row of each ID, may need to be adjusted depending on dataset)
baseline_data <- data %>% 
  filter(!duplicated(NMSEQSID))

# 2: Subsets of concentration data
# 2.1 Exclude missing samples and dose events
conc_data <- data %>% 
  filter(EVID==0) %>% 
  filter(!(MDV==1 & is.na(BLQ))) %>% 
  # Plot LLOQ values in figures as DV=LLOQ/2
  mutate(DV = ifelse(BLQ == "BLQ", LLOQ/2, DV))   

# 2.2 dataset without BLQ samples
conc_data_noBLQ <- conc_data %>% 
  filter(BLQ=="Non-BLQ")

# 2.3 List of subsets to generate pages with 12 individuals per page
conc_data_id_splits <- 
  ind_data_split(conc_data, id="NMSEQSID", 
                 n_per_page = 12)

# 2.4 List of subset by study 
conc_data <- conc_data %>% 
  mutate(STUDYSPLIT = paste0("Study: ", STUDYID), 
         STUDYSPLIT = factor(STUDYSPLIT,
                             levels = c("Study: 1", "Study: 2")))

conc_data_study_split <- 
  split(conc_data, conc_data$STUDYSPLIT)




# -----------------------------------------------
# Save environment to use in next scripts
# -----------------------------------------------
save.image(file = file.path(all_dir[["scripts_dir"]], "s01.RData"))

