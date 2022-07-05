setwd(dir = "C:/Users/monsell_b/OneDrive - US Department of Labor - BLS/FAM_Primer")

ic_df <- openxlsx::read.xlsx("uihis_new.xlsx", sheet=1)
cc_df <- openxlsx::read.xlsx("uihis_new.xlsx", sheet=2)

uihis_start <- c(1988, 1)

ic_tis <- tis::tis(ic_df$ic, start = uihis_start, tif = "wsaturday")

ic_week_tis <- tis::tis(ic_df$week, start = uihis_start, tif = "wsaturday")
ic_year_tis <- tis::tis(ic_df$year, start = uihis_start, tif = "wsaturday")

ic_series_end <- end(ic_tis)
ic_forecast_end <- ic_series_end + 104

cc_tis <- tis::tis(cc_df$cc, start = uihis_start, tif = "wsaturday")

cc_week_tis <- tis::tis(cc_df$week, start = uihis_start, tif = "wsaturday")
cc_year_tis <- tis::tis(cc_df$year, start = uihis_start, tif = "wsaturday")

cc_series_end <- end(cc_tis)
cc_forecast_end <- cc_series_end + 104

# change directory to where you want image of R data saved
#setwd("X:/code/weeklyAdjustment/review2022/new")
save.image("FAM_primer.RData")
