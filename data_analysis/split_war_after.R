#Split Data

split_war_after <- function (Player) {
  dates <- unique(Player$gameId)
  dates <- as.character(dates)
  Player_before2 <- data.frame()
  Player_after2 <- data.frame()
  # print(dates)
  for (i in 1:length(dates)) {
    # for (i in 15:15) {
    game <- subset(Player,Player$gameId==dates[i])
    total <- length(game$batterId)
    batter_faced <- 1
    # print(game$batterId)
    if (length(game$batterId)>1) {
      for (j in 2:length(game$batterId)) {
        if (game$batterId[j] != game$batterId[j-1]) {
          batter_faced <- batter_faced+1
          # print(batter_faced)
        }
        if (batter_faced == 18) {
          rotation <- j
          # print(rotation)
          # print(pitches_2rotation)
        }
        
      }
    } else {
      batter_faced <- 1
    }
    
    # print(batter_faced)
    if (batter_faced <=18) {
      rotation <- total
      Player_before2 <- rbind(Player_before2,game[1:rotation,])
    } else {
      Player_before2 <- rbind(Player_before2,game[1:rotation, ])
      Player_after2 <- rbind(Player_after2, game[(rotation+1):total, ])
    }
    
  }
  return(Player_after2)
}

