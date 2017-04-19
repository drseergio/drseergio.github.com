---
title: "How to order Dell XPS 13 with US keyboard in Europe"
date: "2015-04-05"
comments: true
tags: [tech]
categories: personal
---

I decided to purchase a laptop as I find myself longing for a computer away from my beloved workstation more often. Last time I bought a laptop was 8 years ago. 

Dell built a laptop I feel genuinely excited about - the new XPS 13. It's as small as 11" machine with really narrow bezel. It comes with specs that are just right for me.

[{{%img src="/images/dellxps/dell_order_01.png" width="500" %}}](/images/dellxps/dell_order_01.png)

However, I've learned that buying from Dell is not that easy! I was trying to order XPS 13 laptop with a US layout keyboard using Swiss regional site dell.ch. When I choose US keyboard I get presented with the following error:

"The selection - MUI Etikett für Handauflage is incompatible with Tastatur"

[{{%img src="/images/dellxps/dell_order_02.png" width="500" %}}](/images/dellxps/dell_order_02.png)

[{{%img src="/images/dellxps/dell_order_03.png" width="500" %}}](/images/dellxps/dell_order_03.png)

[{{%img src="/images/dellxps/dell_order_04.png" width="500" %}}](/images/dellxps/dell_order_05.png)

I have no clue what "MUI Etikett für Handauflage" is. It looks like some kind of internal article name. In English it means "MUI sticker for palm rest" which still makes little sense. I confirmed that the same issue is present on other European Dell stores. I checked Austrian and German sites. Same problem.

I honestly tried to contact support to get it done. Phone support in Switzerland does not provide help unless you have already bought something from Dell. I've tried contacting other deparments and a support agent suggested I try chat support in Germany. I described the error and provided a screen-shot. The agent said it's a known problem and that it's going to be fixed. Just to be sure the agent recommended I try again tomorrow.

Well, the problem is still there 1.5 weeks later so I guess it's not going to be fixed anytime soon. Anyway, the point of this article is that it's possible to make an order by modifying JavaScript using Developer Tools (in Chrome) or an equivalent in other browsers. It's as simple as enabling the "purchase" button. Step by step instructions are provided below:

Find the HTML element in DOM that corresponds to the purchase button and remove the "disabled" class attribute::

[{{%img src="/images/dellxps/dell_order_06.png" width="500" %}}](/images/dellxps/dell_order_06.png)

Repeat the procedure on the next screen:

[{{%img src="/images/dellxps/dell_order_07.png" width="500" %}}](/images/dellxps/dell_order_07.png)

[{{%img src="/images/dellxps/dell_order_08.png" width="500" %}}](/images/dellxps/dell_order_08.png)

So far my order has not been cancelled but I don't know if it's going to work. If this fails I think I'll hold off buying a laptop at this time.