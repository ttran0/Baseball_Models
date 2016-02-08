rm(list=ls())

Player <- read.csv("FelixHernandez_11.csv")

Player <- Player[order(Player$date, Player$inning.x, Player$o), ]

# Player_war <- read.csv( "Player_war_11.csv")
source('~/Desktop/Baseball/split_before.R')
Player_before2 <- split_before(Player)

source('~/Desktop/Baseball/split_after.R')
Player_after2 <- split_after(Player)



source('~/Desktop/Baseball/IP.R')
innings_pitched_before <- IP(Player_before2)

innings_pitched_after <- IP(Player_after2)

innings_pitched <- IP(Player)

source('~/Desktop/Baseball/PA_results.R')
PA_results_before <- PA_results(Player_before2)
PA_results_after <- PA_results(Player_after2)
PA_results <- PA_results(Player)

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

FIP_before <- (13*length(subset(PA_results_before,(PA_results_before=='Home Run')))+3*walks_before-2*strikeouts_before)/(innings_pitched_before)+3.025
FIP_after<- (13*length(subset(PA_results_after,(PA_results_after=='Home Run')))+3*walks_after-2*strikeouts_after)/(innings_pitched_after)+3.025
FIP <- (13*length(subset(PA_results,(PA_results=='Home Run')))+3*walks-2*strikeouts)/(innings_pitched)+3.025



