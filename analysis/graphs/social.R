graph.social <- function() {
  d    <- load.social()
  plot <- ggplot(d, aes(x = uvs, y = value_per_uv, label = co, color = co)) +
    geom_point(position = 'jitter', size = 4) +
    geom_text(aes(y = value_per_uv - 13), size = 3) +
    scale_x_log10(labels = comma, breaks = c(50000000, 100000000, 250000000, 500000000, 1000000000))
  graph.simpleTheme(plot) +
    scale_y_continuous(labels = dollar) +
    xlab('Monthly unique visitors (scale log10)') +
    ylab('Value per user')
}
