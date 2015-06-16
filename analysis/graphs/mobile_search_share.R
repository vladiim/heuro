graphs.mobileSearchShare <- function() {
  d    <- load.mobileSearchShare()
  plot <- ggplot(d, aes(x = year, y = mobile, color = company)) +
    geom_line()
  graph.simpleTheme(plot) +
    scale_y_continuous(labels = percent) +
    ylab('% share of mobile search')
}