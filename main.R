options(java.parameters = "-Xmx8000m")
library(XLConnect)
library(tidyverse)
library(reshape)
library(gridExtra)
library(SDMTools)
library(dplyr)
library(odbc)
library(stringr)
library(rlang)
library(stats)
library(formattable)
library(ggplot2)

source("LoadDataSQL.R")
source("loadData1on1.R")
source("load_msgs.R")
source("BinbyFactor.R")
source("LoadFactors.R")
source("LoadBins.R")
source("Load_compound_variables.R")

#connect to database
#__________________________________________________________________________
con1 <- DBI::dbConnect(odbc::odbc(),
                       Driver = "{SQL Server Native Client 11.0}",
                       #Driver = "{SQL Server}",
                       Server = "192.168.1.110",
                       Database = "TethysAnalytics",
                       UID = "tethys",
                       PWD = "tethys100",
                       MARS_connection="yes")

performance_table <- tbl(con1,"PerformanceExports")

#----------------------------------------------------------------------------
con2 <- DBI::dbConnect(odbc::odbc(),
                       Driver = "{SQL Server Native Client 11.0}",
                       #Driver = "{SQL Server}",
                       Server = "192.168.1.110",
                       Database = "tethystrader_R",
                       UID = "tethys",
                       PWD = "tethys100",
                       MARS_connection="yes")

order_msgs <- tbl(con2,"order_msgs")
#________________________________________________________________________________________________________________________


dataset_filename <- loadData1vsB(FirmName = "QIM", SEC_TYPE="S",E_ALGORITHM="EVWAP")
dataset <- dataset_filename$dataset
dataset <- dataset %>% filter(TradeDate>='2017-05-22')


firmname <- "QIM"
time_range <- c("201712")


dataset <- Load_compound_variables(dataset,"QIM",time_range)


Factors=c("start_time","end_time","VWAP_Slip_bps","cancel_cost_bps","fill_ratio","effective_spread_tics","effective_spread_bps","duration_sec","duration_exe","duration_vol","adv","size_pct","real_part","book_size","vol_book","spread_bps","spread_tic","midrange_pct","return_pct","notional","PILOT_SECURITY",
          "spread","midrange","midrange_spread","mark","book","exec_ct","TICK_SIZE_USE")

PerformanceMetric <- "timebin_cancelrate"

dataset <- LoadFactors(dataset,Factors,PerformanceMetric)


default_bins <- LoadBins(algo="EVWAP",ordertype=1)

binned_dataset <- BinbyFactor(dataset,Factors,percentage=0.1,default_bins)

#_______________________________________________________________________________
#1.paired t test
#2.nonparametric signed rank test
cancelrate_persistence_test(binned_dataset,Factors)
#_______________________________________________________________________________




