fixLogical<-function(x){
  if(length(x) == 0){
      return(F)
  }else { return(as.logical(x))}
}
isVSF<-function(v){
  return((length(v)==1 && !is.null(v) && !is.na(v) && v != "" && nchar(v) > 0))
}
