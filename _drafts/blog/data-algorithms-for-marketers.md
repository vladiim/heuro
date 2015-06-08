start with RFM, show with RFM in R post
three metrics: purchase recency, frequency of purchase, and monetary value. By applying linear regression analysis to this data, marketers have tried to pinpoint the likelihood that a segment or cohort of customers would take a specific action (such as making a purchase)
http://www.sailthru.com/marketing-blog/predictive-intelligence-transforms-marketing-strategy/

Depending on the predictions you are looking to make, these time series may be attached to any of a variety of variables, such as the number of messages opened per day, clicks and even sign-up times. To be accurate, a predictive algorithm needs to look at dozens of these variables – again, over time – amassing hundreds of data points per user.

http://rayli.net/blog/data/top-10-data-mining-algorithms-in-plain-english/

http://joelcadwell.blogspot.com.au/2013/08/the-brand-as-affordance-item-response.html

https://highlyscalable.wordpress.com/2015/03/10/data-mining-problems-in-retail/

http://camdavidsonpilon.github.io/Probabilistic-Programming-and-Bayesian-Methods-for-Hackers/#contents

http://nikhilvithlani.blogspot.com.au/2012/03/apriori-algorithm-for-data-mining-made.html

https://www.countbayesie.com/blog/2015/4/25/bayesian-ab-testing

segmentation using bi plots: https://github.com/vqv/ggbiplot

http://www.quora.com/What-are-the-advantages-of-different-classification-algorithms/answer/Xavier-Amatriain?srid=3Tk0&share=1

talk a/b testing etc, break it down simply and have lots of graphs

give concrete examples of when a marketer would use it e.g. propensity modeling, 

maybe have code in js, rby, r to demonstrate it?

talk about features - give e.g. of changing customer address to distance to nearest store

below is from: http://blog.dato.com/how-to-evaluate-machine-learning-models-part-4-hyperparameter-tuning
 For instance, a linear regression model uses a line to represent the relationship between “features” and “target.” The formula looks like this:
wTx=y,
where x is a vector that represents features of the data and y is a scalar variable that represents the target (some numeric quantity that we wish to learn to predict).
This model assumes that that the relationship between x and y is linear. The variable w is a weight vector that represents the normal vector for the line; it specifies the slope of the line. This is what’s known as a model parameter, and it is learned during the training phase. “Training a model” involves using an optimization procedure to determine the best model parameter that “fits” the data. (Krishna’s blog post on Parallel SGD gives a great introduction on optimization methods for model training.)