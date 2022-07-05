wd<-getwd()

setwd(dir = "C:/Users/monsell_b/OneDrive - US Department of Labor - BLS/FAM_Primer/all")

#install CRAN packages
install.packages("rJava")
install.packages("RProtoBuf")
install.packages("RCurl")
install.packages("mathjaxr")
install.packages("openxlsx")
install.packages("tis")
install.packages("xts")

#install JDemetra+ packages
install.packages("rjd3toolkit_0.2.0.tar.gz", repos=NULL, type = "source", INSTALL_opts = "--no-multiarch")
install.packages("rjd3modelling_0.2.0.tar.gz", repos=NULL, type = "source", INSTALL_opts = "--no-multiarch")
install.packages("rjd3arima_0.2.0.tar.gz", repos=NULL, type = "source", INSTALL_opts = "--no-multiarch")
install.packages("rjd3sa_0.2.0.tar.gz", repos=NULL, type = "source", INSTALL_opts = "--no-multiarch")
install.packages("rjd3tramoseats_0.2.0.tar.gz", repos=NULL, type = "source", INSTALL_opts = "--no-multiarch")
install.packages("rjd3x13_0.2.0.tar.gz", repos=NULL, type = "source", INSTALL_opts = "--no-multiarch")
install.packages("RJDemetra3_0.2.0.tar.gz", repos=NULL, type = "source", INSTALL_opts = "--no-multiarch")
install.packages("rjd3sts_0.2.0.tar.gz", repos=NULL, type = "source", INSTALL_opts = "--no-multiarch")
install.packages("rjd3bench_0.2.0.tar.gz", repos=NULL, type = "source", INSTALL_opts = "--no-multiarch")
install.packages("rjd3highfreq_0.2.0.tar.gz", repos=NULL, type = "source", INSTALL_opts = "--no-multiarch")

#install Brian's packages
install.packages("checkmate")
install.packages("timeDate")
install.packages("airutilities_3.1.tar.gz", repos=NULL, type = "source", INSTALL_opts = "--no-multiarch")
install.packages("sautilities_3.1.tar.gz", repos=NULL, type = "source", INSTALL_opts = "--no-multiarch")

setwd(dir = wd)

