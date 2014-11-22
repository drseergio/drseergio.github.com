---
layout: post
title: "Investment portfolio update April 2014"
date: 2014-04-30 19:55
comments: true
categories: investments
---

### April update

As of **2014-04-29** the best performing instruments are:

{% codeblock %}
     VTV      VBR      VEA
9.237548 8.128931 6.267076
{% endcodeblock %}

VEA has replaced VBK as one of the instruments.

We avoid investing if price is below 10 month SMA. Running through 10-month SMA check we get:

{% codeblock %}
  VTV  VBR  VEA
TRUE TRUE TRUE
{% endcodeblock %}

This means portfolio should be fully invested in **VBK**, **VBR**, **VEA**.

As of **2014-04-29** the calculated returns for each instrument are presented below(*):

{% codeblock %}
symbol        1          3          6           12           avg
VTV   0.5633082  7.3674139  8.93080017  20.0886715  9.2375484
VBR  -1.7885533  4.4378698  7.38809213  22.4783147  8.1289309
VEA   1.2599952  6.9071374  3.95522388  12.9459459  6.2670756
MTUM -1.7567120  1.2640929  4.75349002  15.8264947  5.0218414
GSG   1.5771914  6.3850064  4.95142589   7.0310003  4.9861560
VNQ   2.9170207  8.6722488  7.46710040   0.5534034  4.9024433
VBK  -4.3306770 -1.6793514  1.98215205  20.1961974  4.0420803
IGOV  0.9627541  3.4166750  2.76155597   3.3137626  2.6136869
VCIT  0.7669617  2.0188747  3.46498667  -0.2103295  1.5101234
VWO   0.9610646  9.0497738 -1.34842283  -3.5319049  1.2826277
VGLT  1.4065934  2.6397746  4.24762765  -6.5235008  0.4426237
VGIT  0.2688597 -0.1260239 -0.07880221  -2.2057689 -0.5354338
IAU   0.9646302  4.0596520 -2.25680934 -12.4738676 -2.4265987
{% endcodeblock %}

\* Instruments that have insufficient data are penalized with large negative returns.

### Resources

 * [Original post explaining this strategy](/blog/2013/10/30/investment-portfolio-update-october-2013/)

 * [Investing for a living blog](http://investingforaliving.wordpress.com/)

 * [Alternative Ivy Portfolio tracking spreadsheet](https://docs.google.com/spreadsheet/ccc?key=0Ai0xPgGdCts3dEhZVUVXTFQtOEdsRUYwSmRLN3M0NHc&usp=sharing#gid=1)