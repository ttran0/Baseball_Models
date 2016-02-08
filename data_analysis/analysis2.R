dat <- read.csv('data11.csv')
effectfip <- subset(dat,dat$FIP_before<dat$FIP_after)
effectwOBA <- subset(dat,dat$wOBA_before < dat$wOBA_after)
group <- intersect(effectfip$Pitcher,effectwOBA$Pitcher)