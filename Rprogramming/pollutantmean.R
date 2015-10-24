pollutantmean<-function(directory,pollutant, id=1:332)
{
  lsFiles <- list.files(directory)
  #lsFiles
  nmFiles <- as.numeric(sub("\\.csv","",lsFiles))
  #nmFiles
  selectFiles <- lsFiles[match(id,nmFiles)]
  #selectFiles
  data <- lapply(file.path(directory,selectFiles),read.csv)
  data <- Reduce(function(x, y) rbind(x, y), data)
  mean(data[,pollutant],na.rm=TRUE)
}
