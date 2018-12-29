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
	apr<-apriori(fp, parameter = list(supp = 0.453, conf = 0.95))

	p<-plot(apr, method = "graph", engine="htmlwidget", measure = "support", shading = "lift", fp)
	htmlwidgets::saveWidget(p, "graph.html", selfcontained = FALSE)
	#ATENCAO! Renomeie o arquivo pois será gerado novo arquivo a seguir. Isso é necessário para que a pasta de biblioteca tenha um nome unico e melhore o desempenho do sistema

	p <- plotly_arules(apr)
	htmlwidgets::saveWidget(p, "arules.html", selfcontained = FALSE)
 	#write.csv(s, file=params$fout)
