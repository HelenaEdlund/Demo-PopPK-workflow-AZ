###################################################
# s00_main.R
# 
# Author: Helena Edlund
# Created on: 2019-01-02
# Description: "Make-file" for population PK analysis of AZD0000
# Dependencies: None
###################################################

# All programs that needs to be executed are sourced/rendered below in the order 
# they should be executed. 

# -------------------- 
#  Read in source data and set stucture for R
# --------------------
source(file = file.path("Scripts", "s01_dataset_preparation.R"))



# The .Rmd scripts below generate a .html file with the output. 
# If you also want graphs and tables to be outputted as separate files, 
# set print_results to TRUE

# -------------------- 
#  Dataset checkout
# --------------------
rmarkdown::render(input=file.path("Scripts","s02_dataset_review.Rmd"))


# -------------------- 
# Summarize (a priori) excluded data
# --------------------
rmarkdown::render(input=file.path("Scripts","s03_summary_excluded_data.Rmd"))

# -------------------- 
# Exploratory Data Analysis
# --------------------
rmarkdown::render(input = file.path("Scripts", "s04_eda_covariates.Rmd"), 
                  params = list(print_results=T))
rmarkdown::render(input = file.path("Scripts", "s05_eda_conc_time.Rmd"), 
                  params = list(print_results=F))

# -------------------- 
# Preparation of NONMEM dataset(s)
# --------------------
# If print_csv is true the script outputs the dataset(s) to "DerivedData", 
# otherwise it just saves the datasets and the names of the datasets s07.RData
rmarkdown::render(input =file.path("Scripts","s06_nm_datasets.Rmd"), 
                  params = list(print_csv=TRUE))
# " Error in unlockBinding("params", <environment>) : no binding for "params" " can be ignored. 
# It's because we need to delete "params" before the scripts is done. Output is created anyway


# -------------------- 
# Model development and evaluation
# --------------------
# Execute base models 
source(file=file.path("Scripts", "s07_base_models_execute.R"))

# Evaluation of base models 
rmarkdown::render(input = file.path("Scripts", "s07_base_models_evaluation.Rmd"), 
                  params = list(print_results=F))




## To be continued with covariate model development and reporting ##


# -------------------- 
#  Document environments and check you're compliant with the KM 
# --------------------
Renvironment_info()
check_session()

