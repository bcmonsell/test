# change directory to where the image of R data should be read from
#setwd("X:/code/weeklyAdjustment/review2022/new")
#load("FAM_primer.RData")

ic_xts_dates <- as.Date(paste0(ic_df$year,"-",ic_df$month,"-",ic_df$day))
ic_xts       <- xts::xts(x = ic_df$ic,     order.by = ic_xts_dates)
ic_week_xts  <- xts::xts(x = ic_df$week,   order.by = ic_xts_dates)
ic_year_xts  <- xts::xts(x = ic_df$year,   order.by = ic_xts_dates)
ic_dates_xts <- xts::xts(x = ic_xts_dates, order.by = ic_xts_dates)

# set starting date to the 5th week in 2004
start_filter <- ic_week_xts == 5 & ic_year_xts == 2004
this_start_xts <- ic_xts_dates[start_filter]

# set ending date to 5th week in 2022
end_filter     <- ic_week_xts == 5 & ic_year_xts == 2022
this_end_xts   <- ic_xts_dates[end_filter]

# create series, week and year variables with this starting and ending date

ic_xts_final        <- window(ic_xts,      start=this_start_xts, end=this_end_xts)
ic_week_xts_final   <- window(ic_week_xts, start=this_start_xts, end=this_end_xts)
ic_year_xts_final   <- window(ic_year_xts, start=this_start_xts, end=this_end_xts)

ic_this_start_xts   <- this_start_xts
ic_xts_final_dates  <- 
  as.Date(as.vector(window(ic_dates_xts, start=this_start_xts, end=this_end_xts)), 
          origin = "1970-01-01")

# generate holiday, outlier regressors for fractional airline model

ic_ny_xts  <- 
  airutilities::gen_movereg_holiday_xts(hol_n = 8, 
                                        hol_index = 1, 
                                        hol_wt = c(0, 0, 0, 0, 0, 0, 1, 1), 
                                        hol_type = "newyear", 
                                        this_week = ic_week_xts_final, 
                                        this_year = ic_year_xts_final, 
                                        return_xts = TRUE)

ic_mlk_xts <- 
  airutilities::gen_movereg_holiday_xts(hol_n = 1, 
                                        hol_index = 1, 
                                        hol_wt = array(1, dim=1), 
                                        hol_type = "mlk", 
                                        this_week = ic_week_xts_final, 
                                        this_year = ic_year_xts_final, 
                                        return_xts = TRUE) 

ic_president_xts <- 
  airutilities::gen_movereg_holiday_xts(hol_n = 1, 
                                        hol_index = 1, 
                                        hol_wt = array(1, dim=1), 
                                        hol_type = "president", 
                                        this_week = ic_week_xts_final, 
                                        this_year = ic_year_xts_final, 
                                        return_xts = TRUE) 

ic_easter_xts  <- 
  airutilities::gen_movereg_holiday_xts(hol_n = 8, 
                                        hol_index = 8, 
                                        hol_wt = c(1, 0, 0, 0, 0, 0, 0, 0), 
                                        hol_type = "easter", 
                                        this_week = ic_week_xts_final, 
                                        this_year = ic_year_xts_final, 
                                        return_xts = TRUE)

ic_memorial_xts <- 
  airutilities::gen_movereg_holiday_xts(hol_n = 1, 
                                        hol_index = 1, 
                                        hol_wt = array(1, dim=1), 
                                        hol_type = "memorial", 
                                        this_week = ic_week_xts_final, 
                                        this_year = ic_year_xts_final, 
                                        return_xts = TRUE) 

ic_july4_xts <- 
  airutilities::gen_movereg_holiday_xts(hol_n = 1, 
                                        hol_index = 1, 
                                        hol_wt = array(1, dim=1), 
                                        hol_type = "july4", 
                                        this_week = ic_week_xts_final, 
                                        this_year = ic_year_xts_final, 
                                        return_xts = TRUE) 

ic_labor_xts  <- 
  airutilities::gen_movereg_holiday_xts(hol_n = 2, 
                                        hol_index = 2, 
                                        hol_wt = c(0, 1), 
                                        hol_type = "labor", 
                                        this_week = ic_week_xts_final, 
                                        this_year = ic_year_xts_final, 
                                        return_xts = TRUE)

