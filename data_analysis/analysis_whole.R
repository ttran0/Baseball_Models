rm(list=ls())
library(plyr)
library(dplyr)
data <- data.frame()
pitchers <- read.csv("pitchers.csv")
pitchers$name <- as.character(pitchers$name)


# index <- which(pitchers$name=='Cliff Lee',arr.ind=TRUE)
# pitchers <- pitchers[index,]
n<-length(pitchers$name)
Player_before2 <- data.frame()
Player_after2 <- data.frame()
innings_pitched_before <- 0
innings_pitched_after <- 0
innings_pitched <- 0
# n<-10

Player <- data.frame()
for (i in 1:n) {
  Player_all <- data.frame()
  name <- strsplit(as.character(pitchers$name[i])," ")[[1]]
  full_name <- paste(name[1],name[2],sep="")
  Player_all <- read.csv(sprintf('%s_11.csv',full_name))
  Player_all <- Player_all[order(Player_all$date, Player_all$inning.x, Player_all$o), ]
  print(full_name)
  Player <- rbind(Player_all,Player)
  source('~/Desktop/Baseball/split_before.R')
  Player_all_before <- split_before(Player_all)
  Player_before2 <- rbind(Player_before2,Player_all_before)
  
  source('~/Desktop/Baseball/split_after.R')
  Player_all_after2 <- split_after(Player_all)
  Player_after2 <- rbind(Player_after2,Player_all_after2)
  
  source('~/Desktop/Baseball/IP.R')
  innings_pitched_before_all<- IP(Player_before2)
  innings_pitched_after_all <- IP(Player_after2)
  innings_pitched_all <- IP(Player)
  
  
  source('~/Desktop/Baseball/PA_results.R')
  PA_results_before <- PA_results(Player_before2)
  PA_results_after <- PA_results(Player_after2)
  PA_results <- PA_results(Player)
  
  
  
}
  
 
  
  source('~/Desktop/Baseball/PA.R')
  # P <- PA(Player)
  
  
  hits_before <- length(subset(PA_results_before,((PA_results_before=='Single') | (PA_results_before=='Double') |(PA_results_before=='Triple') |(PA_results_before=='Home Run'))))
  hits_after <- length(subset(PA_results_after,((PA_results_after=='Single') | (PA_results_after=='Double') |(PA_results_after=='Triple') |(PA_results_after=='Home Run'))))
  # hits <- length(subset(Player_war$isHit,Player_war$isHit=='TRUE'))
  hits <- length(subset(PA_results,((PA_results=='Single') | (PA_results=='Double') |(PA_results=='Triple') |(PA_results=='Home Run'))))
  
  
  
  
  walks_before <- length(subset(PA_results_before,PA_results_before=='Walk'))
  walks_after <- length(subset(PA_results_after,PA_results_after=='Walk'))
  # walks <- length(subset(Player_war,((Player_war=='Walk'))))
  walks <- length(subset(PA_results, PA_results=='Walk'))
  
  
  strikeouts <- length(subset(PA_results,PA_results=='Strikeout'))
  strikeouts_before <- length(subset(PA_results_before,PA_results_before=='Strikeout'))
  strikeouts_after <- length(subset(PA_results_after,PA_results_after=='Strikeout'))
  
  
  
  # home_runs <- length(subset(Player_war$event,Player_war$event=='Home Run'))
  
  # strikeouts_war <- length(subset(Player_war$event,Player_war$event=='Strikeout'))
  
  strikeoutper9_before <- strikeouts_before*9/innings_pitched_before
  strikeoutper9_after <- strikeouts_after*9/innings_pitched_after
  strikeoutper9 <- strikeouts*9/innings_pitched
  
  
  # walks <- length(subset(Player_war$event,Player_war$event=='Walk'))
  WHIP_before <- (hits_before+walks_before)/innings_pitched_before
  WHIP_after <- (hits_after+walks_after)/innings_pitched_after
  WHIP <- (hits+walks)/innings_pitched
  
  FIP_before <- (13*length(subset(PA_results_before,(PA_results_before=='Home Run')))+3*walks_before-2*strikeouts_before)/(innings_pitched_before)+3.1
  FIP_after<- (13*length(subset(PA_results_after,(PA_results_after=='Home Run')))+3*walks_after-2*strikeouts_after)/(innings_pitched_after)+3.1
  FIP <- (13*length(subset(PA_results,(PA_results=='Home Run')))+3*walks-2*strikeouts)/(innings_pitched)+3.1
  
  
  xFIP_before <- (13*.105*length(subset(PA_results_before,(PA_results_before=='Flyout')))+3*walks_before-2*strikeouts_before)/(innings_pitched_before)+3.025
  xFIP_after<- (13*.105*length(subset(PA_results_after,(PA_results_after=='Flyout')))+3*walks_after-2*strikeouts_after)/(innings_pitched_after)+3.1
  xFIP <- (13*.105*length(subset(PA_results,(PA_results=='Flyout')))+3*walks-2*strikeouts)/(innings_pitched)+3.1
  
  
  Fourseam_velocity_before <- subset(Player_before2$start_speed,Player_before2$pitch_type=='FF')
  Fourseam_velocity_after <- subset(Player_after2$start_speed,Player_after2$pitch_type=='FF')
  Fourseam_velocity <- subset(Player$start_speed,Player$pitch_type=='FF')
  
  avg_ff_before <- mean(Fourseam_velocity_before)
  avg_ff_after <- mean(Fourseam_velocity_after)
  avg_ff  <- mean(Fourseam_velocity)
  
  walksper9_before <- walks_before*9/innings_pitched_before
  walksper9_after <- walks_after*9/innings_pitched_after
  walksper9<- walks*9/innings_pitched
  
  BAA_before <- hits_before/(length(PA_results_before)-walks_before-length(subset(Player_before2$event,Player_before2$event=='Sac Fly'))-length(subset(Player_before2$event,Player_before2$event=='Sac Bunt')))
  BAA_after <- hits_after/(length(PA_results_after)-walks_after-length(subset(Player_after2$event,Player_after2$event=='Sac Fly'))-length(subset(Player_after2$event,Player_after2$event=='Sac Bunt')))
  BAA <- hits/(length(PA_results)-walks-length(subset(Player$event,Player$event=='Sac Fly'))-length(subset(Player$event,Player$event=='Sac Bunt')))


