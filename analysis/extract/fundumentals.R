extract.fundumentalsSocial <- function() {
  metrics <- yahooQF(c('Price/Sales', 'P/E Ratio', 'Market Capitalization'))
  tickers <- c('FB', 'TWTR')
  start   <- as.Date('2015-02-28')
  end     <- as.Date('2015-01-01')
  getQuote(paste(tickers, sep = '', collapse = ';'), what = metrics, from = start, to = end)
}
