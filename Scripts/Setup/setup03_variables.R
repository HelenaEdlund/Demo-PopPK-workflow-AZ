###################################################
# setup03_variables.R
# 
# Author: 
# Created on: 
# Description: Set variables used throughout workflow
# Dependencies: setup01_rEnvironment.R
###################################################

# ------------------------------------------------------------------
#  Data
# ------------------------------------------------------------------

# The column names etc used below are default from the AZ data standards. 
# That is, it will need to be updated depending on the present data structure   

# -------------------- 
#  Source dataset
# --------------------
sourcedata_filename      <- "azd0000_20190102.csv"
dataspec_filename        <- "dataspec_azd0000_20190102.csv" 
# used by pmxplore::r_data_structure

# delivery_date  <- "deliverydate"
# # or extract from filename it contains deliverydate:
delivery_date  <-
  sourcedata_filename %>% 
  str_extract_all(pattern ="(_).*\\d") %>% 
  str_replace_all(pattern ="_", "") %>% 
  unlist %>% 
  as.numeric

# --------------------
#  DV and lloq
# --------------------
dv_name <- "AZD0000"
dv_unit   <- "ng/mL"
LLOQ      <- 0.15

# --------------------
#  Columns in data (used in dataset checkout and EDA)
# --------------------
# Define variables as they are expected to be based on protocol and data spec
studies  <- c(1,2)    # numeric version 
doses    <- c(200)   # doses 

# Define columns in dataset (and what type)
list_columns <- function(){
  
  study_related <- c("STUDYID", "DOSE", "NMSEQSID")
  
  # Continuous columns (not including covariates)
  numeric <- c('TIME','TAPD','DV',"DAY")
  
  # Character/Categorical columns (not including covariates)
  factors <- c('C','AMT',"ADDL","II",'OCC','MDV','CMT','BLQ','EVID',"COMMENT")
  
  # List of baseline continuous and categorical covariates
  base_cat_cov  <- c("SEXM","RACE")
  base_cont_cov <- c("AGE","BCRCL","BWT")
  
  # This list should contain all columns of your dataset
  cols <- list(study_related = study_related, 
               numeric = numeric, 
               factors = factors, 
               # cat_cov = cat_cov,
               # cont_cov = cont_cov,
               base_cat_cov = base_cat_cov,
               base_cont_cov = base_cont_cov)
  
  all_cols <- unlist(cols, use.names = F)
  
  cols <- c(cols, list(all = all_cols))
  
  cols
}

columns <- list_columns()

# ------------------------------------------------------------------
#  List lables and settings for plots used in EDA
# ------------------------------------------------------------------
# Reoccuring labels
labs_TAPD <- "Time after dose (h)"
labs_TIME <- "Time after first dose (h)"
labs_conc <- paste0(dv_name," concentration (", dv_unit,")")

# Re-occuring x-axis breaks
tapd_breaks <- c(0, 2, 4, 6, 8, seq(from=12, to=200, by=6))




# ------------------------------------------------------------------
#  Save environment 
# ------------------------------------------------------------------
# this will also contain the list of directories since its executed before this script
save.image(file = file.path("Scripts",'Setup',"setup_variables.RData"))
