---
layout: post
title: "Investment portfolio update June 2014"
date: 2014-07-01 05:36
comments: true
categories: investments
---

### June update

As of **2014-06-30** the best performing instruments are:

{% codeblock %}
      VBR       VNQ      MTUM
11.486434  9.813685  9.438370
{% endcodeblock %}

Note the change in instruments.

We avoid investing if price is below 10 month SMA. Running through 10-month SMA check we get:

{% codeblock %}
  VBR  VNQ MTUM
TRUE TRUE TRUE
{% endcodeblock %}

This means portfolio should be fully invested in **VBR**, **VNQ**, **MTUM**.

As of **2014-06-30** the calculated returns for each instrument are presented below(*):

{% codeblock %}
symbol        1          3          6           12           avg
VBR   4.3211708 4.829094  8.371854 28.423615 11.486434
VNQ   1.1351351 6.960126 17.765539 13.393939  9.813685
MTUM  2.0651823 5.170407  5.892200 24.625690  9.438370
VBK   5.8144364 2.543669  4.178934 24.562433  9.274868
VTV   1.9136346 4.209578  7.161769 22.577226  8.965552
VEA   1.0438909 4.438450  4.515337 23.520882  8.379640
VWO   3.1818182 7.315253  6.153089 14.130722  7.695220
IAU   6.1830173 3.536977 10.273973  7.422852  6.854205
VGLT -0.1407658 4.461788 12.282368  6.165819  5.692302
GSG   2.3845457 2.881407  5.374340 10.129870  5.192541
IGOV  1.2115385 2.592593  5.661514 10.870023  5.083917
VCIT  0.1504107 2.680902  6.078431  8.145927  4.263918
VGIT -0.1404275 1.474552  2.794732  2.252756  1.595403
{% endcodeblock %}

\* Instruments that have insufficient data are penalized with large negative returns.

### Resources

 * [Original post explaining this strategy](/blog/2013/10/30/investment-portfolio-update-october-2013/)

 * [Investing for a living blog](http://investingforaliving.wordpress.com/)

 * [Alternative Ivy Portfolio tracking spreadsheet](https://docs.google.com/spreadsheet/ccc?key=0Ai0xPgGdCts3dEhZVUVXTFQtOEdsRUYwSmRLN3M0NHc&usp=sharing#gid=1)