#!/usr/bin/env Rscript
	repareWidget<-function(newName, user){
		tx  <- readLines("arules.html")
		tx2  <- gsub(pattern = "arules_files/", replace = "http://jcloud.net.br/static/arules_files/", x = tx)
		writeLines(tx2, con=newName)		
		url = 'http://storage.jcloud.net.br/UPLOAD/1.json';
		x<-POST(url, body = list(x = upload_file(newName), Username=user$name, Password=user$password))#dominio diferente exige autenticação
		a<-content(x, useInternalNodes=T)
		return(a$Id)
	}
	encoding='UTF-8'
	#Fix missing values (TODO: use function fixLogical from https://raw.githubusercontent.com/JCLSoftware/R/master/miner/utils.R, already loaded)
	if(length(params$hasHeader) == 0){
		params$hasHeader=F
	}else { params$hasHeader=as.logical(params$hasHeader)}

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
	defaultName = paste(params$storedFileId,params$suppor, params$confidence, ".html", sep='_')
	source('https://raw.githubusercontent.com/JCLSoftware/R/master/miner/fpm/writeOutputs.R')
