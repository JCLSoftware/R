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

getNewFileName<-function(name, ext){
    result <- paste(name, ext, sep='.')
    if(file.exists(result)){
      result <- paste(name, (format((Sys.time()), "%m_%d_%y_%H_%M_%OS3")), ext, sep='.')
    }  
    return (result)
}
