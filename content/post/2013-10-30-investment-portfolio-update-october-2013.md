---
title: "Investment portfolio update - October 2013"
url: /blog/2013/10/30/investment-portfolio-update-october-2013/
date: "2013-10-30"
comments: true
tags: [investments]
categories: personal
---

Investments are a cornerstone for building passive income, increasing wealth and eventually reaching financial independence. I have passion for learning how the investment world functions and what are the different trading strategies. For the past 4 years I have mostly relied on low-cost index investments and company stock in distressed industries. In addition, I have had lots of interest towards quantitative strategies.

A couple of months ago I have faced a possibility of a major change in life so I have liquidated every investment into cash in preparation for it. The change never came. After reflecting upon my limited trading experience I have realized that I don't have a coherent strategy and I am likely to fall for the many biases and traps, namely:

* Confirmation bias. Unless I'm doing trading (real or on paper) my brain is likely to pick-up just the positive examples of an investment strategy.

* No single coherent idea or strategy. I have been fascinated by many tools, strategies and approaches. I have spent many hours translating ideas or systems in code that I can run to verify results. When I am chasing so many options I never arrive at anything satisfying and conclusive.

* Not believing into one's own approach. Somewhat related to the previous point. Unless I'm confident in a chosen strategy I am likely not to invest timely. This means I miss many gains and lose more often because I pull out prematurely.

* Lack of free quality market data. Together with a friend I have written a convoluted system to buy and sell company stock around major price shocks. The system demonstrated fantastic results. However, I have realized that the price data does not include companies that went bankrupt. Such omissions make back-testing overly optimistic.

* Lack of desire to dedicate lots of time. I won't last forever and I want to use the opportunity to live my life fully. There is unlimited amount of market information to understand and make use of. Onwards, I consciously choose not to spend all my spare time on investments.

### Investment strategy of choice

To overcome the concerns I have made a decision to consistently follow a strategy that I accept consciously and intellectually. The strategy is called "Ivy Portfolio". There are several variations of this strategy and it boils down to holding about 5 diversified instruments when their prices are above a certain threshold. I recommend reading resources I've linked to at the bottom of this post.

What appeals to me in this strategy is its simplicity and ability to reduce draw-downs in down markets. I will allocate 80% of my portfolio in Ivy Portfolio. The rest is going to be invested in individual companies and experimental quantitative strategies.

Once a month I will spend about 2-6 hours on maintaining my investment portfolio and sharing findings on this site. I will calculate and update signals for the past month, aggregate quarterly performance figures, test alternative strategies and publish results. I consciously impose a limit so that I don't end-up aimlessly procrastinating. I will need to set clear goals and boundaries if I want to fit in the limits.

### Strategy details

There are several variations of the Ivy Portfolio strategy. The one that appeals to me is called "TOP 3 GTAA 13". First, one needs to choose 13 instruments that represent different kinds of assets. I have made a choice of the following instruments:

 - **VTV** - Vanguard Value ETF (US Large Cap Value)
 - **MTUM** - iShares MSCI USA Momentum Factor (US Large Cap Momentum)
 - **VBR** - Vanguard Small Cap Value ETF (US Small Cap Value)
 - **VBK** - Vanguard Small Cap Growth ETF (US Small Cap Momentum)
 - **VEA** - Vanguard FTSE Developed Markets ETF (Foreign Developed)
 - **VWO** - Vanguard FTSE Emerging Markets ETF (Foreign Emerging)
 - **VGIT** - Vanguard Interm-Tm Govt Bd Idx ETF (US 10 Year Government Bonds)
 - **IGOV** - iShares International Treasury Bond (Foreign 10 Year Government Bonds)
 - **VCIT** - Vanguard Interm-Tm Corp Bd Idx ETF (US Corporate Bonds)
 - **VGLT** - Vanguard Long-Term Govt Bd Idx ETF (US 30 Year Government Bonds)
 - **GSG** - iShares S&P GSCI Commodity-Indexed Trust (Commodities)
 - **IAU** - iShares Gold Trust (Gold)
 - **VNQ** - Vanguard REIT Index ETF (NAREIT Index)

The goal is to find representative ETFs with lowest expenses and higher liquidity. On the last trading day of a month performance of each instrument is compared. 3 best performing instruments are bought. The cycle is repeated every month. Portfolio is rebalanced to maintain correct ratios.

It does not matter what tool you use to calculate the results. I prefer R so I have written few functions to do the calculation for me. I present the code below. I assume you have R installed along with the "quantmod" package. By default, quantmod relies on Yahoo! Finance as the source for price data.

