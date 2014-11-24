PageRank <- function(M, decay, quad.error = 1/10^5) {
  # This function calculates the PageRank of the hyperlink matrix H
  #
  # http://en.wikipedia.org/wiki/PageRank#Power_Method
  #
  # Inputs
  #  M: Hyperlink matrix where M(i,j) is the "vote" page i gives to page j
  #  decay: Value between 0 and 1
  #  quad.error: Error tolerance
  #
  #
  
  if (nrow(M) != ncol(M)) {
    stop("H must be square")
  } else if (decay <= 0 | decay > 1) {
    stop("decay must be between 0 and 1")
  }
  
  n <- nrow(M)
  v <- rep(1 / n, n)
  last.v <- rep(0, n)
  M.hat <- decay * M + (1- decay) * matrix(1 / n, nrow = n, ncol = n)
  iter <- 0
  
  while (sum(abs(v - last.v)) > quad.error) {
    last.v <- v
    v <- v %*% M.hat
    iter <- iter + 1
  }
  
  v <- v / sum(v)
  
  return(list(pr = v, iter = iter))
}