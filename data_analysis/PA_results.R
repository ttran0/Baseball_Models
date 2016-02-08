PA_results <- function(Player) {
  events <- Player$event
  events <- as.character(events)
  batters <- Player$batter
  result <- c()
  result[1] < events[1] 
  count <- 2
  if (length(events)>1) {
    for(i in 2:length(events)) {
      # print(result[1])
      result[1]=events[1]
      if(batters[i] != batters[i-1]){
        result[count] <- events[i]
        count <- count+1
      }
    }
    return(result)
    
  } else if(length(events)<=1) {
    result=events
  }
  
}


