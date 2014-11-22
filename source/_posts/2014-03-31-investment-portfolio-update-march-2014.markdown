---
layout: post
title: "Investment portfolio update March 2014"
date: 2014-03-31 17:06
comments: true
categories: investments
---

### March update

As of **2014-03-31** the best performing instruments are:

{% codeblock %}
     VTV      VBR      VBK
9.185716 8.977934 6.721709
{% endcodeblock %}

No changes to positions since last month.

We avoid investing if price is below 10 month SMA. Running through 10-month SMA check we get:

{% codeblock %}
  VTV  VBR  VBK
TRUE TRUE TRUE
{% endcodeblock %}

This means portfolio should be fully invested in **VBK**, **VBR**, **VTV**.

As of **2014-03-31** the calculated returns for each instrument are presented below(*):

{% codeblock %}
symbol        1          3          6           12           avg
VTV   1.73547200  1.855995788 12.2262509  20.9251446  9.18571581
VBR  -0.34225891  1.694915254 11.7759964  22.7830832  8.97793399
VBK  -3.79258793 -0.008177952  7.5184664  23.1691347  6.72170880
MTUM -4.53819112 -0.483091787 11.2683926  18.6258936  6.21825082
VEA  -0.91743119 -0.484966052  5.3658537  16.7235495  5.17175148
VNQ  -0.34153978  9.183037106  8.2380216   3.4111045  5.12265588
IGOV  0.20443925  2.971188475  3.1672848   4.6887714  2.75792096
VGLT  0.88326218  7.666928515  4.0382572  -4.0599188  2.13213227
VCIT -0.14120970  3.160709944  3.8169807   0.6881822  1.88116579
GSG  -0.03031222  2.454178316  1.8529957   0.2431611  1.13000572
VWO   3.84119618 -1.827930782  1.1806079  -3.2660903 -0.01805425
VGIT -0.73737057  1.264404609  0.2058917  -1.7546584 -0.25543317
IAU  -2.49027237  7.277397260 -2.7928627 -19.2654639 -4.31780043
{% endcodeblock %}

\* Instruments that have insufficient data are penalized with large negative returns.

### Resources

 * [Original post explaining this strategy](/blog/2013/10/30/investment-portfolio-update-october-2013/)

 * [Investing for a living blog](http://investingforaliving.wordpress.com/)

 * [Alternative Ivy Portfolio tracking spreadsheet](https://docs.google.com/spreadsheet/ccc?key=0Ai0xPgGdCts3dEhZVUVXTFQtOEdsRUYwSmRLN3M0NHc&usp=sharing#gid=1)