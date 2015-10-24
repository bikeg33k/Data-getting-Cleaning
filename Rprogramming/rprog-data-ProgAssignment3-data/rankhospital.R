rankhospital <- function(state, outcome, num = "best") {
  # read file in
  data <- read.csv(file="outcome-of-care-measures.csv", colClasses = "character")
  
  if (!state %in% data$State) {stop("invalid state")}
  
  #set col for the proper condition
  switch(outcome,
         "heart attack"={col<- 11},
         "heart failure"={col<- 17},
         "pneumonia"={col<-23},
        {stop('invalid outcome')}
  )
  
  data.state <- data[data$State == state, ]
  
  # change data type from character to numeric
  suppressWarnings(data.state[, col] <- as.numeric(x=data.state[, col]))
  
  #pull only complete cases
  data.state <- data.state[complete.cases(data.state), ]

  #check if it is a numeric, and if numeric is valid, or return best/worst, or error
  if(is.numeric(x=num)) {if(num<1 || num > nrow(data.state)) {  return(NA)}}
  else
  {
    switch(num,
           "best"={num=1},
           "worst"={num<-nrow(data.state)},
          {stop ('invalid number')  }
    )  
  }
  data.state <- data.state[order(data.state[,col], data.state$Hospital.Name), ]
  
  return.names <- data.state[num, ]$Hospital.Name
  
  return.names[1]
}