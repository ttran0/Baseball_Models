# time <- function(Player) {
rm(list=ls())
setwd('/Users/truong/Desktop/OneDrive/Baseball')

# pitchers <- c('FelixHernandez','MarkBuehrle','ColeHamels','EdwinJackson','JeremyGuthrie','JustinVerlander')
pitchers <- c('FelixHernandez')
# pitchers <- c('Mark Buehrle')
year <- c('09','10','11','12')# year <- c('09','10')


for (k in 1:length(pitchers)) {
  fip_all <- c()
  for (l in 1:length(year)) {
    
    Player <- read.csv(sprintf('%s_%s.csv',pitchers[k],year[l]))
    Player <- Player[order(Player$date, Player$inning.x, Player$o, Player$id), ] 
      
      
    FIP=c()
    Strikes=c()
    dates <- unique(Player$date)
    dates <- as.character(dates)
    pitch_2order <- c()
    print(pitchers[k])
    # pitches_2_rotation <- split_before(Player)[[2]]
    fip <- c()
    FIP <- list()
    total_pitches <- c()
    for (j in 1:length(dates)) {
      date_game <- dates[j]
      Player_game <- subset( Player, Player$date==date_game)
      total_pitches[j]<-(length(Player_game$date))
      F=c()
      S <- c()
      
      count <- 0
      source('~/Desktop/OneDrive/Baseball/pitches2order.R')
      pitch_2order[j] <- pitches2order(Player_game)
      for (i in 1:length(Player_game$date)) {
        
        source('~/Desktop/OneDrive/Baseball/IP.R')
        innings_pitched <- IP(Player_game[1:i,])
        

        source('~/Desktop/OneDrive/Baseball/PA_results.R')
        results <- PA_results(Player_game[1:i,])
        
        F[i]<- ((13*length(subset(results,(results=='Home Run')))+3*length(subset(results,(results=='Walk')))-2*length(subset(results,(results=='strikeouts'))))/(innings_pitched)+3.025)
        if(innings_pitched == 0) {
          F[i] <- 3.025
        }
        if(Player_game$type[i]=='S') {
          S[i] <- 1
        } else {
          S[i] <- 0
          
        }
        # S[i] <- (count)/i
      }
      FIP[j] <- list(F)
      Strikes[j] <- list(S)
      source('~/Desktop/OneDrive/Baseball/PA_results.R')
      results <- PA_results(Player_game)
      fip[j] <- ((13*length(subset(results,(results=='Home Run')))+3*length(subset(results,(results=='Walk')))-2*length(subset(results,(results=='strikeouts'))))/(innings_pitched)+3.025)
      # pitches_thrown [j] <- list()
    }
    assign(sprintf('%s_%s',pitchers[k],year[l]),list('pitch'=pitch_2order,'total_pitches'=total_pitches,'date'=dates,'strike'=Strikes,'fip'=FIP))
    fip_data <- data.frame(cbind(fip,dates))
    write.csv(fip_data,sprintf('%sfip_%s.csv',pitchers[k],year[l]))
    fip_all <- rbind(fip_all,t(t(fip)))
  }
}

# setwd('/Users/truong/Desktop/OneDrive/Baseball/pbp')
# for (i in 1:length(pitchers)) {
#   for (j in 1:length(year)) {
#     player <- get(sprintf('%s_%s',pitchers[i],year[j]))
#     for (k in 1:length(player$date)) {
#       game <- player$date[k]
#       pdf(sprintf('%s_%s.pdf',pitchers[i],game))
#       plot(1:player$total_pitches[k],player$strike[[k]],type="o",ylab="strike vs not strike",xlab="pitch #",main=sprintf('%s %s',pitchers[i],game))
#       points(player$pitch[k],player$strike[[k]][player$pitch[k]],col="red")
#       dev.off()
#       
#     }
#   }
# }

for (i in 1:length(pitchers)) {
  
  for (j in 1:length(year)) {
    player_pbp <- data.frame()
    player <- get(sprintf('%s_%s',pitchers[i],year[j]))
    for (k in 1:length(player$date)) {
      game <- player$date[k]
      y <- c(player$strike[[k]],rep(NA,max(player$total_pitches)-length(player$strike[[k]])))
      player_pbp <- rbind(player_pbp,y)
    }
    x <- c(1:max(player$total_pitches))
    # print(max(x))
    player_pbp <- cbind(player_pbp,player$date)
    colnames(player_pbp) <- c(sprintf('pitch%s',x),'date')
#     # player_pbp <- cbind(player_pbp,data.frame(rep(game,length(y))),data.frame(rep(pitchers[i],length(y))))
    write.csv(player_pbp,sprintf('%spbp_%s.csv',pitchers[i],year[j]))
  }
}
  
