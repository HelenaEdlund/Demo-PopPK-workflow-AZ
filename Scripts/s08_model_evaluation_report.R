###################################################
# s08_model_evaluation_report.R
# Author: Helena Edlund
# Created: 2019-01-08
#    
# Description: Generate final model related figures and tables for report
# Dependencies: s01_nm_datasets.Rmd / s01.RData
#               Base and final model nonmem result files
###################################################


# Tarj, can I load specific runs in the data base without re-writing with 
# nm() ? 

# ------------------------------------------------------------------
#  Prepare environment
# ------------------------------------------------------------------
source(file = file.path("./Scripts","Setup","setup01_rEnvironment.R"))
# load generated NM datasets
load(file = file.path("./Scripts","s01.RData"))


# baseModel <- 
# finalModel <- 



# ------------------------------------------------------------------
#  Joint parameter table
# ------------------------------------------------------------------

ext_to_df()



# ------------------------------------------------------------------
#  Gof plots
# ------------------------------------------------------------------


