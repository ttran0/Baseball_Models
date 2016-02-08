#Split Data

split_war_before <- function (Player) {
  dates <- unique(Player$gameId)
  dates <- as.character(dates)
  Player_before2 <- data.frame()
  Player_after2 <- data.frame()
  # print(dates)
  
  for (i in 1:length(dates)) {
  # for (i in 4:4) {
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
          # print(pitches_2rotation)
        }
        
      }
    } else {
      batter_faced <-1
    }
    # print(batter_faced)
    if (batter_faced <= 18) {
      rotation <- total
      Player_before2 <- rbind(Player_before2,game[1:rotation,])
    } else {
      Player_before2 <- rbind(Player_before2,game[1:rotation, ])
      Player_after2 <- rbind(Player_after2, game[(rotation+1):total, ])
    }
    
  }
  return(Player_before2)
}




































# game_dates <- unique(Player_11$date)
# Player_before2 <- data.frame()
# Player_after2 <- data.frame()
# Player_season <- data.frame()
# index <- vector(mode="numeric",length=length(game_dates))
# for (j in 1:length(game_dates)){
#   # for (j in 1:31){
#   batter_faced=1;
#   Player_game <- subset(Player_11,Player_11$date==game_dates[j])  
#   total_pitches <- dim(Player_game)[1]
#   for (i in 2:length(Player_game$batter)) {
#     if (Player_game$batter[i] != Player_game$batter[i-1]) {
#       batter_faced=batter_faced+1
#     }
#     
#     if (batter_faced == 19 ) {
#       index[j]=i
#     }
#   }
#   # print(paste("batter_faced=",batter_faced))
#   
#   if (batter_faced >= 19) {
#     Player_before2 <- rbind(Player_before2,Player_game[1:(index[j]),])
#     Player_after2 <- rbind(Player_after2,Player_game[((index[j])+1):total_pitches,])
#   }
#   else if (batter_faced <=18) {
#     index[j]=total_pitches
#     Player_before2 <- rbind(Player_before2,Player_game[1:(index[j]),])
#     Player_after2 <- Player_after2
#   }
# #   Player_season <- rbind(Player_season,Player_game)
# #   if ((length(Player_before2$date) + length(Player_after2$date)) != length(Player_season$date)){
# #     print(j)
# #   }
#   # print(paste("Pitches to rotation", index[j]))
# }
# # return(list(Player_before2,index))
# # return(Player_before2)
# return(Player_before2)
# 
# # list("Player_before2"=Player_before2, "Player_after2"=Player_after2)
# }