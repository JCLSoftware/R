source(paste('https://raw.githubusercontent.com/JCLSoftware/R/master/miner/fpm/utils.R?a=',Sys.time(),sep=''))
encoding='UTF-8'
params$hasHeader<-fixLogical(params$hasHeader)
t<-read.transactions(params$datasource)
apr<-apriori(t, parameter = list(supp = as.numeric(params$support), conf = as.numeric(params$confidence)))
result<-writeOutputs(apr, t, params)
return(result)
