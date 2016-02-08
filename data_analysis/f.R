f <- function (Player) {
  innings_pitched <- 0
  games <- unique(Player$dates)
  games <- as.character(games)
  for (i in 1:length(games)) {
    game <- subset(Player,Player$date==games[i])
    innings <- game$inning.x
    outs <- game$o
    for (j in min(unique(innings)):max(unique(innings))) {
      
      index <- which(outs %in% j)
      if (max(outs[index])==3 & (min(outs(index))==0 | min(outs[index])==1)) {
        innings_pitched_game=innings_pitched_game+1
      }
      else if (max(outs[index])==3 & min(outs[index])==2){
        innings_pitched_game=innings_pitched_game+2/3
      }
      else if (max(outs[index])==2 & (min(outs[index])==0 | min(outs[index])==1)) {
        innings_pitched_game=innings_pitched_game+2/3
      }
      else if (max(outs[index])==1) {
        innings_pitched_game=innings_pitched_game+1/3;
      }
      
      else if (max(outs[index])==0) {
        innings_pitched_game=innings_pitched_game+0
      }
      
      else if (max(outs[index])==1 & min(outs[index])==1) {
        innings_pitched_game=innings_pitched_game+1/3
        
      }
      
      else if (max(outs[index])==2 & min(outs[index])==2) {
        innings_pitched_game=innings_pitched_game+1/3
      }
      
      else if (max(outs[index])==3 & min(outs[index])==3) {
        innings_pitched_game=innings_pitched_game+1/3
      }
    }
    
    innings_pitched=innings_pitched+innings_pitched_game
    
  }
  
  
  
  
  
  
  return(innings_pitched)
}
