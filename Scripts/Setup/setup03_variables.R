###################################################
# setup03_variables.R
# 
# Author: 
# Created on: 
# Description: Set variables used throughout workflow
# Dependencies: setup01_rEnvironment.R
###################################################

# ------------------------------------------------------------------
#  Directories
# ------------------------------------------------------------------
# This function is kept here to make it easy to add/remove. 
# Pre-defined folder structure is the default for the AZ knowledge management
# Its kept in a function formate not to crowd gloabl environment with all dir names separately

list_directories <- function(make = F){
  # Directories at activity level: 
  # do not remove the leading ".", it will cause problems with latex/knitr)
  scripts_dir       <- file.path(".", "Scripts")
  derived_data_dir  <- file.path(".", "DerivedData")
  model_dir         <- file.path(".", "Models")
  report_dir        <- file.path(".", "Report")
  results_dir       <- file.path(".", "Results")
  sim_dir           <- file.path(".", "Simulations")
  source_data_dir   <- file.path(".", "SourceData")
  
  ##sub-directories
  #script_dir
  setup_dir         <- file.path(scripts_dir, "Setup")
  functions_dir     <- file.path(scripts_dir, "Functions")
  
  #model_dir
  base_model_dir      <- file.path(model_dir, "BaseModel")
  covariate_model_dir <- file.path(model_dir, "CovariateModel")
  
  #result_dir
  res_other_dir       <- file.path(results_dir, "Other")
  res_eda_dir         <- file.path(results_dir, "ExploratoryDataAnalysis")
  res_base_model_dir  <- file.path(results_dir, "BaseModel")
  res_cov_model_dir   <- file.path(results_dir, "CovariateModel")
  
  # #report_dir - to be incoporated
  # rep_setup_dir <- file.path(report_dir, "Setup")
  # rep_sections_dir <- file.path(report_dir, "sections")
  # rep_appendicies_dir <- file.path(report_dir, "appendices")
  # rep_images_dir <- file.path(report_dir, "images")
  
  ##list_all_directories
  all_dir <-
    list(
      scripts_dir = scripts_dir,
      derived_data_dir = derived_data_dir,
      model_dir = model_dir,
      report_dir = report_dir,
      results_dir = results_dir,
      sim_dir = sim_dir,
      source_data_dir = source_data_dir,
      setup_dir = setup_dir,
      functions_dir = functions_dir,
      base_model_dir = base_model_dir,
      covariate_model_dir = covariate_model_dir,
      res_other_dir = res_other_dir,
      res_eda_dir = res_eda_dir,
      res_base_model_dir = res_base_model_dir,
      res_cov_model_dir = res_cov_model_dir #,
      #rep_setup_dir = rep_setup_dir,
      #rep_sections_dir = rep_sections_dir,
      #rep_appendicies_dir = rep_appendicies_dir,
      #rep_images_dir = rep_images_dir
    )
  
  if(make){
    # make directories not already created 
    lapply(all_dir, pmworkbench::mkdirp)
  }
  
  # return list of all directories
  return(all_dir)
} 

all_dir <- list_directories()





# ------------------------------------------------------------------
#  Data
# ------------------------------------------------------------------

# The column names etc used below are default from the AZ data standards. 
# That is, it will need to be updated depending on the present data structure   

# -------------------- 
#  Source dataset
# --------------------
sourcedata_filename      <- "azd0000_20190102.csv"
dataspec_filename        <- "dataVariablesSpecification.csv" 
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
LLOQ      <- 1.0

# --------------------
#  Columns in data (used in dataset checkout and EDA)
# --------------------
# Define variables as they are expected to be based on protocol and data spec
ostudies <- c("study1","study2")   # original names of studies that should be included
studies  <- c(1,2)                 # numeric version 
cohorts  <- c(1,2)                 # cohorts 
# parts  <- c(1001,1002)           # parts 
doses    <- c(25, 100, 150, 300)   # doses 

# Define columns in dataset (and what type)
cols_study_related <- 
  c("OSTUDYID", "STUDYID", "COHORT","DOSE", "NMSEQSID", "OSID")
# "PART"

# Continuous columns (not including covariates)
cols_numeric <- c('TAFD','TAPD','DV','LNDV')

## Character/Categorical columns (not including covariates)
cols_factors <- c('C','AMT','OCC','MDV','CMT','BLQ','EVID',"FREQ", "COMMENT")

## Lists of continuous and categorical covariates (which may change with time)
# included these as examples here - they are not actually changing
cols_cat_cov <- c("BRENAL")
cols_cont_cov <- c("BWT","BBMI")

## List of baseline continuous and categorical covariates (should not change with time)
base_cat_cov  <- c("SEXM","RACE","ETHNIC","BRENAL")
base_cont_cov <- c("AGE","BSCR","BEGFR","BWT","BHT","BBMI")

# This vector should contain all columns of your dataset
all_cols <- c(cols_study_related, cols_numeric, cols_factors, 
              cols_cat_cov,cols_cont_cov,base_cat_cov,base_cont_cov)




# ------------------------------------------------------------------
#  List lables and settings for plots used in EDA
# ------------------------------------------------------------------
# Reoccuring labels
labs_TAPD <- "Time after dose (h)"
labs_TAFD <- "Time after first dose (h)"
labs_conc <- paste0(dv_name," concentration (", dv_unit,")")

# Re-occuring x-axis breaks
tapd_breaks <- c(0, 2, 4, 6, 8, seq(from=12, to=200, by=6))





# ------------------------------------------------------------------
#  Save environment 
# ------------------------------------------------------------------
save.image(file = file.path("Scripts",'Setup',"setup_variables.RData"))
