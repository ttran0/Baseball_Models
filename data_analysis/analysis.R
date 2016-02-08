rm(list=ls())
library(plyr)
library(dplyr)
data <- data.frame()
pitchers <- read.csv("pitchers15.csv")
# war <- read.csv('openWAR09.csv')

pitchers$name <- as.character(pitchers$name)

innings_pitched_before <- c()
innings_pitched_after <- c()
innings_pitched <- c()
hits_before <- c()
hits_after <- c()
hits <- c()
walks_before <- c()
walks_after <- c()
walks <- c()
strikeouts <- c()
strikeouts_before <- c()
strikeouts_after <- c()
strikeoutsper9_before <- c()
strikeoutsper9_after <-c()
strikeoutsper9 <- c()
WHIP_before <- c()
WHIP_after <- c()
WHIP <- c()
FIP_before <- c()
FIP_after <- c()
FIP <- c()
avg_fast_before <- c()
avg_fast_after <- c()
avg_fast <- c()
walksper9_before <- c()
walksper9_after <- c()
walksper9 <- c()
BAA_before <- c()
BAA_after <- c()
BAA <- c()
xFIP_before <- c()
xFIP_after <- c()
xFIP <- c()
hr_before <- c()
hr_after <- c()
hr <- c()
singles_before <- c()
singles_after <- c()
singles <- c()
doubles_before <- c()
doubles_after <- c()
doubles <- c()
triples_before <- c()
triples_after <- c()
triples <-c()
errors_before <- c()
errors_after <- c()
errors <- c()
wOBA_before <- c()
wOBA_after <- c()
wOBA <- c() 
PA_before <- c()
PA_after <- c()
PA_total <- c()
HBP_before <- c()
HBP_after <- c()
HBP <- c()



# pitchers <- subset(pitchers,pitchers$name=='James Shields')
n<-length(pitchers$name)
# n<-10

