binomtest <- function (Y,prob) {
  
  total <- dim(Y)[2]
  # for (j in 1:dim(Y)[1]) {
  #   game <- Y[j,1:total]
  #   # pitches <- game[!is.na(game)]
  q <- c()
  x <- c()
  z <- c()
  pvals <- c()
  Z <- matrix(data=NA,nrow=dim(Y)[1],ncol=dim(Y)[2])
  for (i in 1:dim(Y)[1]){
    y <- Y[i,]
    for (j in 1:total) {
      if (prob[j]<=1/2) {
        q[j] <- 1-1/(2*(1-prob[j]))
        x[j] <- rbinom(1,1,q)
        z[j] <- max(x[j],as.numeric(y[j]))
        # print((1-q[i])*(1-prob[i]))
      } else {
        q[j] <- 1/(2*prob[j])
        x[j] <- rbinom(1,1,q)
        # print(prob[i]*q[i])
        z[j] <- min(x[j],as.numeric(y[j]))
      }
    }
    pvals[i] <- (Box.test(z,lag=10,type=("Box-Pierce")))[3]
    # pvals[j] <- (binom.test(sum(z),total,0.5))[[3]]
    Z[i,] <- z
  }

print(sum(pvals<0.1))
return(pvals)
}