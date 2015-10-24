corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  returnThis <- c()
  lsFiles <- list.files(directory, full.names=TRUE)
  for(fileName in lsFiles)
  {
    thisData <- read.csv(fileName, header=TRUE)
    numComplete <- dim(thisData[complete.cases(thisData),])[1]
    if(numComplete >=threshold)
    {
      core <- cor(thisData$sulfate, thisData$nitrate, use="p")
      returnThis <- c(returnThis, core) #need to build list of all results of calculation
    }
  }
  #numComplete
  returnThis
}