---
title: "From DIY to off-the-shelf"
subtitle: "Synology NAS and commercial 802.11ac access points"
date: 2018-03-12T19:59:27+01:00
tags: []
draft: false
categories: [pro]
---

I've been using custom assembled computer appliances at home, such as routers, access points and a NAS. But recently I've acquired an off-the-shelf NAS from Synology that I'm really satisfied with.

<!--more-->

I wrote about building a custom NAS [on this blog before](/blog/2013/08/28/impressions-from-freenas/). Equipped with 6 drives, 16GB RAM, Fractal Node 304 miniITX case and Freenas running ZFS the machine was seemingly a perfect storage system. Not perfect though -- the RAM was not ECC and NAS's existence did not obviate the need for an off-site backup solution. Then, the time came to expand the storage and I shrieked from the prospect of purchasing 6 new hard drives.

In general, building a reliable storage system is unreasonably expensive. Enthusiasts on forums consider things like ECC memory a basic requirement. Just the mainboard with ECC support costs a lot. Then come the drives. Nothing less than 6 drives. Particular network chipsets and drive controllers. And of course, everything twice. One for the main node and another for an offsite replica.

Bonkers, if you ask me. I decided to tackle the data durability from another angle. Amazon offers inexpensive Glacier storage for a very reasonable price so I figured I'd rather pay a fee for backing-up data to Amazon than trying to replicate a data-center at home. With that in mind, I settled on a 4-bay Synology enclosure. It's one fourth of the size of the existing NAS. It comes with a 4 core CPU, dual gigabit ports, USB3 and an outstanding software suite!

Actually, the software was the deciding factor. It's brilliant. DSM is intuitive, clean-looking and functional. There are plenty of high-quality packages available in the store. The system can be further controlled through SSH, which basically means the customization potential is unlimited. DSM comes with the aforementioned Amazon Glacier synchronization support. Other cloud providers are also supported.

NAS wouldn't be of much use if it didn't perform well. I'm impressed with the I/O performance. I achieve 75-80MB/sec in Samba/CIFS over Wi-Fi. Admittedly, the Wi-Fi link is point-to-point with only 1 client, using a pair of identical Asus 802.11ac access points. The previous NAS delivered read speeds of up to 65MB/sec but the write speeds were abysmal.

By the way, I'm not using a [custom 802.11ac access point](/blog/2015/02/01/beginners-guide-to-802-dot-11ac-setup/) anymore as I couldn't achieve predictable performance. I'm still satisfied with a Gentoo powered router and a similarly specced extension access point. But getting high 802.11ac speeds was too brittle.

The Synology NAS needed a couple of hacks though. For one, there was too much noise and vibration for my taste. I took out the standard fans and replaced them with a single 140mm at the back (attached with dual-sided sticky tape). I used the second fan connector, along with a long extension cable, to power an external fan that I've put over the router. To eradicate vibration I used a few layers of foam and cleverly put the NAS over a subwoofer opening in the TV furniture. That opening is covered with cloth which acts perfectly as a vibration damper. The end result is far from a polished fancy appliance (room for improvement, Synology) but more of a Frankenstein.

{{%img class="center noborder" src="/images/synology_fan.jpg" %}}

But it works!