# Pitcher <- pitchers$name[1:n]
# Pitcher <- factor(Pitcher)
xFIP_data <- data.frame(xFIP_before,xFIP_after,xFIP)
FIP_data <- data.frame(FIP_before,FIP_after,FIP)
WHIP_data <- data.frame(WHIP_before,WHIP_after,WHIP)
Velocity_data <- data.frame(avg_ff_before,avg_ff_after, avg_ff)
Walksper9_data <- data.frame(walksper9_before,walksper9_after,walksper9)
BAA_data <- data.frame(BAA_before,BAA_after,BAA)
Strikeoutper9_data <- data.frame(strikeoutper9_before,strikeoutper9_after,strikeoutper9)

# data<-join_all(list(FIP_data,WHIP_data,Velocity_data,Walksper9_data,BAA_data,Strikeoutper9_data),by="Pitcher")
# data <- data.frame(Pitcher,xFIP_data,FIP_data,WHIP_data,Velocity_data,Walksper9_data,BAA_data,Strikeoutper9_data)
# effectxFIP <- subset(data,((data$xFIP_after-data$xFIP_before)>0))
# noeffectxFIP <- subset(data,((data$xFIP_after-data$xFIP_before)<0))
# effectBAA <- subset(data,((data$BAA_after-data$BAA_before)>0))
# noeffectBAA <- subset(data,((data$BAA_after-data$BAA_before)<0))
# write.csv(effect,"effect.csv")
# write.csv(noeffect,'noeffect.csv')