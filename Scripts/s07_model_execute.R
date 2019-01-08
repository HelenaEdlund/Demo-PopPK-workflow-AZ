###################################################
# s07_model_execute.R
# Author: Helena Edlund
# Created: 2019-01-08
#    
# Description: Execute and monitor NONMEM runs for base model development
# Dependencies: s06_nm_datasets.Rmd / s06.RData
###################################################


# Please note: this is a minimal example to show functionalities and 
# alternatives for using the packages, 
# Its  not intended as a example for model development / selection


# ------------------------------------------------------------------
#  Prepare environment
# ------------------------------------------------------------------
source(file = file.path("./Scripts","Setup","setup01_rEnvironment.R"))
# load generated NM datasets
load(file = file.path("./Scripts","s06.RData"))


# ---------------
#  Run001: 2 cmt, 1 st order oral
# ---------------
# In this example the control file was just written manually and saved as run 001.mod

# Use this to get string to copy paste to $INPUT and $DATA
# paste(colnames(nm_data), collapse = " ")
# nm_data_filename


mod001 <- nm(cmd = "qpsn -t 40 -- execute run001.mod -directory=run001 -threads=1", 
             # nm automatically asumes its run in 'Models' but change if running somewhere else
             run_in = directories[["model_dir"]]) 
nm_tran(mod001)
run(mod001, quiet=F)



# ---------------
#  Run002: 2 cmt, 1st order oral, add BSV KA
# ---------------

# use psn to create a new file based on run001
# Tarj, can you please show how you handle this to not overwrite in case running again? 


mod002 <- nm(cmd = "qpsn -t 40 -- execute run002.mod -directory=run002 -threads=1", 
             run_in = directories[["model_dir"]])
nm_tran(mod002)
run(mod002, quiet=F)


# Add execution of psn vpc (and bootstrap?)


# ---------------
#  Run003; 2 cmt, 0+1st order oral
# ---------------
# Tarj, can you add code here to extract this from the code library? 
# Any other code you want to add? 
mod003 <- nm(cmd = "qpsn -t 40 -- execute run003.mod -directory=run003 -threads=1", 
             run_in = directories[["model_dir"]])
nm_tran(mod003)
run(mod003, quiet=F)


# ---------------
#  SCM
# ---------------

# manually create a scm file

# scm002 <- nm(cmd = "qpsn -t 40 -- execute run002.mod -directory=run002 -threads=1", 
#              run_in = directories[["model_dir"]])
# nm_tran(scm002)
# run(scm002, quiet=F)
