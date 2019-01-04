fixLogical<-function(x){
  if(length(x) == 0){
      return(F)
  }else { return(as.logical(x))}
}
