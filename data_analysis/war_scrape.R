#war data
rm(list=ls())
library(plyr)
library(dplyr)
data <- data.frame()
pitchers <- read.csv("pitchers.csv")
war <- read.csv('openWAR11.csv')

pitchers$name <- as.character(pitchers$name)

n<-length(pitchers$name)
# n<-1
for (i in 1:n) {
  Player <- data.frame()
  Player_before2 <- data.frame()
  Player_after2 <- data.frame()
  name <- strsplit(as.character(pitchers$name[i])," ")[[1]]
  full_name <- paste(name[1],name[2],sep="")
  Player <- read.csv(sprintf('%s_11.csv',full_name))
  Player <- Player[order(Player$date, Player$inning.x, Player$o, Player$start_tfs, Player$tfs_zulu), ]
  id <- Player$pitcher[1]
  
  Player_war <- subset(war,war$pitcherId==id) 
  write.csv(Player_war, sprintf('%s_war11.csv',full_name))
}
