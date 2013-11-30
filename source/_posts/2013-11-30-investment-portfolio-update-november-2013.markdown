---
layout: post
title: "Investment portfolio update - November 2013"
date: 2013-11-30 09:28
comments: true
categories: investments
---

### Novembers's update**

As of **2013-11-30** the best performing instruments are:

{% codeblock %}
     VBK      VBR      VTV
16.93042 16.68999 14.38888
{% endcodeblock %}

Last month's VEA's position has been taken by VTV.

We avoid investing if price is below 10 month SMA. Running through 10-month SMA check we get:

{% codeblock %}
  VBK  VBR  VTV
TRUE TRUE TRUE
{% endcodeblock %}

This means portfolio should be fully invested in **VBK**, **VBR**, **VTV**.

As of **2013-11-30** the calculated returns for each instrument are presented below(*):

{% codeblock %}
symbol        1          3          6           12           avg
VBK   2.3614663  11.351201 15.5519199   38.4571033   16.93042264
VBR   2.9323950  12.637106 13.8594008   37.3310570   16.68998975
VTV   3.1785176  10.376667 10.8967751   33.1035702   14.38888252
VEA   0.6609547  12.043597 12.7502056   24.6060606   12.51520442
VWO  -0.9314545  10.879444  2.0418204    2.0669291    3.51418476
IGOV -1.0908019   3.167282  2.6517083   -0.6808763    1.01182796
VCIT -0.1190193   2.579147 -0.6275903   -1.5832063    0.06233274
VGIT -0.2032838   1.672774 -0.5919003   -1.8153846   -0.23444878
VNQ  -5.2509764   2.487874 -5.7146970    6.0042078   -0.61839801
GSG  -0.4700721  -5.335320  3.0834145   -3.6407767   -1.59068868
VGLT -2.3997615  -1.072670 -6.8165647  -12.6234321   -5.72810697
IAU  -5.6031128 -10.347376 -9.8811293  -27.2781775  -13.27744894
MTUM  3.1469761  12.179732 13.6795195 -999.0000000 -242.49844303
{% endcodeblock %}

\* Instruments that have insufficient data are penalized with large negative returns.

### Resources

 * [Original post explaining this strategy](/blog/2013/10/30/investment-portfolio-update-october-2013/)

 * [Investing for a living blog](http://investingforaliving.wordpress.com/)

 * [Alternative Ivy Portfolio tracking spreadsheet](https://docs.google.com/spreadsheet/ccc?key=0Ai0xPgGdCts3dEhZVUVXTFQtOEdsRUYwSmRLN3M0NHc&usp=sharing#gid=1)