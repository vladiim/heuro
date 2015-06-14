display.example <- function() {
  d <- data.frame(x = 1:1000, y = 1000:1)
  ggplot( d, aes( x = x, y = y ) ) + geom_point()
}