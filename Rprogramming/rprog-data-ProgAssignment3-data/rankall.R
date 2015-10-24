rankall <- function(outcome, num = "best") {
  # read file in
  data <- read.csv(file="outcome-of-care-measures.csv", colClasses = "character")
    
  #set outcomeCol for the proper condition
  switch(outcome,
         "heart attack"={outcomeCol<- 11},
         "heart failure"={outcomeCol<- 17},
         "pneumonia"={outcomeCol<-23},
          {stop('invalid outcome')}
  )
  hospitalNamesCol <- 2

  for(i in 1:nrow(data))
  {  
    if(data[i, outcomeCol]=="Not Available"){data[i, outcomeCol] <- NA }
  }  
  r <-  split(data, data$State)  
  hNames <- vector()
  sNames <- vector()
  for(i in 1:length(r))
  { 
    nas <- sum(is.na(r[[i]][,outcomeCol]))
    if(is.numeric(num) && num>(length(r[[i]][,2])-nas))
    {
      hNames <- c(hNames, NA) 
      sNames <- c(sNames, r[[i]][1, 7])
      next
    }
    r[[i]][,outcomeCol] <- as.numeric(r[[i]][,outcomeCol])
  
    r[[i]][,] <- r[[i]][order(r[[i]][, outcomeCol], r[[i]][, hospitalNamesCol]), ] 
  
  if(num=="best")hNames <- c(hNames, r[[i]][1, 2])
  else if(num=="worst")hNames <- c(hNames, r[[i]][length(r[[i]][,2])-nas, 2])
  else hNames <- c(hNames, r[[i]][num, 2])
  
  sNames <- c(sNames, r[[i]][1, 7])
  }
  dataframe <- data.frame(hospital = hNames, state = sNames)
  dataframe

}