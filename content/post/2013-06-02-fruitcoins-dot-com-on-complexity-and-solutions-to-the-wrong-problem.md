---
title: "fruitcoins.com: on complexity and solutions to wrong problems"
url: /blog/2013/06/02/fruitcoins-dot-com-on-complexity-and-solutions-to-the-wrong-problem/
date: "2013-06-02"
comments: true
tags: [tech]
categories: pro
---

About two years ago I had very little experience in programming in Python. I've heard of Django and felt excited how flexible it is and how complicated web applications can be elegantly written.

Tracking expenses has always been important for me. At the time I've relied on KMyMoney program. Frankly, I did not (and still don't) like any such programs. They're either clunky and look like Windows 95 or too complicated or too inefficient. I've decided to write my own web application in Python using the Django framework.

<!--more-->

Initially, the program was called "moneypit" and I was planning to scale it infinitely (for millions of users that would flock to it!). I targeted AppEngine and made sure that I'm not using any Django constructs that would not work on the AppEngine data store. I chose ExtJS 3 as a front-end solution because it had lots of ready components that can interact in well defined ways.

Once the first prototype was ready I've decided that over-engineering (especially too early) the thing is pointless so I gave up on AppEngine. I've rewritten everything from scratch and based the front-end on then new ExtJS 4. I've relied on ExtJS's MVC pattern and made the back-end work in a RESTful fashion using django-piston.

fruitcoins.com is my first experience of using my own product. I made sure fruitcoins.com satisfies my needs: easy too use, efficient, does not stand in the way. I also wrote a fully-functional importer/exporter for KMyMoney format so that I can migrate easily.

fruitcoins.com is an assembly of following pieces: django framework, celery/rabbitmq queue for asynchronous tasks, REST API through django-piston, MVC ExtJS 4 front-end, MVC Sencha mobile front-end, OAuth integration, PhoneGap client for iOS (though never released), fabric deployment and so on.

A public instance is still available though I plan to shut it down soon because nobody using it except for me. I have a private "beta" instance running at home all to myself.

Some screen-shots of fruitcoins.com:

[{{%img src="/images/fruitcoins-login.png" width="150" %}}](/images/fruitcoins-login.png) [{{%img src="/images/fruitcoins-account-view.png" width="150" %}}](/images/fruitcoins-account-view.png) [{{%img src="/images/fruitcoins-categories.png" width="150" %}}](/images/fruitcoins-categories.png) [{{%img src="/images/fruitcoins-categories1.png" width="150" %}}](/images/fruitcoins-categories1.png) [{{%img src="/images/fruitcoins-expenses_graph.png" width="150" %}}](/images/fruitcoins-expenses_graph.png)

Why did I write all this? For one, I'm going to upload complete fruitcoins.com source code to github. Hopefully someone will find it useful or at least will find code samples for doing things in Django and ExtJS. Example code is terrific for learning.

Recently, I've decided that I should finally implement support for tracking investments in fruitcoins.com because I'd like to have an overview of wealth in one spot. With that I went to clone the repository and get working. What surprised me is the complexity of the whole thing. For 2 years I've been happily using fruitcoins.com and I forgot that it's actually 3 or 4 different programs tied together. There's the back-end, then there's the REST API, main front-end written in ExtJS and a mobile one in Sencha mobile! Basically, 4 different programs written in different languages/frameworks.

My initial reaction was disbelief. I could not believe I have written all that. I don't work with any of the frameworks in my day-to-day work. Seeing what's inside reminded me of ExtJS complexity, numerous parameters and widgets. I think if I have continued with ExtJS or Django I could have become a decent programmer for ExtJS/Django. But that does not matter because I don't personally like the idea of being narrowly specialized in one framework.

To play with the code I had to build a new development environment. I had to go through a long list of dependencies to get the thing running (nginx, mysql, uwsgi...). Several hours into this task I realized something important.

_I'm looking at the wrong problem_. I'm thinking like a programmer too much. There's a simpler solution to my problem. I've been substituting one problem with another. The original problem was to track my wealth and keep my expenses in order. Instead, I've substituted it with "need to have investments support in fruitcoins.com". I found a solution but far from the simplest one. Perhaps, a technical solution is not even needed here.

I've then paused and reflected. Writing "fruitcoins.com" has been a great learning experience. I have included learning in the the utility of the project when commencing. I have not developed fruitcoins.com because its improvements over alternatives correspond to the spent effort. By all means, it's an irrational undertaking. And right now, the future utility does not include learning. What I need a simplest solution to my problem. Developing fruitcoins.com might be fulfilling in some ways but in reality it's a sunk-cost effort.

The very moment I realized this I stopped working on it. I have decided to rely on the platform of the investment bank to know where I stand with open positions. Furthermore, I re-evaluated the utility of keeping track of expenses the way I do right now. I seriously consider changing it to something like [YNAB](http://www.youneedabudget.com/).

In any case, if you're interested have a look in the fruitcoins.com github repository.