# IP <- function(player_war) {
#   
#   innings_pitched <- sum(player_war$endOuts-player_war$startOuts)/3
#   return(innings_pitched)
# }



IP <- function (Player) {
# rm(list=ls())
# Player <- read.csv("Kershaw_11.csv")
  innings_pitched <- 0
  games <- unique(Player$date)
  games <- as.character(games)
  
  for (i in 1:length(games)) {
    # for (i in 1:1) {
    game <- subset(Player,Player$date==games[i])
    innings <- subset(game$inning.x,game$date==games[i])
    
    outs <- subset(game$o,game$date==games[i])
    innings_pitched_game <- 0
    # print(as.character(game$date[i]))
    # print(innings)
    # print(innings)
    M <- max(innings)
    m <- min(innings)
    for (j in m:M) {
    # for (j in 1:length(innings)) {
      index <- which(innings %in% j)
#       print(max(outs))
#       print(min(outs))
      
      if ((max(outs[index])==3) & ((min(outs[index])==0) | (min(outs[index])==1))) {
        innings_pitched_game <- innings_pitched_game+1
        
      } else if ((max(outs[index])==3) & (min(outs[index])==2)){
        innings_pitched_game <- innings_pitched_game+2/3
        
      } else if ((max(outs[index]))==2 & ((min(outs[index])==0) | (min(outs[index])==1))) {
        innings_pitched_game <- innings_pitched_game+2/3
        
      } else if (max(outs[index])==1) {
        innings_pitched_game <- innings_pitched_game+1/3;
        
      } else if (max(outs[index])==0) {
        innings_pitched_game <- innings_pitched_game+0
        
      } else if ((max(outs[index])==1) & (min(outs[index])==1)) {
        innings_pitched_game <- innings_pitched_game+0
      
      } else if ((max(outs[index])==2) & (min(outs[index])==2)) {
        innings_pitched_game <- innings_pitched_game+0
        
      } else if ((max(outs[index])==3) & (min(outs[index])==3)) {
        innings_pitched_game <- innings_pitched_game+0
        }
        #       } else {
#         print('case not covered')
#       }
      
    }
#       print(games[i])
#       print(outs)
#       print(innings_pitched_game)
    # innings_pitched <- innings_pitched_game+innings_pitched
    
      innings_pitched <- innings_pitched+innings_pitched_game
#       print(games[i])
#       print(innings_pitched_game)
}

  return(innings_pitched)
}
  