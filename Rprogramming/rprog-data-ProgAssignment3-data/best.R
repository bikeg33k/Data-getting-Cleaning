list.files()
#function to get the hospital name
getName <- function(data, col_num, state) {
  state_subset <- data[data[, 7]==state, ]
  outcome_arr <- state_subset[, col_num]
  min <- min(outcome_arr, na.rm=T)
  min_index <- which(outcome_arr == min)
  hosp_name <- state_subset[min_index, 2]
  return(hosp_name)
}

best <- function(state, outcome) {
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death rate
  
  # read the data file
  data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  
  # change data type from character to numeric
  suppressWarnings(data[, 11] <- as.numeric(data[, 11])) # heart attack
  suppressWarnings(data[, 17] <- as.numeric(data[, 17])) # heart failure
  suppressWarnings(data[, 23] <- as.numeric(data[, 23])) # pneumonia
  
  if (!state %in% data$State) {stop("invalid state")}
  switch(outcome,
         "heart attack"={hosp_name <- getName(data, 11, state)},
         "heart failure"={hosp_name <- getName(data, 17, state)},
         "pneumonia"={hosp_name <- getName(data, 23, state)},
         {stop("invalid outcome")}
         )
    return(hosp_name)
}