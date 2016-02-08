rm(list=ls())
year <- c('09','10','11','12','15')
# year <- c('11') 
outliers <- data.frame()
A<-data.frame()
hr9 <- data.frame()
hr9_before <- data.frame()
hr9_after <- data.frame()
for (i in 1:length(year)) {
  
  data <- read.csv(sprintf('data%s.csv',year[i]))

  diff <- data$WHIP_after-data$WHIP_before
  whip_z<- (diff-mean(diff))/sd(diff)
  
  diff <- data$FIP_after - data$FIP_before
  fip_z <- (diff-mean(diff))/sd(diff)
  
  diff <- data$xFIP_after - data$xFIP_before
  xfip_z <- (diff-mean(diff))/sd(diff)
  
  diff <- data$wOBA_after - data$wOBA_before
  wOBA_z <- (diff-mean(diff))/sd(diff)
  
  diff <- data$FIP_after - data$FIP_before
  fip_z <- (diff-mean(diff))/sd(diff)
  
  hr9_before <- data$hr_before*9/data$innings_pitched_before
  hr9_after <- data$hr_after*9/data$innings_pitched_after
  
  hr9 <- data$hr*9/data$innings_pitched
  
  
  Z <- data.frame(data$Pitcher, whip_z,fip_z,xfip_z,wOBA_z)
  # index <- which((Z$fip_z>= 1.28) | (Z$fip_z <= -1.28))
  index <- which(data$FIP_after-data$FIP_before>0)
  outliers <- rbind(outliers,data.frame(data$Pitcher[index], Z$fip_z[index], data$FIP_before[index], data$FIP_after[index],data$FIP_after[index]-data$FIP_before[index],hr9_before[index],hr9_after[index],hr9[index],data$strikeoutsper9_before[index],data$strikeoutsper9_after[index],data$strikeoutsper9_after[index]-data$strikeoutsper9_before[index],data$avg_fast[index]>=91, rep(year[i],length(index))))
  

  
  x <- which(data$avg_fast>=90)
  y <- 1:length(data$FIP_before)
  z<-sort(c(setdiff(x,y),setdiff(y,x)))
 
  
  whip_before_fast <- (sum(data$hits_before[x])+sum(data$walks_before[x]))/sum(data$innings_pitched_before[x])
  whip_after_fast <- (sum(data$hits_after[x])+sum(data$walks_after[x]))/sum(data$innings_pitched_after[x])
  whip_before_nofast <- (sum(data$hits_before[z])+sum(data$walks_before[z]))/sum(data$innings_pitched_before[z])
  whip_after_nofast <- (sum(data$hits_after[z])+sum(data$walks_after[z]))/sum(data$innings_pitched_after[z])
  
  s9_before_fast <- sum(data$strikeouts_before[x])*9/sum(data$innings_pitched_before[x])
  s9_before_nofast <- sum(data$strikeouts_before[z])*9/sum(data$innings_pitched_before[z])
  s9_after_fast <- sum(data$strikeouts_after[x])*9/sum(data$innings_pitched_after[x])
  s9_after_nofast <- sum(data$strikeouts_after[z])*9/sum(data$innings_pitched_after[z])
  
  fip_before_fast <- (13*sum(data$hr_before[x])+3*sum(data$walks_before[x])-2*sum(data$strikeouts_before[x]))/sum(data$innings_pitched_before[x])+3.1
  fip_before_nofast <- (13*sum(data$hr_before[z])+3*sum(data$walks_before[z])-2*sum(data$strikeouts_before[z]))/sum(data$innings_pitched_before[z])+3.1
  
  fip_after_fast <- (13*sum(data$hr_after[x])+3*sum(data$walks_after[x])-2*sum(data$strikeouts_after[x]))/sum(data$innings_pitched_after[x])+3.1
  fip_after_nofast <- ( 13*sum(data$hr_after[z])+3*sum(data$walks_after[z])-2*sum(data$strikeouts_after[z]))/sum(data$innings_pitched_after[z])+3.1
  
  
  
  wOBA_before_fast <- (0.72*sum(data$walks_before[x])+0.75*sum(data$HBP_before[x])+0.9*sum(data$singles_before[x])+1.24*sum(data$doubles_before[x])+1.56*sum(data$triples_before[x])+1.95*sum(data$hr_before[x]))/sum(data$PA_before[x])
  wOBA_before_nofast <- (0.72*sum(data$walks_before[z])+0.75*sum(data$HBP_before[z])+0.9*sum(data$singles_before[z])+1.24*sum(data$doubles_before[z])+1.56*sum(data$triples_before[z])+1.95*sum(data$hr_before[z]))/sum(data$PA_before[z])
  
  wOBA_after_fast <- (0.72*sum(data$walks_after[x])+0.75*sum(data$HBP_after[x])+0.9*sum(data$singles_after[x])+1.24*sum(data$doubles_after[x])+1.56*sum(data$triples_after[x])+1.95*sum(data$hr_after[x]))/sum(data$PA_after[x])
  wOBA_after_nofast <- (0.72*sum(data$walks_after[z])+0.75*sum(data$HBP_after[z])+0.9*sum(data$singles_after[z])+1.24*sum(data$doubles_after[z])+1.56*sum(data$triples_after[z])+1.95*sum(data$hr_after[z]))/sum(data$PA_after[z])
  
  
  
  hr9_before_fast <- sum(data$hr_before[x])*9/sum(data$innings_pitched_before[x])
  hr9_before_nofast <- sum(data$hr_before[z])*9/sum(data$innings_pitched_before[z])
  hr9_after_fast <- sum(data$hr_after[x])*9/sum(data$innings_pitched_after[x])
  hr9_after_nofast <- sum(data$hr_after[z])*9/sum(data$innings_pitched_after[z])
  
  
  walks9_before_fast <- sum(data$walks_before[x])*9/sum(data$innings_pitched_before[x])
  walks9_before_nofast <- sum(data$walks_before[z])*9/sum(data$innings_pitched_before[z])
  walks9_after_fast <- sum(data$walks_after[x])*9/sum(data$innings_pitched_after[x])
  walks9_after_nofast <- sum(data$walks_after[z])*9/sum(data$innings_pitched_after[z])
  
  A <- rbind(A,data.frame(year[i],whip_before_fast,whip_after_fast,whip_before_nofast,whip_after_nofast,fip_before_fast,fip_after_fast,fip_before_nofast,fip_after_nofast,wOBA_before_fast,wOBA_after_fast,wOBA_before_nofast,wOBA_after_nofast,s9_before_fast,s9_after_fast,s9_before_nofast,s9_after_nofast,hr9_before_fast,hr9_after_fast,hr9_before_nofast,hr9_after_nofast, walks9_before_fast,walks9_after_fast,walks9_before_nofast,walks9_after_nofast))
  
  
}
colnames(outliers) <- c('name','z_score','fip_before','fip_after','diff_fip','hr9_before','hr9_after','hr9','s9_before','s9_after','diff_so','fast','year')
outliers <- outliers[order(outliers$year), ]
outliers_1<- subset(outliers,(outliers$diff_fip>0 & outliers$diff_so<0))
# outliers_1<-outliers_1[order(outliers_1$fast), ]
