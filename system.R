runPackages<-function(libs){
  for(i in libs){
    #print(i)
    #new.packages <- libs[!(libs %in% installed.packages()[,"Package"])]
    #if(length(new.packages))
    if(!is.element(i, installed.packages())){
      install.packages(i)
    }
    library(i, character.only = TRUE)
  }  
}
