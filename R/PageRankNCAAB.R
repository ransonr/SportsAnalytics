# PageRank Algorithm for Ranking NCAA Basketball Teams
#
# 
#

games <- read.csv("GitHub/SportsAnalytics/data/NCAAM_2013_FullSeason.csv", header = TRUE, stringsAsFactors = FALSE)
games$Date <- as.Date(games$Date, "%m/%d/%Y")

teams <- unique(games$Team)