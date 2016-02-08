rm(list=ls())
library(dplyr)
library(pitchRx)
library(openWAR)
setwd("/Users/truong/Desktop/OneDrive/Baseball")
pitchers <- read.csv("pitchers12.csv")
pitchers$name <- as.character(pitchers$name)
# name=c('Clayton Kershaw', 'Justin Verlander','James Shields', 'Clayton Kershaw','Cliff Lee','Cole Hamels','Ian Kennedy','Matt Cain','Josh Beckett', 'C.J. Wilson','Jeremy Hellickson','CC Sabathia','Gio Gonzalez','Dan Haren','Jordan Zimmermann','Justin Masterson','Madison Bumgarner','Tim Hudson','Matt Garza','Ervin Santana','Kyle Lohse','Matt Harrison','Mat Latos','David Price','Alexi Ogando')
db <- src_sqlite('/Users/truong/Desktop/OneDrive/Baseball/pitchrx11_12.sqlite3')
dat11 <- read.csv('openWAR12.csv')
atbat11 <- filter(tbl(db,'atbat'),date >='2012_03_28' & date <='2012_10_03')
pitches <- tbl(db,'pitch')
# for (i in 1:length(pitchers$name)) {
for (i in 1:1) {
  Player_11 <- filter (atbat11,pitcher_name==pitchers$name[i])
  Player11 <- inner_join(pitches,Player_11, by=c('num','gameday_link'))
  Player <- collect(Player11)
  Player <- Player[order(Player$date, Player$inning.x, Player$o), ]
  Player_b <- Player
  name <- strsplit(as.character(pitchers$name[i])," ")[[1]]
  full_name <- paste(name[1],name[2],sep="")
  
  
  Player_War <- subset (dat11, dat11$pitcherId==Player$pitcher[1])

  bad_dates <- (sort(c(setdiff(Player_War$gameId, Player$gameday_link),setdiff(Player$gameday_link,Player_War$gameId))))
  if (length(bad_dates>=1)) {
    for (j in 1:length(bad_dates)) {
      # print(paste("Bad dates for",pitchers$name[i]))
      row_bad_dates <- which(Player==bad_dates[j], arr.in=TRUE)
      Player <- Player[-row_bad_dates[,1], ]
    }
  }
  if (length(Player$date) != pitchers$pitches[i]) {
    print(paste('Pitch number does not match for',pitchers$name[i]))
    # print(paste('Pitches_data, Actual_pitches',length(Player$date),pitchers$pitches[i]))
  }
  
  if (length(Player_b$date)==pitchers$pitches[i]) {
    Player <- Player_b
  }
  
  print(paste("Pitcher",pitchers$name[i]))
  print(paste('Pitches_data, Actual_pitches',length(Player$date),pitchers$pitches[i]))
  print(bad_dates)
  
  write.csv(Player,sprintf('%s_12.csv',full_name))
}