complete <- function(directory, id=1:332)
{
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  nobsData <-function(id)
  {  
    lsFiles <- list.files(directory)
    #lsFiles
    nmFiles <- as.numeric(sub("\\.csv","",lsFiles))
    #nmFiles
    selectFiles <- lsFiles[match(id,nmFiles)]
    #selectFiles
    path <- file.path(directory, selectFiles)
    #path
    nobsData <-  sum(complete.cases(read.csv(path)))
    #nobsData
  }
  data.frame(id=id, nobs= sapply(id,nobsData))
  
}
