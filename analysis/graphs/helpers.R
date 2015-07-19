# ---------- HELPERS

graph.simpleTheme <- function(plot) {
  pallet = colorRampPalette(brewer.pal(4, 'Set1'))(10)
  graph.simpleThemeMoreColors(plot) +
    scale_colour_manual(values = pallet) +
    scale_fill_manual(values = pallet )
}

graph.simpleThemeMoreColors <- function(plot) {
  plot +
    scale_y_continuous(labels = comma) +
    theme_bw() + xlab('') + ylab('') +
    theme(axis.text.x           = element_text(angle = 45, hjust = 1)) +
    theme(panel.grid.major.x    = element_blank(),
          panel.grid.major.y    = element_blank(),
          panel.grid.minor.y    = element_blank())
}

# ---------- GRAPH TYPES

graph.dateLine <- function(plot) {
  plot <- plot +
    geom_line() +
    scale_x_date(labels = date_format('%b-%y'), breaks = date_breaks('months'), minor_breaks = date_breaks('1 week'))
  graph.simpleTheme(plot)
}

graph.dateBar <- function(plot) {
  plot <- plot +
    geom_bar(stat = 'identity', position = 'dodge') +
    scale_x_date(labels = date_format('%b-%y'), breaks = date_breaks('months'), minor_breaks = date_breaks('1 week'))
  graph.simpleTheme(plot)
}

graph.flippedBar <- function(plot) {
  plot <- plot +
    geom_bar(stat = 'identity', position = 'dodge') +
    coord_flip()
  graph.simpleTheme(plot)
}
