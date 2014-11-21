library(XML)

relabelFootballDB <- function(df) {
  colnames(df) <- df[1,]
  colnames(df)[4:9] <- paste0("Pass.", colnames(df)[4:9])
  colnames(df)[10:13] <- paste0("Rush.", colnames(df)[10:13])
  colnames(df)[14:17] <- paste0("Rec.", colnames(df)[14:17])
  colnames(df)[18:19] <- paste0("Fumb.", colnames(df)[18:19])
  df <- df[-1,]
  
  return(df)
}

url <- "http://www.footballdb.com/fantasy-football/index.html?"

qb <- relabelFootballDB(readHTMLTable(paste0(url, "pos=QB&yr=2014&wk=1"), stringsAsFactors=FALSE)[[1]])
rb <- relabelFootballDB(readHTMLTable(paste0(url, "pos=RB&yr=2014&wk=1"), stringsAsFactors=FALSE)[[1]])
wr <- relabelFootballDB(readHTMLTable(paste0(url, "pos=WR&yr=2014&wk=1"), stringsAsFactors=FALSE)[[1]])
te <- relabelFootballDB(readHTMLTable(paste0(url, "pos=TE&yr=2014&wk=1"), stringsAsFactors=FALSE)[[1]])
k <- readHTMLTable(paste0(url, "pos=K&yr=2014&wk=1"), stringsAsFactors=FALSE)[[1]]
dst <- readHTMLTable(paste0(url, "pos=DST&yr=2014&wk=1"), stringsAsFactors=FALSE)[[1]]