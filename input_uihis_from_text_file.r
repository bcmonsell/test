# read in data from uihis.txt

uihis_df <- read.table("uihis.txt")
names(uihis_df) <- c("year", "month", "week", "day", "ic", "cc")

# generate xts series for IC
ic_xts_dates <- 
  as.Date(paste0(uihis_df$year, "-", uihis_df$month, "-", uihis_df$day))
ic_xts       <- xts::xts(x = uihis_df$ic,     order.by = ic_xts_dates)
ic_week_xts  <- xts::xts(x = uihis_df$week,   order.by = ic_xts_dates)
ic_year_xts  <- xts::xts(x = uihis_df$year,   order.by = ic_xts_dates)
ic_dates_xts <- xts::xts(x = ic_xts_dates, order.by = ic_xts_dates)

# create version of series with NA at last observation, 
# filter for observations that are not NA
cc_temp      <- 
  suppressWarnings(as.double(varhandle::unfactor(uihis_df$cc)))
cc_filter    <- !is.na(cc_temp)

# generate xts series for CC
cc_xts_dates <- 
  as.Date(paste0(uihis_df$year[cc_filter], "-", 
                 uihis_df$month[cc_filter], "-", 
                 uihis_df$day[cc_filter]))
cc_xts       <- xts::xts(x = cc_temp[cc_filter],     
                         order.by = cc_xts_dates)
cc_week_xts  <- xts::xts(x = uihis_df$week[cc_filter],   
                         order.by = cc_xts_dates)
cc_year_xts  <- xts::xts(x = uihis_df$year[cc_filter],   
                         order.by = cc_xts_dates)
cc_dates_xts <- xts::xts(x = cc_xts_dates, 
                         order.by = cc_xts_dates)

# generate tis series for IC
uihis_start <- c(uihis_df$year, uihis_df$week)

ic_tis <- tis::tis(uihis_df$ic, start = uihis_start, tif = "wsaturday")
ic_week_tis <- tis::tis(uihis_df$week, start = uihis_start, tif = "wsaturday")
ic_year_tis <- tis::tis(uihis_df$year, start = uihis_start, tif = "wsaturday")

ic_series_end <- end(ic_tis)
ic_forecast_end <- ic_series_end + 104

# generate tis series for CC
cc_tis <- tis::tis(uihis_df$cc[cc_filter], start = uihis_start, tif = "wsaturday")
cc_week_tis <- tis::tis(uihis_df$week[cc_filter], start = uihis_start, tif = "wsaturday")
cc_year_tis <- tis::tis(uihis_df$year[cc_filter], start = uihis_start, tif = "wsaturday")

cc_series_end <- end(cc_tis)
cc_forecast_end <- cc_series_end + 104