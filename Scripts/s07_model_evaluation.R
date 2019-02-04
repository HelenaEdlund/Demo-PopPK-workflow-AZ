###################################################
# s07_model_evaluation.Rmd
# Author : Helena Edlund
# Description: Model evaluation 
# Dependencies: s07_model_execute.R 
###################################################

# -----------------------------------------------
# Prepare environment
# -----------------------------------------------
source(file = file.path("./Scripts","Setup","setup01_rEnvironment.R"))
load(file = file.path("./Scripts","s01.RData"))


#  Run 001

render_model_eval("001")
# render_model_vpc("001")

render_model_eval("002")
# render_model_vpc("002")

render_model_eval("003")
 #render_model_vpc("003")

