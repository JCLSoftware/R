#!/usr/bin/env Rscript
	encoding='UTF-8'
 	t = read.table(params$datasource, sep=params$sep, header = as.logical(params$hasHeader, row.names=NULL, comment.char="", stringsAsFactors=TRUE, encoding = encoding))	
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
	apr<-apriori(fp, parameter = list(supp = params$support, conf = params$confidence))
	defaultName = paste(params$storedFileId,params$suppor, params$confidence, ".html", sep='_')
	p<-plot(apr, method = "graph", engine="htmlwidget", measure = "support", shading = "lift", fp)
	htmlwidgets::saveWidget(p, "arules.html", selfcontained = F)
	repareWidget(paste(defaultName, "graph.html", sep='_'))
	repareWidget<-function(newName){
		tx  <- readLines("arules.html")
		tx2  <- gsub(pattern = "arules_files/", replace = "https://github.com/JCLSoftware/R/edit/master/miner/fpm/arules_files/", x = tx)
		writeLines(tx2, con=newName)
	}
	#file.rename("arules.html", paste(defaultName, "graph.html", sep='_'))
	p <- plotly_arules(apr)
	#htmlwidgets::saveWidget(p, "arules.html", selfcontained = F)
	#repareWidget(paste(defaultName, "scatter.html", sep='_'))
        #file.rename("arules.html", )
 	#write.csv(s, file=params$fout)
