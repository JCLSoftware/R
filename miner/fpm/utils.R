writeOutputs<-function(apr, fp, params){
 if(length(apr) > 0){
  defaultName = paste(params$storedFileId,params$suppor, params$confidence, ".html", sep='_')
  p<-plot(apr, method = "graph", engine="htmlwidget", measure = "support", shading = "lift", fp)
  htmlwidgets::saveWidget(p, "arules.html", selfcontained = F)
  graphId=repareWidget(paste(defaultName, "graph.html", sep='_'), user)
  #file.rename("arules.html", paste(defaultName, "graph.html", sep='_'))
  p <- plotly_arules(apr)
  htmlwidgets::saveWidget(p, "arules.html", selfcontained = F)
  arulesId=repareWidget(paste(defaultName, "scatter.html", sep='_'), user)
  #file.rename("arules.html", )
  #write.csv(s, file=params$fout)
  result=(paste('{"arulesFileId":',arulesId,',"graphFileId":',graphId,'}', sep=''))
  return(result)
 }else return('{"msg":"nenhuma regra atende aos parâmetros especificados"}')
}
repareWidget<-function(newName, user){
	tx  <- readLines("arules.html")
	tx2  <- gsub(pattern = "arules_files/", replace = "http://jcloud.net.br/static/arules_files/", x = tx)
	writeLines(tx2, con=newName)		
	url = 'http://storage.jcloud.net.br/UPLOAD/1.json';
	x<-POST(url, body = list(x = upload_file(newName), Username=user$name, Password=user$password))#dominio diferente exige autenticação
	a<-content(x, useInternalNodes=T)
	return(a$Id)
}
