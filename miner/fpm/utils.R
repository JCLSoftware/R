writeOutputs<-function(params){
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
  return result=(paste('{"arulesFileId":',arulesId,',"graphFileId":',graphId,'}', sep=''))
}
