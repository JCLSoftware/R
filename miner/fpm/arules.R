source('https://raw.githubusercontent.com/JCLSoftware/R/master/miner/fpm/utils.R')
encoding='UTF-8'
params$hasHeader<-fixLogical(params$hasHeader)
t<-read.transactions(params$datasource)
apr<-apriori(t, parameter = list(supp = as.numeric(params$support), conf = as.numeric(params$confidence)))
writeOutputs(params)
