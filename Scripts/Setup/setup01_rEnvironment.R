###################################################
# setup01_rEnvironment.R
# 
# Author: Helena Edlund
# Created on: 2019-01-07
# Description: Prepare R environment by loading libraries and setting global options
# Dependencies: None
###################################################


# -----------------------------------------------
# Load needed packages
# -----------------------------------------------

# ----------- If needed: do this at first set up -------------------
if(F){
  devtools::install_github("tsahota/NMprojectAZ")
  devtools::install_github("AstraZeneca/pmworkbench")
  devtools::install_github("AstraZeneca/pmxplore")
  # need latest version of these two
  install.packages("GGally", repos = "https://cran.rstudio.com") 
  install.packages("rmarkdown", repos = "https://cran.rstudio.com") 
}

# Workflow related packages
library(rprojroot)
library(knitr)
library(NMprojectAZ) # also loads tidyproject
library(pmworkbench)
library(pmxplore)
library(tableone)

# Tidyverse and plotting
library(tidyverse)
library(gridExtra)
library(GGally)

# Misc
library(zoo)
library(PKNCA)

library(xpose)

# -----------------------------------------------
# Settings for ggplot
# -----------------------------------------------
# White background in plots
theme_set(theme_bw()) # to be replaced with a azTheme
update_geom_defaults("point", list(shape = 1))

