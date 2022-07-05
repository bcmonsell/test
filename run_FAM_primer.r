# change directory to where the image of R data should be read from
setwd(dir = "C:/Users/monsell_b/OneDrive - US Department of Labor - BLS/FAM_Primer/all")

#install required packages
source("install_all.r")

#read in UI data
source("input_latest_uihis.r")

#process Initial Claims
source("ic_and_holiday_matrix.r")
#model: no log, automatic model identification
source("ic_airline_auto_run_xts.r")

#process Continued Claims
source("cc_and_holiday_matrix.r")
#model: log, automatic model identification, TC at week 13 2020
source("cc_airline_tc_auto_log_run_xts.r")
