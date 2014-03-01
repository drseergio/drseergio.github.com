---
layout: post
title: "Investment portfolio update February 2014"
date: 2014-03-01 07:44
comments: true
categories: investments
---

### February's update

As of **2014-02-28** the best performing instruments are:

{% codeblock %}
     VBK      VBR      VTV
16.14136 14.18598 10.67624
{% endcodeblock %}

No changes to positions since last month.

We avoid investing if price is below 10 month SMA. Running through 10-month SMA check we get:

{% codeblock %}
  VBK  VBR  VTV
TRUE TRUE TRUE
{% endcodeblock %}

This means portfolio should be fully invested in **VBK**, **VBR**, **VTV**.

As of **2014-02-28** the calculated returns for each instrument are presented below(*):

{% codeblock %}
symbol        1          3          6           12           avg
VBK  5.1364764  6.5375911 18.639164   34.2522180   16.1413623
VBR  4.9651384  4.8543689 18.102936   28.8214702   14.1859784
VTV  3.9690091  2.2320235 12.833751   23.6701698   10.6762384
VEA  5.9478613  2.3471883 14.653520   19.1913440   10.5349783
VNQ  5.0653595  9.6759187 12.394724    6.7461515    8.4705385
IGOV 2.2063208  2.6859710  5.933251    3.9838220    3.7023412
VCIT 1.2357414  2.7992278  5.445545    1.2116892    2.6730508
GSG  4.7966963  3.8727960 -1.669151    1.3829133    2.0958138
VGLT 0.5016969  4.5754645  3.447752   -5.0069735    0.8794850
VGIT 0.2986013  0.5356018  2.226494   -0.8544353    0.5515654
VWO  3.2386514 -5.7440620  4.514915   -8.0397257   -1.5075552
IAU  6.4623032  5.9356966 -5.025868  -16.3955758   -2.2558611
MTUM 6.7189632  7.0475539 20.069071 -999.0000000 -241.2911029
{% endcodeblock %}

\* Instruments that have insufficient data are penalized with large negative returns.

### Resources

 * [Original post explaining this strategy](/blog/2013/10/30/investment-portfolio-update-october-2013/)

 * [Investing for a living blog](http://investingforaliving.wordpress.com/)

 * [Alternative Ivy Portfolio tracking spreadsheet](https://docs.google.com/spreadsheet/ccc?key=0Ai0xPgGdCts3dEhZVUVXTFQtOEdsRUYwSmRLN3M0NHc&usp=sharing#gid=1)