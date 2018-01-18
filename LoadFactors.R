
LoadFactors <- function(dataset,Factors,PerformanceMetric){
  
  dataset <- data.frame(dataset)
  
  all_factors <- c("FirmName","TethysClientID","StrategyID","CompoundID","Ticker",Factors,PerformanceMetric,"time_bin")
  
  dataset <- dataset[,all_factors]
  
}