#!/usr/bin/env Rscript
source('https://raw.githubusercontent.com/JCLSoftware/R/master/miner/fpm/utils.R')
encoding='UTF-8'
params$hasHeader<-fixLogical(params$hasHeader)

t = read.table(params$datasource, sep=params$sep, header = params$hasHeader, row.names=NULL, comment.char="", stringsAsFactors=TRUE, encoding = encoding)	
data<-as.matrix(t)
#data[is.na(data[,2]),2]='Outros' #Remove NAs das cidades
for(i in 1:nrow(data)){
  for(j in 1:ncol(data)){
    data[i, j]<-paste(j, data[i, j])
  }
}
frules<-paste(params$fout, '.rules', sep='')
write.table(frules, x = data, sep = ';')
fp <- read.transactions(frules, sep = ';')
data<-fp;
apr<-apriori(fp, parameter = list(supp = as.numeric(params$support), conf = as.numeric(params$confidence)))
result<-writeOutputs(params)
return(result)
