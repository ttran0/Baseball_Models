rm(list=ls())
states <- read.csv('/Users/truong/Desktop/OneDrive/Baseball/pbp/FelixHernandezstates_11.csv',header=F)
x = 1:dim(states)[2]
colnames(states) <- sprintf('pitch%s',as.character(x))
data <- read.csv('/Users/truong/Desktop/OneDrive/Baseball/FelixHernandez_11.csv')
fip <- read.csv('/Users/truong/Desktop/OneDrive/Baseball/pbp/FelixHernandezfip_11.csv')
fip <- fip[,2]
dates <- as.character(unique(data$date))
k <- 11#GAME K
game <- subset(data,data$date==dates[k])
indicator <- is.nan(as.numeric(states[k,]))*1
index <- which.max(indicator)-1
if (index == 0) {
  index = length(states[k,])
}

source('/Users/truong/Desktop/OneDrive/Baseball/pitches2order.R')
p <- pitches2order(game)
y <- rep(0,index)
y[(p+1):index] <- 1 
A <- data.frame(t(states[k,1:index]),(as.character(game$event)),(game$type=='S')*1,game$pitch_type,y,game$batter)
colnames(A) <- c('state','event','strike','type','3rd_time','batter')
print(fip[k])
source('/Users/truong/Desktop/OneDrive/Baseball/PA_results.R')
outcomes <- PA_results(game)
states_before2 <- states[k,1:p]
states_after2<-states[k, (p+1):index]
print(table(as.numeric(states_before2)))
print(table(as.numeric(states_after2)))

S <- c()
SE <- c()
S[1] <- A$state[1]
SE[1] <- as.character(A$event[1])
count <- 2
for (i in 2:dim(A)[1]) {
  
  if (A$batter[i] != A$batter[i-1]){
    S[count] <- A$state[i]
    SE[count] <- as.character(A$event[i])
    count <- count+1
  }
}
B <- data.frame(S,SE)

# state1 <-A$event[which(A$state==1)]
# state2 <-A$event[which(A$state==2)]
# state3 <-A$event[which(A$state==3)]

# source('/Users/truong/Desktop/OneDrive/Baseball/get_fip.R')
# FIP <- get_fip(game)