for (i in 1:n) {
  Player <- data.frame()
  Player_before2 <- data.frame()
  Player_after2 <- data.frame()
  name <- strsplit(as.character(pitchers$name[i])," ")[[1]]
  full_name <- paste(name[1],name[2],sep="")
  Player <- read.csv(sprintf('%s_15.csv',full_name))
  Player <- Player[order(Player$date, Player$inning.x, Player$o, Player$start_tfs, Player$tfs_zulu), ]
 
  source('~/Desktop/OneDrive/Baseball/startonly.R')
  
  Player <- startonly(Player)
  # id <- Player$pitcher[1]
#   # Player_war <- subset(war,war$pitcherId==id) 
#   Player_war <- read.csv(sprintf('%s_war11.csv',full_name))
#   Player_war <- Player_war[order(Player_war$timestamp, Player_war$inning, Player_war$startOuts), ]
#   
#   
  
  print(full_name)
  
  if ((length(Player$date)-pitchers$pitches[i])>=20){
    print('many pitches are missing')
    print(length(Player$date)-pitchers$pitches[i])
  }
  
#   print(length(Player$date))
#   print(pitchers$pitches[i])
  
#   if (length(Player$date)==0){
#     next
#   }
  
  # Player_war <- read.csv( "Player_war_11.csv")
  
  source('~/Desktop/OneDrive/Baseball/split_before.R')
  Player_before2 <- split_before(Player)
#   
#   source('~/Desktop/Baseball/split_war_before.R')
#   Player_war_before <- split_war_before(Player_war)

  
  source('~/Desktop/OneDrive/Baseball/split_after.R')
  Player_after2 <- split_after(Player)
  
  
  source('~/Desktop/OneDrive/Baseball/IP.R')
  innings_pitched_before[i] <- IP(Player_before2)
  # innings_pitched_after[i] <- IP(Player_after2)
  innings_pitched[i] <- IP(Player)
  innings_pitched_after[i]  <- (innings_pitched[i]-innings_pitched_before[i])
#   innings_pitched_before[i] <- IP(Player_war_before)
#   innings_pitched_after[i] <- IP(Player_war_after)
#   innings_pitched[i] <- IP(Player_war)
  
  source('~/Desktop/OneDrive/Baseball/PA_results.R')
  PA_results_before <- PA_results(Player_before2)
  PA_results_after <- PA_results(Player_after2)
  PA_results <- PA_results(Player)
  
  source('~/Desktop/OneDrive/Baseball/PA.R')
  PA_before[i] <- PA(Player_before2)
  PA_after[i] <- PA(Player_after2)
  PA_total[i] <- PA(Player)
  
  hits_before[i] <- length(subset(PA_results_before,((PA_results_before=='Single') | (PA_results_before=='Double') |(PA_results_before=='Triple') |(PA_results_before=='Home Run'))))
  hits_after[i] <- length(subset(PA_results_after,((PA_results_after=='Single') | (PA_results_after=='Double') |(PA_results_after=='Triple') |(PA_results_after=='Home Run'))))
  hits[i] <- length(subset(PA_results,((PA_results=='Single') | (PA_results=='Double') |(PA_results=='Triple') |(PA_results=='Home Run'))))
  
  
  
  
  walks_before[i] <- length(subset(PA_results_before,PA_results_before=='Walk'))
  walks_after[i] <- length(subset(PA_results_after,PA_results_after=='Walk'))
  walks[i] <- length(subset(PA_results, PA_results=='Walk'))
  
  HBP_before[i] <- length(subset(PA_results_before,PA_results_before=='Hit By Pitch'))
  HBP_after[i] <- length(subset(PA_results_after,PA_results_after=='Hit By Pitch'))
  HBP[i] <- length(subset(PA_results,PA_results=='Hit By Pitch'))
  
  
  strikeouts[i] <- length(subset(PA_results,PA_results=='Strikeout'))
  strikeouts_before[i] <- length(subset(PA_results_before,PA_results_before=='Strikeout'))
  strikeouts_after[i] <- length(subset(PA_results_after,PA_results_after=='Strikeout'))
  
  singles_before[i] <- length(subset(PA_results_before,PA_results_before=='Single'))
  singles_after[i] <- length(subset(PA_results_after,PA_results_after=='Single'))
  singles[i] <- length(subset(PA_results,PA_results=='Single'))
  
  doubles_before[i] <- length(subset(PA_results_before,PA_results_before=='Double'))
  doubles_after[i] <- length(subset(PA_results_after,PA_results_after=='Double'))
  doubles[i] <- length(subset(PA_results,PA_results=='Double'))
  
  triples_before[i] <- length(subset(PA_results_before,PA_results_before=='Triple'))
  triples_after[i] <- length(subset(PA_results_after,PA_results_after=='Triple'))
  triples[i] <- length(subset(PA_results,PA_results=='Triple'))
  
  errors_before[i] <- length(subset(PA_results_before,PA_results_before=='Field Error'))
  errors_after[i] <- length(subset(PA_results_after,PA_results_after=='Field Error'))
  errors[i] <- length(subset(PA_results,PA_results=='Field Error'))
  

  hr_before[i] <- length(subset(PA_results_before,PA_results_before=='Home Run'))
  hr_after[i] <- length(subset(PA_results_after,PA_results_after=='Home Run'))
  hr[i] <- length(subset(PA_results,PA_results=='Home Run'))
  
  
  # strikeouts_war <- length(subset(Player_war$event,Player_war$event=='Strikeout'))
  
  strikeoutsper9_before[i] <- strikeouts_before[i]*9/innings_pitched_before[i]
  strikeoutsper9_after[i] <- strikeouts_after[i]*9/innings_pitched_after[i]
  strikeoutsper9[i] <- strikeouts[i]*9/innings_pitched[i]
  
  
  # walks <- length(subset(Player_war$event,Player_war$event=='Walk'))
  WHIP_before[i] <- (hits_before[i]+walks_before[i])/innings_pitched_before[i]
  WHIP_after[i] <- (hits_after[i]+walks_after[i])/innings_pitched_after[i]
  WHIP[i] <- (hits[i]+walks[i])/innings_pitched[i]
  
  # strikeouts[i] <- 296
  
  FIP_before[i] <- (13*length(subset(PA_results_before,(PA_results_before=='Home Run')))+3*walks_before[i]-2*strikeouts_before[i])/(innings_pitched_before[i])+3.1
  FIP_after[i]<- (13*length(subset(PA_results_after,(PA_results_after=='Home Run')))+3*walks_after[i]-2*strikeouts_after[i])/(innings_pitched_after[i])+3.1
  FIP[i] <- (13*length(subset(PA_results,(PA_results=='Home Run')))+3*walks[i]-2*strikeouts[i])/(innings_pitched[i])+3.1
  
  
  xFIP_before[i] <- (13*.105*length(subset(PA_results_before,(PA_results_before=='Flyout')))+3*walks_before[i]-2*strikeouts_before[i])/(innings_pitched_before[i])+3.1
  xFIP_after[i]<- (13*.105*length(subset(PA_results_after,(PA_results_after=='Flyout')))+3*walks_after[i]-2*strikeouts_after[i])/(innings_pitched_after[i])+3.1
  xFIP[i] <- (13*.105*length(subset(PA_results,(PA_results=='Flyout')))+3*walks[i]-2*strikeouts[i])/(innings_pitched[i])+3.1
  

  # pitch_types <- unique(Player$pitch_type)
  pitch_types <- c('FF','FT','SI','FC')

  pitch_freq <- summary(subset(Player$pitch_type,Player$pitch_type=='FF'| Player$pitch_type=='FT' | Player$pitch_type=='FC' | Player$pitch_type=='SI'))
  
  fb_index <- which.max(pitch_freq)
  fb_type <- names(pitch_freq[fb_index])
  print(fb_type)

  avg_fast_before[i] <- mean(subset(Player_before2$start_speed,Player_before2$pitch_type==fb_type),na.rm=TRUE)
  avg_fast_after[i] <-  mean(subset(Player_after2$start_speed,Player_after2$pitch_type==fb_type),na.rm=TRUE)
  avg_fast[i] <-  mean(subset(Player$start_speed,Player$pitch_type==fb_type),na.rm=TRUE)

  
  
  walksper9_before[i] <- walks_before[i]*9/innings_pitched_before[i]
  walksper9_after[i] <- walks_after[i]*9/innings_pitched_after[i]
  walksper9[i] <- walks[i]*9/innings_pitched[i]
  
  BAA_before[i] <- hits_before[i]/(length(PA_results_before)-walks_before[i]-length(subset(Player_before2$event,Player_before2$event=='Sac Fly'))-length(subset(Player_before2$event,Player_before2$event=='Sac Bunt')))
  BAA_after[i] <- hits_after[i]/(length(PA_results_after)-walks_after[i]-length(subset(Player_after2$event,Player_after2$event=='Sac Fly'))-length(subset(Player_after2$event,Player_after2$event=='Sac Bunt')))
  BAA[i] <- hits[i]/(length(PA_results)-walks[i]-length(subset(Player$event,Player$event=='Sac Fly'))-length(subset(Player$event,Player$event=='Sac Bunt')))
  
  wOBA_before[i] <- ((0.72*walks_before[i])+(0.75*length(subset(Player_before2$event,Player_before2$event=='Hit By Pitch')))+0.9*singles_before[i]+0.92*(errors_before[i])+(1.24*doubles_before[i])+(1.56*triples_before[i])+(1.95*hr_before[i]))/PA_before[i]
  wOBA_after[i] <- ((0.72*walks_after[i])+(0.75*length(subset(Player_after2$event,Player_after2$event=='Hit By Pitch')))+0.9*singles_after[i]+0.92*(errors_after[i])+(1.24*doubles_after[i])+(1.56*triples_after[i])+(1.95*hr_after[i]))/PA_after[i]
  wOBA[i] <- ((0.72*walks[i])+(0.75*length(subset(Player$event,Player$event=='Hit By Pitch')))+0.9*singles[i]+0.92*(errors[i])+(1.24*doubles[i])+(1.56*triples[i])+(1.95*hr[i]))/PA_total[i]
  
  
}

