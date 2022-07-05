# change directory to where the image of R data should be read from
#setwd("X:/code/weeklyAdjustment/review2022/new")
#load("FAM_primer.RData")

# fractional airline with holiday regressors, outlier identification using ljung_cv, no log

ic_auto_ljung_nolog_xts_est <- 
  rjd3highfreq::fractionalAirlineEstimation(ic_xts_final, periods=c(365.25/7), 
                                     x=ic_holiday_matrix_xts,
                                     outliers=c("ao", "ls"), 
                                     criticalValue = ic_ljung_cv)
ic_auto_ljung_nolog_xts_decomp <-
  rjd3highfreq::fractionalAirlineDecomposition(ic_auto_ljung_nolog_xts_est$model$linearized, 
                                        365.25/7, stde = TRUE)

ic_auto_ljung_nolog_model <- 
  airutilities::gen_air_model_matrix(ic_auto_ljung_nolog_xts_est,
                                     xreg_names = colnames(ic_holiday_matrix_xts),
                                     this_week = ic_week_xts_final,
                                     this_year = ic_year_xts_final)


# check model and set up xtype_auto_ljung
xtype_otl_auto_ljung_index <- 
  sort(c(grep("ao", tolower(substr(rownames(ic_auto_ljung_nolog_model), 1, 2))),
         grep("ls", tolower(substr(rownames(ic_auto_ljung_nolog_model), 1, 2)))))
xtype_otl_auto_ljung       <- 
  tolower(substr(rownames(ic_auto_ljung_nolog_model), 1, 2))[xtype_otl_auto_ljung_index]
xtype_auto_ljung           <- 
  c(rep("hol", ncol(ic_holiday_matrix_xts)), xtype_otl_auto_ljung)

ic_auto_ljung_nolog_comp   <- 
  airutilities::gen_air_components(ic_auto_ljung_nolog_xts_est, 
                                   ic_auto_ljung_nolog_xts_decomp, 
                                   this_xtype = xtype_auto_ljung, 
                                   this_log = FALSE, this_stde = TRUE)

ic_auto_ljung_nolog_comp_xts <- 
  lapply(ic_auto_ljung_nolog_comp, function(x) 
    try(xts::xts(x = x, order.by = ic_xts_final_dates)))

# fractional airline with holiday and legacy outlier regressors, outlier identification using ljung_cv, no log

ic_auto_legacy_nolog_xts_est <- 
  rjd3highfreq::fractionalAirlineEstimation(ic_xts_final, periods=c(365.25/7), 
                                     x=ic_holiday_plus_legacy_matrix_xts,
                                     outliers=c("ao", "ls"), 
                                     criticalValue = ic_ljung_cv)
ic_auto_legacy_nolog_xts_decomp <-
  rjd3highfreq::fractionalAirlineDecomposition(ic_auto_legacy_nolog_xts_est$model$linearized, 
                                        365.25/7, stde = TRUE)

ic_auto_legacy_nolog_model <- 
  airutilities::gen_air_model_matrix(ic_auto_legacy_nolog_xts_est,
                                     xreg_names = colnames(ic_holiday_plus_legacy_matrix_xts),
                                     this_week = ic_week_xts_final,
                                     this_year = ic_year_xts_final)


# check model and set up xtype_auto_ljung
xtype_otl_auto_legacy_index <- 
  sort(c(grep("ao", tolower(substr(rownames(ic_auto_legacy_nolog_model), 1, 2))),
         grep("ls", tolower(substr(rownames(ic_auto_legacy_nolog_model), 1, 2)))))
xtype_otl_auto_ljung       <- 
  tolower(substr(rownames(ic_auto_legacy_nolog_model), 1, 2))[xtype_otl_auto_legacy_index]
xtype_auto_ljung           <- 
  c(rep("hol", ncol(ic_holiday_matrix_xts)), xtype_otl_auto_ljung)

ic_auto_legacy_nolog_comp   <- 
  airutilities::gen_air_components(ic_auto_legacy_nolog_xts_est, 
                                   ic_auto_legacy_nolog_xts_decomp, 
                                   this_xtype = xtype_auto_ljung, 
                                   this_log = FALSE, this_stde = TRUE)

ic_auto_legacy_nolog_comp_xts <- 
  lapply(ic_auto_legacy_nolog_comp, function(x) 
    try(xts::xts(x = x, order.by = ic_xts_final_dates)))

# change directory to where you want image of R data saved
#setwd("X:/code/weeklyAdjustment/review2022/new")
save.image("FAM_primer.RData")