{{< highlight R >}}
> require(quantmod)
> end <- '"2013-10-30"
> instruments <- c('VTV', 'MTUM', 'VBR', 'VBK', 'VEA', 'VWO', 'VGIT', 'IGOV', 'VCIT', 'VGLT', 'GSG', 'IAU', 'VNQ') # instruments we have chosen before
> retFunc <- function(X, returns) {
  if (X > nrow(returns)) {
    return(-999)
  } else {
    return((prod(returns[paste(index(returns[1+nrow(returns)-X]), '::', end, sep='')]+1) - 1) * 100)
  }
} # function calculates return for a given X-month period, returns -999 if not enough data is available
> getAvgRet <- function(instrument, end=end) {
  prices <- getSymbols(instrument, auto.assign=FALSE)
  returns <- monthlyReturn(Ad(prices))[paste('"2001-01-01"
  return(mean(sapply(c(1,3,6,12), FUN=retFunc, returns=returns)))
} # function calculates an average of returns for an instrument for the last 1, 3, 6, 12 months
> topInstruments <- function(results) {
  ndx <- order(results, decreasing=T)[1:3]
  return(results[ndx])
} # function returns top 3 instruments
> checkSMA <- function(instrument) {
  prices <- Ad(getSymbols(instrument, auto.assign=FALSE))
  return(tail(prices, n=1) > SMA(prices, n=200))
} # verifies if current instrument price is above 10-month SMA
> results <- topInstruments(sapply(instruments, FUN=getAvgRet, end=end))
> sapply(names(results), FUN=checkSMA)
> retTable <- function(instruments, end) {
  calcRow <- function(instrument, end=end) {
    prices <- getSymbols(instrument, auto.assign=FALSE)
    returns <- monthlyReturn(Ad(prices))[paste('"2001-01-01"
    return(sapply(c(1,3,6,12), FUN=retFunc, returns=returns))
  }

  tempTable <- sapply(instruments, FUN=calcRow, end=end)
  tempTable <- rbind(tempTable, colMeans(tempTable))
  tempTable <- t(tempTable)

  colnames(tempTable) <- c('1','3','6','12','avg')
  return(tempTable[order(tempTable[,5], decreasing=T),])
} # function to print returns for all instruments
{{< /highlight >}}

The output of the function returns names of top 3 instruments and whether they should be invested in. "checkSMA" will cause a failure if an instrument does not have enough past trading data.

### October's update**

As of **"2013-10-30"

{{< highlight bash >}}
     VBK      VBR      VEA
18.03609 15.64619 13.12281
{{< /highlight >}}

We avoid investing if price is below 10 month SMA. Running through 10-month SMA check we get:

{{< highlight bash >}}
 VBK  VBR  VEA
TRUE TRUE TRUE
{{< /highlight>}}

This means portfolio should be fully invested in **VBK**, **VBR**, **VEA**.

As of **"2013-10-30"

{{< highlight bash >}}
symbol        1         3          6           12          avg
VBK   4.1411847  8.432639 19.7628856   39.8076472   18.0360891
VBR   5.0531915  6.004696 15.3004135   36.2264693   15.6461927
VEA   4.1182415 10.482574  9.6302208   28.2601930   13.1228073
VTV   5.4878922  3.939009 11.2084592   29.1578947   12.4483138
VWO   5.5569399  9.344347 -1.0742644    5.5569399    4.8459906
VNQ   6.0326580  2.066657 -5.0886453   13.2041969    4.0537167
IGOV  1.8086058  3.989038  0.9658027   -0.0390282    1.6811045
GSG  -0.8956146 -1.382913  2.5567274   -1.0789149   -0.2001789
VCIT  1.5943419  1.789575 -3.2202809   -0.9929907   -0.2073387
VGIT  0.7220217  1.182592 -2.0155749   -0.8651321   -0.2440233
VGLT  1.6029963  1.208775 -9.8378091   -8.9297704   -3.9889521
IAU   1.3188518  1.555210 -8.9895470  -22.0763723   -7.0479644
MTUM  6.4959169  5.789086 11.5257532 -999.0000000 -243.7973111
{{< /highlight >}}

\* Instruments that have insufficient data are penalized with large negative returns.

\*\* Ideally the analysis must be performed at the close of the last trading day of the month, however, due to personal reasons this won't be possible every month. This is also why I do it today, rather than on "2013-10-31"

### Resources

 * [The updated paper on Ivy Portfolio by Mebane Faber](http://www.mebanefaber.com/2013/06/14/qtaa-update-conclustions-and-faqs/)

 * ["Ivy Portfolio" book by Mebane Faber (amazon)](http://www.amazon.com/The-Ivy-Portfolio-Endowments-Markets/dp/1118008855)

 * [Early retiree's blog on investments, including strong focus on Ivy Portfolio](http://investingforaliving.wordpress.com/)

   - [An IVY Buy & Hold Portfolio for the Skeptical & Emotional Investor](http://investingforaliving.wordpress.com/2013/09/20/an-ivy-buy-hold-portfolio-for-the-skeptical-emotional-investor/)

   - [What’s up with the recent poor performance of IVY?](http://investingforaliving.wordpress.com/2013/08/05/whats-up-with-the-recent-poor-performance-of-ivy/)

   - [IVY portfolio summary: fees, commissions, and taxes](http://investingforaliving.wordpress.com/2013/07/26/ivy-portfolio-summary-fees-commissions-and-taxes/)

   - [IVY Portfolio Summary: returns, risk, & SWRs](http://investingforaliving.wordpress.com/2013/07/21/ivy-portfolio-summary-returns-risk-swrs/)

   - [IVY timing model extensions – weightings & momentum](http://investingforaliving.wordpress.com/2013/07/15/ivy-timing-model-extensions-weightings-momentum/)

   - [IVY Timing Model Extensions – more asset classes](http://investingforaliving.wordpress.com/2013/07/13/ivy-timing-model-extensions-more-asset-classes/)