# change directory to where the image of R data should be read from
#setwd("X:/code/weeklyAdjustment/review2022/new")
#load("FAM_primer.RData")

# create series, week and year variables with this starting and ending date

cc_xts_dates <- as.Date(paste0(cc_df$year,"-",cc_df$month,"-",cc_df$day))
cc_xts       <- xts::xts(x = cc_df$cc,     order.by = cc_xts_dates)
cc_week_xts  <- xts::xts(x = cc_df$week,   order.by = cc_xts_dates)
cc_year_xts  <- xts::xts(x = cc_df$year,   order.by = cc_xts_dates)
cc_dates_xts <- xts::xts(x = cc_xts_dates, order.by = cc_xts_dates)

# set starting date to the 5th week in 2004
start_filter <- cc_week_xts == 5 & cc_year_xts == 2004
this_start_xts <- cc_xts_dates[start_filter]

# set ending date to 5th week in 2022
end_filter     <- cc_week_xts == 5 & cc_year_xts == 2022
this_end_xts   <- cc_xts_dates[end_filter]

# create series, week and year variables with this starting and ending date

cc_xts_final        <- window(cc_xts,      start=this_start_xts, end=this_end_xts)
cc_week_xts_final   <- window(cc_week_xts, start=this_start_xts, end=this_end_xts)
cc_year_xts_final   <- window(cc_year_xts, start=this_start_xts, end=this_end_xts)

cc_this_start_xts   <- this_start_xts
cc_xts_final_dates  <- 
  as.Date(as.vector(window(cc_dates_xts, start=this_start_xts, end=this_end_xts)), 
          origin = "1970-01-01")

# generate holiday, outlier regressors for fractional airline model

cc_mlk_xts       <- 
  airutilities::gen_movereg_holiday_xts(hol_n = 8, 
                      hol_index = 8, 
                      hol_wt = c(1, 0, 0, 0, 0, 0, 0, 0), 
                      hol_type = "mlk", 
                      this_week = cc_week_xts_final, 
                      this_year = cc_year_xts_final, 
                      return_xts = TRUE)

cc_president_xts <- 
  airutilities::gen_movereg_holiday_xts(hol_n = 8, 
                      hol_index = 8, 
                      hol_wt = c(1, 0, 0, 0, 0, 0, 0, 0), 
                      hol_type = "president", 
                      this_week = cc_week_xts_final, 
                      this_year = cc_year_xts_final, 
                      return_xts = TRUE) 

cc_july4_xts <- 
  airutilities::gen_movereg_holiday_xts(hol_n = 8, 
                      hol_index = 8, 
                      hol_wt = c(1, 0, 0, 0, 0, 0, 0, 0), 
                      hol_type = "july4", 
                      this_week = cc_week_xts_final, 
                      this_year = cc_year_xts_final, 
                      return_xts = TRUE) 

cc_labor_xts  <- 
  airutilities::gen_movereg_holiday_xts(hol_n = 4, 
                      hol_index = 4, 
                      hol_wt = c(1, 0, 0, 0), 
                      hol_type = "labor", 
                      this_week = cc_week_xts_final, 
                      this_year = cc_year_xts_final, 
                      return_xts = TRUE) 

cc_columbus_xts <- 
  airutilities::gen_movereg_holiday_xts(hol_n = 1, 
                      hol_index = 1, 
                      hol_wt = array(1, dim=1), 
                      hol_type = "columbus", 
                      this_week = cc_week_xts_final, 
                      this_year = cc_year_xts_final, 
                      return_xts = TRUE) 

cc_veteran_xts <- 
  airutilities::gen_movereg_holiday_xts(hol_n = 8, 
                      hol_index = 8, 
                      hol_wt = c(1, 0, 0, 0, 0, 0, 0, 0), 
                      hol_type = "veteran", 
                      this_week = cc_week_xts_final, 
                      this_year = cc_year_xts_final, 
                      return_xts = TRUE) 

cc_thanksgiving_xts <- 
  airutilities::gen_movereg_holiday_xts(hol_n = 7, 
                      hol_index = 7, 
                      hol_wt = c(1, 0, 0, 0, 0, 0, 0), 
                      hol_type = "thanksgiving", 
                      this_week = cc_week_xts_final, 
                      this_year = cc_year_xts_final, 
                      return_xts = TRUE) 

cc_thanks_late_xts <- airutilities::match_month_day_xts(cc_week_xts_final, "1130", 
                                    return_xts = TRUE)
cc_xmas_dec23_xts  <- airutilities::match_month_day_xts(cc_week_xts_final, "1223", 
                                    return_xts = TRUE)
cc_xmas_sun_xts    <- airutilities::match_month_day_xts(cc_week_xts_final, "1231", 
                                    return_xts = TRUE)

cc_holiday_matrix_xts <- 
  cbind(cc_mlk_xts, cc_president_xts, cc_july4_xts, cc_labor_xts, cc_columbus_xts, 
        cc_veteran_xts, cc_thanksgiving_xts, cc_thanks_late_xts, cc_xmas_dec23_xts, 
        cc_xmas_sun_xts)

colnames(cc_holiday_matrix_xts) <- 
      c("mlk", "president", "july4", "labor", "columbus", "veteran", "thanksgiving",
        "thanks_late", "xmas_dec23", "xmas_sun")
        
# generate "legacy" outliers, create alternate regression matrix with those included

legacy_outlier_dates <- 
  matrix(c(38, 2005, 39, 2005, 40, 2005, 41, 2005,  1, 2011), ncol=2, byrow=TRUE)
cc_legacy_matrix_xts <- 
  airutilities::gen_outlier_matrix(legacy_outlier_dates, cc_week_xts_final, 
                                   cc_year_xts_final, 0, return_xts = TRUE)

cc_holiday_plus_legacy_matrix_xts <- 
   cbind(cc_holiday_matrix_xts, cc_legacy_matrix_xts)
   
colnames(cc_holiday_plus_legacy_matrix_xts) <- 
  c(colnames(cc_holiday_matrix_xts), colnames(cc_legacy_matrix_xts))

# construct outliers for outlier set with TC

cc_firstTC_date <- 
  matrix(c(13, 2020), ncol=2, byrow=TRUE)

cc_firstTC_matrix_xts <- 
  airutilities::gen_tc_outlier_matrix(cc_firstTC_date, 
                                      cc_week_xts_final, 
                                      cc_year_xts_final, 0, 
                                      return_xts = TRUE)

cc_tc_auto_matrix_xts <- cbind(cc_holiday_matrix_xts, cc_firstTC_matrix_xts)

colnames(cc_tc_auto_matrix_xts) <- 
  c(colnames(cc_holiday_matrix_xts), colnames(cc_firstTC_matrix_xts))

# combine holiday, legacy outlier, and alternate outlier set with TC

cc_tc_holiday_legacy_matrix_xts <- 
  cbind(cc_holiday_plus_legacy_matrix_xts, cc_firstTC_matrix_xts)

colnames(cc_tc_holiday_legacy_matrix_xts) <- 
  c(colnames(cc_holiday_plus_legacy_matrix_xts), colnames(cc_firstTC_matrix_xts))

# Generate ljung-based critical value for outliers

cc_ljung_cv <- 
  sautilities::set_critical_value(length(cc_xts_final), cv_alpha = 0.005)

# change directory to where you want image of R data saved
#setwd("X:/code/weeklyAdjustment/review2022/new")
save.image("FAM_primer.RData")
