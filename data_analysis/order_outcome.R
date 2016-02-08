rm(list=ls())
setwd('/Users/truong/Desktop/OneDrive/Baseball')
year <- c('09','10','11','12')
pitchers <- c('Felix Hernandez','Mark  Buehrle','ColeHamels','Edwin Jackson','Jeremy Guthrie','Justin Verlander')
for (k in 1:length(pitchers)) {

  # for (k in 1:1) {
  result <- data.frame()
  games<-data.frame()
  for (j in 1:length(year)) {
    
    pitchers[k]<-gsub(" ","",pitchers[k])
    player <- read.csv(sprintf('%s_%s.csv',pitchers[k],year[j]))
    player <- player[order(player$date, player$inning.x, player$o, player$start_tfs, player$tfs_zulu), ]
    pitch <- read.csv(sprintf('pitchers%s.csv',year[j]))
    source('~/Desktop/OneDrive/Baseball/startonly.R')
    player <- startonly(player)
    print(pitchers[k])
    dates <- unique(player$date)
    d<-data.frame(dates)
    for (i in 1:length(dates)) {
      game <- subset(player,player$date==dates[i])
      source('~/Desktop/OneDrive/Baseball/PA_results.R')
      PA <- PA_results(game)
      result <- rbind(result,t(PA[1:28]))
    }
  games<-rbind(games,d)
  }
  result[,'date'] <- games
  assign(pitchers[k],result)
}