walks_before_all <-sum(walks_before)
walks_after_all <- sum(walks_after)
walks_all <- sum(walks)

strikeouts_all_before <-sum(strikeouts_before)
strikeouts_all_after <- sum(strikeouts_after)

innings_pitched_before_all <- sum(innings_pitched_before)
innings_pitched_after_all <- sum(innings_pitched_after)

hr_all_before <- sum(hr_before)
hr_all_after <- sum(hr_after)

FIP_all_before <- (13*hr_all_before + 3*walks_before_all - 2*strikeouts_all_before)/innings_pitched_before_all+3.05
FIP_all_after <- (13*hr_all_after + 3*walks_after_all - 2*strikeouts_all_after)/innings_pitched_after_all+3.05

wOBA_all_before <- ((0.72*sum(walks_before))+(0.75*sum(HBP_before))+(0.9*sum(singles_before))+(0.92*sum(errors_before))+(1.24*sum(doubles_before))+(1.56*sum(triples_before))+(1.95*sum(hr_before)))/sum(PA_before)
wOBA_all_after <- ((0.72*sum(walks_after))+(0.75*sum(HBP_after))+(0.9*sum(singles_after))+(0.92*sum(errors_after))+(1.24*sum(doubles_after))+(1.56*sum(triples_after))+(1.95*sum(hr_after)))/sum(PA_after)



