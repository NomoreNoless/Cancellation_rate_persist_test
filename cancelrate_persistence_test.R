cancelrate_persistence_test <- function(dataset,Factors){
  
  time_bin <- data.frame(df=c(9.3,10,10.3,11,11.3,12,12.3,13,13.3,14,14.3,15,15.3))
  
  dataset <- data.frame(dataset)
  
  for(factor in Factors){
    
    factor_quo <- rlang::sym(factor)
    
    bin_factor <- paste0("bin_",factor)
    bin_factor_quo <- rlang::sym(bin_factor)
    
    selected <- dataset %>% select(FirmName,TethysClientID,StrategyID,CompoundID,Ticker,rlang::UQ(factor_quo),rlang::UQ(bin_factor_quo),timebin_cancelrate,time_bin)
    
    #for factor in each percentile
    if(factor=="pilot_cat"){
      percentile_vec <- c("C","G","None")
    }
    else if(factor=="tick_size"){
      percentile_vec <- c("0.0001","0.01","0.05")
    }
    else if(factor=="start_time" | factor=="end_time"){
      percentile_vec <- c(9.3,10,10.3,11,11.3,12,12.3,13,13.3,14,14.3,15,15.3)
    }
    else{
      percentile_vec <- seq(1,10,1)
    }
      

    for (item in percentile_vec){
      
      select_percentile <- dataset %>% filter()
    }
    for(i in 1:length(time_bin$df)){
      
      for(j in 1:length(time_bin$df)){
        
        dataset1 <- selected %>% filter(time_bin==i)
        dataset2 <- selected %>% filter(time_bin==j)
        
        
        
      }
    }
    
  }
  
}