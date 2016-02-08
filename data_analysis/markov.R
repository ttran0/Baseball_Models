rm(list=ls())
p <- c(1,1/2,0)
A <- matrix(c(0,0,1,1,0,0,0,1,0),ncol=3,nrow=3)
b <- c(1,0,0)

x<-matrix(data=NA,ncol=400,nrow=3)
y<-c()
# (data=NA,nrow=length(player$pitch1),ncol=total)
# for (i in 1:100) {
#   x <-c(x,rmultinom(1,1,c(1/3,1/3,1/3)))
# }
Y <- matrix(data=NA, ncol= 400, nrow=10000)
for (j in 1:10000) {
  x[,1] <- rmultinom(1,1,c(1/3,1/3,1/3))
  index <- which(x[,1] %in% 1)
  y[1] <- rbinom(1,1,p[index])
  for (i in 2:400) {
    x[,i] <- rmultinom(1,1,A[index,])
    index <- which(x[,i] %in% 1)
    y[i] <- rbinom(1,1,p[index])
    # z[i] <- rmultinom(1,1,A[3,])
    
  }
  Y[j,] <- t(y)
}



# probs <- c(data=0,ncol=400,nrow=1)
# for (k in 1:10000) {
#   probs <- Y[k,]+probs
# }
# print(probs/10000)


# T <- diag(3)
# proby<-c()
# proby[1] <- 1/3*1/5+1/3*1/3+2/7*1/3
# for (i in 2:400) {
#   T <- T %*% A
#   probz <- b%*%T
#   proby[i] <-1/5 *probz[1] +1/3*probz[2] + 2/7*probz[3]
# }


source('~/Desktop/OneDrive/Baseball/pbp/binomtest.R')
# pvals <- binomtest(Y,probs/10000)
