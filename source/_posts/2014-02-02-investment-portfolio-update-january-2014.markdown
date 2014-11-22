---
layout: post
title: "Investment portfolio update January 2014"
date: 2014-02-02 09:29
comments: true
categories: investments
---

### January's update

As of **2014-01-31** the best performing instruments are:

{% codeblock %}
      VBK       VBR       VTV
10.523511  8.138919  5.699153
{% endcodeblock %}

No changes to positions since last month.

We avoid investing if price is below 10 month SMA. Running through 10-month SMA check we get:

{% codeblock %}
  VBK  VBR  VTV
TRUE TRUE TRUE
{% endcodeblock %}

This means portfolio should be fully invested in **VBK**, **VBR**, **VTV**.

As of **2014-01-31** the calculated returns for each instrument are presented below(*):

{% codeblock %}
symbol        1          3          6           12           avg
VBK  -1.144726  3.73230373 10.6838781   28.8225892   10.5235112
VBR  -2.783198  2.81307701  7.8254927   24.7003030    8.1389186
VTV  -3.691583  1.44787645  4.5325377   20.5077805    5.6991530
VEA  -5.206334 -2.75658381  6.4959569   11.2018013    2.4337101
VCIT  2.031439  1.41826923  2.8773470    0.7763048    1.7758400
VGLT  6.186533  1.55386224  2.2258986   -4.3215090    1.4111963
VNQ   4.275093 -1.10180696 -0.5025126    2.8257217    1.3741238
VGIT  1.708174  0.04711055  1.0948905   -0.4997657    0.5876023
IGOV  0.548957 -0.62148565  2.9009193   -0.9828976    0.4613733
GSG  -2.205654 -1.34753996 -3.2575292   -8.1948090   -3.7513830
VWO  -8.434614 -9.55582233 -2.2320270  -13.0223967   -8.3112149
IAU   3.339041 -6.07003891 -6.1430793  -25.4938272   -8.5919761
MTUM -2.315509  3.45800988  8.4921369 -999.0000000 -247.3413405
{% endcodeblock %}

There's a drop in prices across invested instruments in January.

\* Instruments that have insufficient data are penalized with large negative returns.

### Resources

 * [Original post explaining this strategy](/blog/2013/10/30/investment-portfolio-update-october-2013/)

 * [Investing for a living blog](http://investingforaliving.wordpress.com/)

 * [Alternative Ivy Portfolio tracking spreadsheet](https://docs.google.com/spreadsheet/ccc?key=0Ai0xPgGdCts3dEhZVUVXTFQtOEdsRUYwSmRLN3M0NHc&usp=sharing#gid=1)