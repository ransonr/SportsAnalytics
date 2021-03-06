# PowerRanking = OAM - OOAM

#library(TTR)

games <- read.csv("GitHub/SportsAnalytics/data/NCAAM_2013_FullSeason.csv", header = TRUE, stringsAsFactors = FALSE)
games$Date <- as.Date(games$Date, "%m/%d/%Y")

teams <- unique(games$Team)

results <- data.frame(
    Avg.Margin = sapply(teams, function(x) { mean(games$Team.Margin[games$Team == x]) }),
    Opp.Avg.Margin = sapply(teams, function(x) {
      opponents <- games$Opponent[games$Team == x];
      mean(sapply(opponents, function(y) { mean(games$Team.Margin[games$Team == y & games$Opponent != x])}))
    }),
    Win.Rate = sapply(teams, function(x) { sum(games$Team.Margin[games$Team == x] > 0) / sum(games$Team == x) }),
    Opp.Win.Rate = sapply(teams, function(x) {
      opponents <- games$Opponent[games$Team == x];
      mean(sapply(opponents, function(y) { sum(games$Team.Margin[games$Team == y & games$Opponent != x] > 0) / sum(games$Team == y & games$Opponent != x)}))
    })
  )

results$Strength <- results$Avg.Margin + results$Opp.Avg.Margin

results <- results[order(results$Strength, decreasing = TRUE), ]

print(head(results, 25))