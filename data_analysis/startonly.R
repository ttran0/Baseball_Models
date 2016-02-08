#remove relief appearences
startonly <- function(Player) {
  dates <- unique(Player$date)
  dates <- as.character(dates)
  data <- data.frame()
  for (i in 1:length(dates)) {
    game <- subset(Player,Player$date==dates[i])
    if (game$inning.x[1] == 1) {
      data <- rbind(data,game)
    } 
  }
  return(data)
}