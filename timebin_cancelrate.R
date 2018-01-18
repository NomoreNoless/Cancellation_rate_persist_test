

timebin_cancelrate <- function(msgs10){
  
  msgs10 <- msgs10 %>% mutate(time_diff = ifelse(substring(transacttime,5,8)>="0312" & substring(transacttime,5,8)<"1106",4,5), 
                              add_hour = as.integer(as.numeric(gsub(":",".",substring(transacttime,13,17)))/30),
                              time_bin = as.numeric(substring(transacttime,10,11)) - time_diff + 30*add_hour*0.01)
  
  timebin_cancelrate <- msgs10 %>% group_by(FirmName,TethysClientID,StrategyID,CompoundID,Ticker,time_bin) %>%
    summarise(timebin_cancelrate = 1 - sum(fill_or_not,na.rm=TRUE)/n())
  
  remove(msgs10)
  
  gc(verbose = FALSE)
  
  return(timebin_cancelrate)
  
}

# cancel_rate <- function(dataset,firmname,time_range){
#   
#   result_dataset <- data.frame()
# 
#   for(year_month in time_range){
#     
#     msgs10 <- load_msgs2(firmname,year_month)
#     
#     msgs10 <- msgs10 %>% mutate(time_diff = ifelse(substring(transacttime,5,8)>="0312" & substring(transacttime,5,8)<"1106",4,5), 
#                                 add_hour = as.integer(as.numeric(gsub(":",".",substring(transacttime,13,17)))/30),
#                                 time_bin = as.numeric(substring(transacttime,10,11)) - time_diff + 30*add_hour*0.01)
#     
#     
#     cancel_rate_bin <- msgs10 %>% group_by(FirmName,tethysclientid,strategyid,compoundid,symbol,time_bin) %>%
#       summarise(cancel_rate = 1 - sum(fill_or_not,na.rm=TRUE)/n())
#     
#     join_dataset <- inner_join(dataset,cancel_rate_bin,by=c("FirmName"="FirmName","TethysClientID"="tethysclientid","StrategyID"="strategyid","CompoundID"="compoundid","Ticker"="symbol"))
#     
#     remove(msgs10) 
#     
#     if(dim(result_dataset)[1]==0){
#       result_dataset <- join_dataset
#     }
#     else{
#       result_dataset <- rbind(result_dataset,join_dataset)
#     }
#   }
#   
#   gc(verbose = FALSE)
#   
#   return(result_dataset)
#   
# }