# wOBA_all_before <- (0.72*sum(walks_before)+0.75*)

s9_before<-strikeouts_all_before*9/innings_pitched_before_all
s9_after<-strikeouts_all_after*9/innings_pitched_after_all


Pitcher <- pitchers$name[1:n]
walks_data <- data.frame(walks_before, walks_after,walks)
innings_data <- data.frame(innings_pitched_before,innings_pitched_after,innings_pitched)
doubles_data <- data.frame(doubles_before,doubles_after, doubles)
triples_data <- data.frame(triples_before,triples_after,triples)
hr_data <- data.frame(hr_before,hr_after,hr)
xFIP_data <- data.frame(xFIP_before,xFIP_after,xFIP)
FIP_data <- data.frame(FIP_before,FIP_after,FIP)
WHIP_data <- data.frame(WHIP_before,WHIP_after,WHIP)
Velocity_data <- data.frame(avg_fast_before,avg_fast_after, avg_fast)
Walksper9_data <- data.frame(walksper9_before,walksper9_after,walksper9)
BAA_data <- data.frame(BAA_before,BAA_after,BAA)
Strikeoutper9_data <- data.frame(strikeoutsper9_before,strikeoutsper9_after,strikeoutsper9)
wOBA_data <- data.frame(wOBA_before,wOBA_after,wOBA)
PA_data <- data.frame(PA_before,PA_after,PA_total)
hits_data <- data.frame(hits_before,hits_after,hits)
innings_pitched_data <- data.frame(innings_pitched_before,innings_pitched_after,innings_pitched)
strikeouts_data <- data.frame(strikeouts_before,strikeouts_after,strikeouts)
HBP_data <- data.frame(HBP_before,HBP_after,HBP)
error_data <- data.frame(errors_before,errors_after,errors)
singles_data <- data.frame(singles_before,singles_after,singles)

data <- data.frame(Pitcher,innings_pitched_data,strikeouts_data, HBP_data, walks_data, error_data, hits_data, singles_data, doubles_data,triples_data,hr_data,PA_data, wOBA_data,xFIP_data,FIP_data,WHIP_data,Velocity_data,Walksper9_data,Strikeoutper9_data)
# x <- which(data$avg_ff>86)
# y <- 1:length(pitchers$name)
# z<-sort(c(setdiff(x,y),setdiff(y,x)))
# whip_before_fast <- (sum(hits_before[x])+sum(walks_before[x]))/sum(innings_pitched_before[x])
# whip_after_fast <- (sum(hits_after[x])+sum(walks_after[x]))/sum(innings_pitched_after[x])
# whip_before_nofast <- (sum(hits_before[z])+sum(walks_before[z]))/sum(innings_pitched_before[z])
# whip_after_nofast <- (sum(hits_after[z])+sum(walks_after[z]))/sum(innings_pitched_after[z])
# A <- data.frame(whip_before_fast,whip_after_fast,whip_before_nofast,whip_after_nofast)



# effectxFIP <- subset(data,((data$xFIP_after-data$xFIP_before)>0))
# noeffectxFIP <- subset(data,((data$xFIP_after-data$xFIP_before)<0))
# effectBAA <- subset(data,((data$BAA_after-data$BAA_before)>0))
# noeffectBAA <- subset(data,((data$BAA_after-data$BAA_before)<0))
# write.csv(effect,"effect.csv")
# write.csv(noeffect,'noeffect.csv')