ic_columbus_xts <- 
  airutilities::gen_movereg_holiday_xts(hol_n = 1, 
                                        hol_index = 1, 
                                        hol_wt = array(1, dim=1), 
                                        hol_type = "columbus", 
                                        this_week = ic_week_xts_final, 
                                        this_year = ic_year_xts_final, 
                                        return_xts = TRUE) 

ic_veteran_xts <- 
  airutilities::gen_movereg_holiday_xts(hol_n = 1, 
                                        hol_index = 1, 
                                        hol_wt = array(1, dim=1), 
                                        hol_type = "veteran", 
                                        this_week = ic_week_xts_final, 
                                        this_year = ic_year_xts_final, 
                                        return_xts = TRUE) 

ic_thanksgiving_xts <- 
  airutilities::gen_movereg_holiday_xts(hol_n = 1, 
                                        hol_index = 1, 
                                        hol_wt = array(1, dim=1), 
                                        hol_type = "thanksgiving", 
                                        this_week = ic_week_xts_final, 
                                        this_year = ic_year_xts_final, 
                                        return_xts = TRUE) 

ic_july4_wed_xts <- 
  airutilities::match_month_day_xts(ic_week_xts_final, "0707", 
                                    return_xts = TRUE)
ic_xmas_w53_xts  <- 
  airutilities::match_week_xts(ic_week_xts_final, 53, 
                               return_xts = TRUE)
ic_xmas_fri_xts  <- 
  airutilities::match_month_day_xts(ic_week_xts_final, "1226", 
                                    return_xts = TRUE)
ic_holiday_matrix_xts <- 
  cbind(ic_ny_xts, ic_mlk_xts, ic_president_xts, ic_easter_xts, ic_memorial_xts, 
        ic_july4_xts, ic_labor_xts, ic_columbus_xts, ic_veteran_xts, ic_thanksgiving_xts,
        ic_july4_wed_xts, ic_xmas_w53_xts, ic_xmas_fri_xts)

colnames(ic_holiday_matrix_xts) <- 
  c("ny", "mlk", "president", "easter", "memorial", "july4",
    "labor", "columbus", "veteran", "thanksgiving",
    "july4_wed", "xmas_w53", "xmas_fri")
    
# generate "legacy" outliers, create alternate regression matrix with those included

legacy_outlier_dates <- matrix(c(37, 2005, 38, 2005, 45, 2012), ncol=2, byrow=TRUE)
ic_legacy_matrix_xts <- 
  airutilities::gen_outlier_matrix(legacy_outlier_dates, ic_week_xts_final, 
                                   ic_year_xts_final, 0, return_xts = TRUE)

ic_holiday_matrix_names <- colnames(ic_holiday_matrix_xts)
ic_legacy_matrix_names  <- colnames(ic_legacy_matrix_xts)

ic_holiday_plus_legacy_matrix_xts <- 
   cbind(ic_holiday_matrix_xts, ic_legacy_matrix_xts)
   
colnames(ic_holiday_plus_legacy_matrix_xts) <- 
  c(ic_holiday_matrix_names, ic_legacy_matrix_names)
  
# construct outliers for outlier set with TC

ic_firstTC_date <- 
  matrix(c(13, 2020), ncol=2, byrow=TRUE)

ic_firstTC_matrix_xts <- 
  airutilities::gen_tc_outlier_matrix(ic_firstTC_date, 
                                      ic_week_xts_final, 
                                      ic_year_xts_final, 0, 
                                      return_xts = TRUE)

ic_firstTC_matrix_names  <- colnames(ic_firstTC_matrix_xts)

ic_tc_auto_matrix_xts <- cbind(ic_holiday_matrix_xts, ic_firstTC_matrix_xts)

colnames(ic_tc_auto_matrix_xts) <- 
  c(ic_holiday_matrix_names, ic_firstTC_matrix_names)

# combine holiday, legacy outlier, and alternate outlier set with TC

ic_tc_holiday_legacy_matrix_xts <- 
  cbind(ic_holiday_plus_legacy_matrix_xts, ic_firstTC_matrix_xts)

colnames(ic_tc_holiday_legacy_matrix_xts) <- 
  c(ic_holiday_matrix_names, ic_legacy_matrix_names, ic_firstTC_matrix_names)

# Generate ljung-based critical value for outliers

ic_ljung_cv <- 
  sautilities::set_critical_value(length(ic_xts_final), cv_alpha = 0.005)


# change directory to where you want image of R data saved
#setwd("X:/code/weeklyAdjustment/review2022/new")
save.image("FAM_primer.RData")
