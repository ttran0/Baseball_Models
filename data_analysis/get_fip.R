get_fip <- function(data) {
  source('/Users/truong/Desktop/OneDrive/Baseball/PA_results.R')
  outcomes <- PA_results(data)
  hr <- length(outcomes[outcomes=='Home Run'])
  hr <- length(outcomes[outcomes=='Home Run'])
  hr <- length(outcomes[outcomes=='Home Run'])
  fip <- (13*sum(data$hr[x])+3*sum(data$walks[x])-2*sum(data$strikeouts[x]))/sum(data$innings_pitched[x])+3.1
  return(fip)
}