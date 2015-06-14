data.rfmGenOrderData <- function() {
  set.seed(100)
  data.frame(
    id      = sample(c(1:2000), 10000, replace = TRUE),
    product = sample(c('a', 'b', 'c', 'd'), 10000, replace = TRUE),
    cust_id = sample(c(1:500), 10000, replace = TRUE),
    date    = as.Date(sample((1:100), 10000, replace = TRUE), origin = '2015-01-01')
  )
}

data.rfmGenOrderSum <- function() {
  d <- data.rfmGenOrderData()
  dcast(d, id + cust_id + date ~ product, fun.aggregate = length)
}

data.rfmGenOrderRF <- function() {
  today = Sys.Date()
  data.rfmGenOrderSum() %>%
    group_by(cust_id) %>%
    mutate(frequency = n(), recency = as.numeric(today - date))
}