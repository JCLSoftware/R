source('https://raw.githubusercontent.com/JCLSoftware/R/master/miner/utils.R')
data<-read.csv(fsource)
hasHeader<-fixLogical(hasHeader)
if(hasHeader){
  selectedHeaders<-gsub(' ', '.', selectedHeaders)
  predict=gsub(' ', '.',predict)
  weights=F

  frmla <- as.formula(paste(predict, paste(colnames(data)[1:(ncol(data)-1)], sep = "", collapse = " + "), sep = " ~ "))
  attach(data)
  if(weights){
    modelo1<- lm(frmla,weights=weights)
  }else 
    modelo1<- lm(frmla)
  result<-summary(modelo1)
  return(result)
}else stop('cabeçalhos de colunas obrigatórios')
