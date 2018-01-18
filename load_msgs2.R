load_msgs2 <- function(firmname,year_month){
  
  print(paste0("Calculating month ",year_month))
  
  msgs10_21_32 <- order_msgs %>% 
    filter(FirmName==firmname) %>% 
    filter(msg_id %in% c(10,21,32)) %>%
    filter(substring(transacttime,1,6)==year_month) %>%
    select(FirmName,tethysclientid,strategyid,compoundid,symbol,clordid,origclordid,msg_id,price,lastshares,lastpx,transacttime,t_ask,t_bid,side) %>% collect()
  
  msgs10_21_32 <- msgs10_21_32 %>% mutate(clordid = ifelse(msg_id==32,origclordid,clordid),
                                          mark21 = ifelse(msg_id==21,1,0))
  
  msgs10_21_32 <- msgs10_21_32 %>% group_by(clordid) %>% mutate(fill_or_not = ifelse(sum(mark21)>0 & n()>1,1,ifelse(sum(mark21)==0 & n()>1,0,NA)))
  
  msgs10 <- msgs10_21_32 %>% filter(msg_id==10)
  
  gc(verbose = FALSE)
  
  return(msgs10)
  
}