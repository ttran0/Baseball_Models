#Plate Apparences
PA <- function (Player) {
  PA <- 1
  for (i in 2:length(Player$batter)) {
    if (Player$batter[i] != Player$batter[i-1]) {
      PA <- PA+1
    }
  }
  return(PA)
}

