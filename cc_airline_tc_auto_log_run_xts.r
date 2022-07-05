# change directory to where the image of R data should be read from
#setwd("X:/code/weeklyAdjustment/review2022/new")
#load("FAM_primer.RData")

# fractional airline with holiday regressors, alternate outlier set with TC, no log, using ljung_cv

cc_tc_auto_ljung_log_xts_est <- 
  rjd3highfreq::fractionalAirlineEstimation(log(cc_xts_final), periods=c(365.25/7), 
                                     x=cc_tc_auto_matrix_xts,
                                     outliers=c("ao", "ls"), 
                                     criticalValue = cc_ljung_cv)
cc_tc_auto_ljung_log_xts_decomp <-
  rjd3highfreq::fractionalAirlineDecomposition(cc_tc_auto_ljung_log_xts_est$model$linearized, 
                                        365.25/7, stde = TRUE)

cc_tc_auto_ljung_log_model <- 
  airutilities::gen_air_model_matrix(cc_tc_auto_ljung_log_xts_est,
                                     xreg_names = colnames(cc_tc_auto_matrix_xts),
                                     this_week = cc_week_xts_final,
                                     this_year = cc_year_xts_final)

# check model and set up xtype_tc_auto_ljung
xtype_tc_auto_ljung_log_otl_index <- 
  sort(c(grep("ao", tolower(substr(rownames(cc_tc_auto_ljung_log_model), 1, 2))),
         grep("ls", tolower(substr(rownames(cc_tc_auto_ljung_log_model), 1, 2))),
         grep("tc", tolower(substr(rownames(cc_tc_auto_ljung_log_model), 1, 2)))))
xtype_tc_auto_ljung_log_otl <- 
  tolower(substr(rownames(cc_tc_auto_ljung_log_model), 1, 2))[xtype_tc_auto_ljung_log_otl_index]
xtype_tc_auto_ljung_log <- 
  c(rep("hol", ncol(cc_holiday_matrix_xts)), xtype_tc_auto_ljung_log_otl)

cc_tc_auto_ljung_log_comp <- 
  airutilities::gen_air_components(cc_tc_auto_ljung_log_xts_est, 
                                   cc_tc_auto_ljung_log_xts_decomp, 
                                   this_xtype = xtype_tc_auto_ljung_log, 
                                   this_log = TRUE, this_stde = TRUE)

cc_tc_auto_ljung_log_comp_xts <- 
  lapply(cc_tc_auto_ljung_log_comp, function(x) 
    try(xts::xts(x = x, order.by = cc_xts_final_dates)))

# fractional airline with holiday and legacy outlier regressors, alternate outlier set with TC, no log, using ljung_cv

cc_tc_auto_legacy_log_xts_est <- 
  rjd3highfreq::fractionalAirlineEstimation(log(cc_xts_final), periods=c(365.25/7), 
                                     x=cc_tc_holiday_legacy_matrix_xts,
                                     outliers=c("ao", "ls"), 
                                     criticalValue = cc_ljung_cv)
cc_tc_auto_legacy_log_xts_decomp <-
  rjd3highfreq::fractionalAirlineDecomposition(cc_tc_auto_legacy_log_xts_est$model$linearized, 
                                        365.25/7, stde = TRUE)

cc_tc_auto_legacy_log_model <- 
  airutilities::gen_air_model_matrix(cc_tc_auto_legacy_log_xts_est,
                                     xreg_names = colnames(cc_tc_holiday_legacy_matrix_xts),
                                     this_week = cc_week_xts_final,
                                     this_year = cc_year_xts_final)

# check model and set up xtype_tc_auto_ljung
xtype_tc_auto_legacy_log_otl_index <- 
  sort(c(grep("ao", tolower(substr(rownames(cc_tc_auto_legacy_log_model), 1, 2))),
         grep("ls", tolower(substr(rownames(cc_tc_auto_legacy_log_model), 1, 2))),
         grep("tc", tolower(substr(rownames(cc_tc_auto_legacy_log_model), 1, 2)))))
xtype_tc_auto_legacy_log_otl <- 
  tolower(substr(rownames(cc_tc_auto_legacy_log_model), 1, 2))[xtype_tc_auto_legacy_log_otl_index]
xtype_tc_auto_legacy_log <- 
  c(rep("hol", ncol(cc_holiday_matrix_xts)), xtype_tc_auto_legacy_log_otl)

cc_tc_auto_legacy_log_comp <- 
  airutilities::gen_air_components(cc_tc_auto_legacy_log_xts_est, 
                                   cc_tc_auto_legacy_log_xts_decomp, 
                                   this_xtype = xtype_tc_auto_legacy_log, 
                                   this_log = TRUE, this_stde = TRUE)

cc_tc_auto_legacy_log_comp_xts <- 
  lapply(cc_tc_auto_legacy_log_comp, function(x) 
    try(xts::xts(x = x, order.by = cc_xts_final_dates)))

# change directory to where you want image of R data saved
#setwd("X:/code/weeklyAdjustment/review2022/new")
save.image("FAM_primer.RData")
