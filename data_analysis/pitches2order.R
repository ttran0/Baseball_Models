#Split Data

pitches2order <- function (Player) {
  dates <- unique(Player$date)
  dates <- as.character(dates)
  Player_before2 <- data.frame()
  Player_after2 <- data.frame()
  for (i in 1:length(dates)) {
    game <- subset(Player,Player$date==dates[i])
    total_pitches <- length(game$batter)
    batter_faced <- 1
    for (j in 2:length(game$batter)) {
      
      if (game$batter[j] != game$batter[j-1]) {
        batter_faced <- batter_faced+1
        # print(batter_faced)
      }
      if (batter_faced == 18) {
        pitches_2order <- j
        # print(pitches_2rotation)
      }
      
      #       if (batter_faced ==27) {
      #         total_pitches <- j
      #       }
      
    }
    # print(batter_faced)
    if (batter_faced <= 18) {
      pitches_2order <- total_pitches
      Player_before2 <- rbind(Player_before2,game[1:total_pitches,])
    } else {
      Player_before2 <- rbind(Player_before2,game[1:pitches_2order, ])
      Player_after2 <- rbind(Player_after2, game[(pitches_2order+1):total_pitches, ])
    }
    
  }
  return(pitches_2order)
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