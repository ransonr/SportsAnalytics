# PowerRanking = OAM - OOAM

data <- read.csv("GitHub/SportsAnalytics/data/NCAAM_2013_FullSeason.csv", header = TRUE, stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date, "%m/%d/%Y")

full <- merge(data, data, by.x = "Team", by.y = "Opponent")

teams <- vector(mode = "list", length = length(unique(data$Team)))
teams <- unique(data$Team)
dates <- unique(data$Date)

result <- vector(mode = "list", length = length(dates))
names(result) <- dates

for (i in 1:length(dates)) {
  temp <- data[data$Date <= dates[i], ] # Only use data up to the current date
  
  result[[dates[i]]] <- data.frame(
    Avg.Margin = sapply(unique(temp$Team), function(x) { mean(temp$Team.Score[temp$Team == x] - temp$Opponent.Score[temp$Team == x]) })
  )
}

results <- data.frame(
    Avg.Margin = sapply(teams, function(x) { mean(data$Team.Score[data$Team == x] - data$Opponent.Score[data$Team == x]) })
  )

# Need to exclude games against main team!
results$Opp.Avg.Margin1 <- sapply(teams, function(x) { sapply(data$Opponent[data$Team == x], function(y) { mean(data$Team.Score[data$Team == y] - data$Opponent.Score[data$Team == y]) })})


results$Opp.Avg.Margin <- sapply(teams, function(x) { mean(results$Avg.Margin[rownames(results) %in% data$Opponent[data$Team == x]]) })
results$Strength <- results$Avg.Margin + results$Opp.Avg.Margin

results[order(results$Strength, decreasing = TRUE), ]