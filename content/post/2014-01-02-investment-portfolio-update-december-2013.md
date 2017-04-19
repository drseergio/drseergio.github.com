---
title: "Investment portfolio update - December 2013"
url: /blog/2014/01/02/investment-portfolio-update-december-2013/
date: "2014-01-02"
comments: true
tags: [investments]
categories: personal
---

### December's update

The R script does not work anymore! It turns out that Yahoo has disabled URL "charts.yahoo.com". However, "icharts.finance.yahoo.com" works fine. The problem is that the URL is hard coded into **quantmod** package.

The quick solution is to check-out latest code and build the package from source. The alternative is to wait until CRAN includes quantmod with the fix applied. Here's how I fixed the problem:

{{< highlight bash >}}

# check-out latest quantmod code using subversion
$ svn checkout svn://svn.r-forge.r-project.org/svnroot/quantmod/

# build and install the package from a local folder
$ R CMD INSTALL quantmod/pkg/

{{< /highlight >}}

As of **"2013-12-31"

{{< highlight bash >}}
     VBK      VBR      VTV
16.97135 16.93180 14.93496
{{< /highlight >}}

No changes in positions.

We avoid investing if price is below 10 month SMA. Running through 10-month SMA check we get:

{{< highlight bash >}}
  VBK  VBR  VTV
TRUE TRUE TRUE
{{< /highlight >}}

This means portfolio should be fully invested in **VBK**, **VBR**, **VTV**.

As of **"2013-12-31"

{{< highlight bash >}}
symbol        1          3          6           12           avg
VBK   2.50607661  7.5353908 19.5737192   38.270209   16.97134895
VBR   2.75432672  9.9108251 18.4982354   36.563815   16.93180053
VTV   2.09836942 10.1672916 14.3905361   33.083624   14.93495520
VEA   1.90709046  5.8674117 18.1740856   21.800117   11.93717618
VWO  -0.29083858  3.0819344  7.5274438   -4.944547    1.34349811
IGOV -0.07978458  0.1900000  4.9219814   -1.368380    0.91595429
GSG   1.35390428 -0.5867820  4.5129870   -1.829826    0.86257079
VCIT -0.48134777  0.6450043  1.9603008   -1.897983    0.05649348
VNQ   0.10854396 -0.8599509 -3.7136465    2.297576   -0.54186944
VGIT -1.43194335 -1.0426540 -0.5398539   -2.687587   -1.42550967
VGLT -2.00551133 -3.3665459 -5.4505170  -12.458972   -5.82038644
IAU  -3.70981039 -9.3871218 -2.5854879  -28.255528  -10.98448709
MTUM  2.68559699 11.8085305 17.7058824 -999.000000 -241.69999755
{{< /highlight >}}

\* Instruments that have insufficient data are penalized with large negative returns.

### Resources

 * [Original post explaining this strategy](/blog/2013/10/30/investment-portfolio-update-october-2013/)

 * [Investing for a living blog](http://investingforaliving.wordpress.com/)

 * [Alternative Ivy Portfolio tracking spreadsheet](https://docs.google.com/spreadsheet/ccc?key=0Ai0xPgGdCts3dEhZVUVXTFQtOEdsRUYwSmRLN3M0NHc&usp=sharing#gid=1)