---
layout: post
title: "Internet-connected motorcycle project, Part 1"
date: 2017-04-16 17:44
comments: true
categories: [diy, pro, tech]
---

[{% img /images/vitpilen.jpg 500 %}](/images/vitpilen.jpg)

Since autumn 2016 I'm working at an IoT company -- we build Internet-connected home automation devices. Last week we had an internal hackathon to try something new. Essentially, it was a chance to work outside of the comfort zone and try out new APIs and hardware in the vast world of IoT. At first I was struggling to come up with an idea. Some ideas seemed trivial, others unrealistic. Finally, I brainstormed over available hardware and my surroundings and decided to make my KTM Duke 390 motorcycle join the IoT party!

In a series of 3 posts I will give an overview of the project and the top level design, share the reverse engineering process of connecting to the Dynojet's Power Commander 5 fuel injection adjustment unit and belatedly admire the maturity and functionality of Amazon Web Services. Without further ado I'm going to introduce the actual project.

[The project source code is available at github. You're welcome.](https://github.com/pisarenko-net/pcv-streamer)

##Project and goals

Of the things I own and use everyday KTM Duke 390 is in a league of its own. [As I previously written](/blog/2016/07/23/farewell-bmw-f800gs-adventure/), I don't like riding and owning motorcycles that much. This KTM is different. I purchased it for a practical reason. It effectively cuts my commute to about 50 minutes per day (from about 2 hours if taking public transport). It's cheap to buy and own, light (<150kg), sufficiently powerful, maneuverable and subjectively aesthetically pleasing.

[{% img https://c2.staticflickr.com/4/3927/34074232195_7e8d699d84_c.jpg 800 %}](https://www.flickr.com/photos/tentaclephotos/34074232195)

What does it actually mean to connect a motorbike to the Internet? I defined it as tapping into the data that the bike's engine provides, such as RPMs and how much throttle is currently given by the rider (1-100%), and sending that data to online services. The data could be used to analyze bike performance on a race circuit so that the engine could be later tuned. Since the major intent with the project was learning I also wanted to try out a couple of Amazon services, such as [Amazon IoT](https://aws.amazon.com/iot-platform/how-it-works/) and serverless [Lambda functions](https://aws.amazon.com/lambda/).

In addition to the appreciation for the bike itself I knew my bike had a micro USB port hidden under the seat and that a glorious Raspberry Pi 3 was among the available hardware for the hackathon. These two facts seemed to match perfectly. The existence of the USB interface instilled confidence that the project was feasible. I don't think I would hook into an engine ECU otherwise. It would be a bigger hardware challenge. And I don't even have a garage to work in!

I limited the scope to RPMs and throttle values only. I also didn't want to spend time writing server side code and setting up web services and infrastructure even though that's not terribly difficult. The point of the project was not to exercise skills building CRUD applications and configuring standard services like messages queues. I get enough of that during my day job. Instead, I chose to combine a couple of serverless Amazon services to hack something together. The cost was also important. I used a free tier and wanted to spend exactly 0$ on this.

##Hardware

I was mostly guided by what's available. We had a bunch of Raspberry Pi 3 boards available. That was a nobrainer. These are staples of DIYers and makers. Raspberry Pi 3 needs no introduction. It's just a small x86 computer. It can do anything a regular computer can do. Hence, the entry barrier is nonexistent. I have set it up in 20 minutes.

[{% img /images/raspberrypi3.jpg 500 %}](/images/raspberrypi3.jpg)

After the setup I had a complete Linux computer available to me, complete with SSH, Linux kernel (and, by extension, its wide device support) and standard environment. I also didn't need to learn a new programming language -- I could program in virtually any language I wanted.

Raspberry Pi 3 can be powered from a USB port. As an owner of a 10,000mah USB energy bank I couldn't be happier. That meant the Raspberry Pi 3 is essentially a battery powered device!

[{% img /images/powerbank.jpg 500 %}](/images/powerbank.jpg)

The other hardware component is more unusual. As I mentioned above, my bike has a mini USB port. But not every motorcycle has one. Last year I had installed a device from Dynojet called Power Commander 5 (PCV, for short). It is a third-party module that intercepts communication on the ECU and makes adjustments according to a predefined configuration. Typically PCV is used for performance reasons. I personally installed it to improve engine smoothness over low RPMs (during commutes). PCV is available for many bike models. The microprocessor is the same but the wiring harnesses that tap into ECUs differ for each bike model.

[{% img /images/pcv.png 500 %}](/images/pcv.png)

The PCV is a proprietary closed-source device. It is equipped with a micro USB port and communicates with a piece of software for Windows that lets users upload custom engine configurations and fine-tune parameters. Apart from the genuinely useful features, the software also shows real-time figures, like the RPMs and throttle values that I was after. Since the Windows tool can somehow read data from the PCV I correctly assumed it must be possible to somehow extract the data on Linux.

Because PCV is a proprietary device there is no developer documentation or anything such as a public APIs available. That meant that I had to reverse engineer the protocol and understand how it works. There was absolutely zero information about it on the Internet. Apparently, nobody was really interested in it. Can't say I'm surprised -- there are many other useful things to do. In any case, the reverse engineering aspect of the project was the largest risk. I wasn't sure at all. The device could have had some kind of obfuscation or even packet encryption. I was also lucky along the way. I cover the reverse engineering process in part 2. All in all, reverse engineering took about 80% of the whole project time.

##Software architecture and constraints

The project being a hackathon the biggest constraint was time or the lack of it. I had 4 days to complete the project but I also had to take care of an occasional issue in our live system. Due to ongoing commitments I limited my engagement to regular working hours. For that reason I chose not to spend much time on familiar but time-consuming aspects, such as backend development. I didn't design the system to be efficient or scalable or useful. In fact, the choice of the server-side system was in the end not that great. I also settled on a familiar programming environment, namely Java.

Java is installed by default in Raspbian, the Linux flavor Raspberry Pi 3 comes with it. I had to install JDK 8, though. Raspbian comes with version 7. I verified that Java has a good library for USB communication ([usb4java](http://usb4java.org/quickstart/javax-usb.html)) and that I could easily interact with Amazon IoT. I carried out most of the development and debugging on an OSX host with IntelliJ IDEA. I couldn't get OSX to work with the PCV device without getting into low level OSX programming so in the later phases I mostly ran code from the Raspberry Pi.

[{% img https://c1.staticflickr.com/3/2885/33236540854_4a43119fe8_z.jpg 800 %}](https://www.flickr.com/photos/tentaclephotos/33236540854)

The architecture of the system is very simple. The client program connects to the PCV device and to the Internet. It then streams data in real-time to the Amazon Web Services (to be explained in part 3). The only constraint was that the tool should be resilient to Internet and PCV device disconnects. The server side should accept the stream of data from the client, persist it and visualize it. Connectivity to the Internet would be provided by an Android phone through a hotspot feature.

## Challenges and future prospects

I completed the project. As I stood outside and listened to the roar of the engine, the Raspberry Pi 3 communicated with the PCV and streamed the data through MQTT protocol to Amazon IoT. Some magic trickery (not really) in Amazon services then transformed the messages into metrics that were exposed through the AWS management console. It worked!

[{% img https://c1.staticflickr.com/3/2938/33267251433_1f180b5215_c.jpg 800 %}](https://www.flickr.com/photos/tentaclephotos/33267251433)

I have spent most of the project time on reverse engineering. And I liked it. It was a like a rewarding puzzle. I almost gave up several times but miraculously got enough breakthroughs to persevere. I imagine that my progress in reverse engineering Power Commander 5 interface is potentially the most reusable part of the project so please help yourself and do something with it if you want -- [the code is published on github](https://github.com/pisarenko-net/pcv-streamer). I will share how I analyzed the PCV devices and learned its wire protocol in the next part.

The final result is crude but it's a 0.0.1 version. I imagine this could be used to write a complete Linux software for the PCV device. An even more ambitious goal is to make a cloud-based system that uploads engine configurations on the fly and tunes parameters on the go. [I'm not sure I'd like that on my bike though...](https://www.wired.com/2015/07/hackers-remotely-kill-jeep-highway/)

...to be continued with the juicy reverse engineering bits (pun intended) in part 2.