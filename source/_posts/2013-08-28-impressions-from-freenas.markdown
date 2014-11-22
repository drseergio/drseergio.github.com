---
layout: post
title: "Building a FreeNAS computer"
date: 2013-08-28 13:49
comments: true
categories: tech
---

I have always fancied the idea of having a dedicated storage system to keep personal data and backups. For the last 3 years I have been happily using an off-the-shelf solution - acer easyStore H340.

[{% img right /images/freenas/acer.jpg 200 %}](/images/freenas/acer.jpg)

[Acer H340](http://www.trustedreviews.com/Acer-easyStore-H340-2TB_Peripheral_review) has 4 hot-swappable SATA slots, occupies little space and looks well. The on-board Atom N230 CPU is not powerful but has low TDP (4W). I have replaced the stock fan with a quieter one and the stock PSU with a passive one to make the server quieter.

In terms of software I had installed gentoo Linux with tons of different packages: file-sharing through NFS/CIFS, DNS server, OpenVPN, Bittorrent sync, transmission-web, BackupPC, various proxies and even Pandora ripper! I've run a RAID5 on 3 disks using mdadm and used the 4th drive for backups.

But recently I've decided to switch to a custom-built solution:

[{% img /images/freenas/7.jpg 450 %}](/images/freenas/7.jpg)

 <!-- more -->

## Why change? ##
 
  * it's mostly an irrational desire to upgrade and build something

  * in the hot summer time the Acer started to overheat. The symptoms were seemingly failed drives but as later SMART tests confirmed the drives were alright. Likely the SATA controller was going crazy because of heat and caused software RAID crashes.

  * to overcome heating issues I have tried to spin the fan faster which apparently solved the heat problem but introduced intolerable noise. Since I keep the server running 24x7 in the living room excessive noise is not acceptable.

  * I had spare computer parts available. I had a PSU, RAM and 6 2TB hard disks (4 of which were installed in Acer) and a 60GB SSD.

  * I wanted a solution which would minimize software maintenance. Although you can argue that it's possible to keep gentoo running without upgrading it I couldn't keep updates too far behind. Once in a while I broke things and compiling is not particularly fast on slow hardware, not too mention the hassle of connecting a monitor when the kernel does not boot.

## Alternatives ##

[{% img right /images/freenas/qnap.jpg 200 %}](/images/freenas/qnap.jpg)

My initial idea was to purchase a used QNAP. QNAP looks nice and require absolutely no fiddling with the internals. After diving into classifieds I have realized that the price of even a used one is much higher than assembling something custom. I could not find any offers for 4-bay models lower than approximately 350$. Not only QNAP is expensive but the read/write performance is worse than reported by users of custom NASes.

Luckily, I have stumbled upon [FreeNAS](http://www.freenas.org)! FreeNAS is a FreeBSD distribution intended for running NAS servers. FreeNAS provides a friendly yet functional [web-interface](http://www.freenas.org/about/screenshot.html) for managing most of its aspects so once it's up and running it should be no harder to manage than a QNAP.

## Hardware ##

The next step was to decide on hardware and components. As it turns out, there are a few things to keep in mind. For one, FreeNAS has ZFS file-system available which is very flexible and reliable but requires lots of RAM. 8GB is the absolute minimum.

In the end I have settled on the following hardware:

 * Fractal Node 304 miniITX case. The case has space for 6 3.5" hard drives. The case itself is nicely polished and the design is minimalistic. The build quality is very high. The only down-side is that drives are not hot-swappable so you would need to open the case to remove a failed drive.

 * 6 2TB Western Digital Caviar Green hard drives. Not very high grade but replacing them with better ones would be prohibitively expensive at this point.

 * ASRock E350M-1 motherboard with CPU and GPU on-board, max 16GB memory, 4 SATA connectors, 1GBit Realtek. It is not easy to find a miniITX board which fits all requirements (6 SATA, >8GB RAM, Intel network adapter, low power consumption, reasonably priced) so I had to compromise. This board is inexpensive and draws little power (18W CPU TDP) but has not enough SATA ports and is of consumer grade. Since I'm building this for home use I believe the trade-offs are fine.

 * LSI MegaRAID SAS 9240-4i SATA controller. This is probably the most expensive part. Luckily, I could get a used one from a colleague. This gives me a total of 8 SATA ports (4 on the board + 4 on the controller).

 * 2x8GB Kingston RAM. Maxed out the motherboard. Also, I could not find a miniITX board that supports more than 16GB.

 * 16GB external flash drive for the FreeNAS distribution. That's the way FreeNAS is usually run - you write the image to a USB drive and boot off of it. Most of FreeNAS is kept in RAM while it's running. There's no need to waste a SATA port. Also, after you back-up FreeNAS configuration it's easier to replace the O/S should anything go wrong - just plug in another USB drive.

 * 60GB corsair SSD (had one lying around). Used it for running jails and custom software - sort of like virtualization in FreeBSD world. I was familiar with lxc (Linux containers) so the concept is a familiar one.

 * Seasonic 400W passively-cooled PSU. I'm a big fan of Seasonic PSUs. All computers in my household use Seasonic PSUs. 400W is a bit of an overkill for the purpose of NAS but I had one lying around with no use.

## Assembled view ##

This is how the assembled NAS looks like:

[{% img /images/freenas/2.jpg 160 %}](/images/freenas/2.jpg)
[{% img /images/freenas/3.jpg 160 %}](/images/freenas/3.jpg)
[{% img /images/freenas/4.jpg 160 %}](/images/freenas/4.jpg)
[{% img /images/freenas/6.jpg 160 %}](/images/freenas/6.jpg)

I have removed the stock fan from the motherboard and instead put a 120mm fan attached by 2-sided sticky tape to the PSU so that the fan sits on top of the CPU heat-sink. The fan spins slowly and hardly makes any noise. The built-in case fans have adjustable speed. I run them at lowest speed and the system/drive temperatures are much lower than in Acer. I believe that's because the airflow is much better and there's more space between the drives.

The NAS looks discrete in the living room and fits with the rest of the interior:

[{% img /images/freenas/8.jpg 300 %}](/images/freenas/8.jpg)

## FreeNAS impressions ##

I have never worked with FreeBSD before. Getting up to speed is not difficult and the available documentation covers everything I have needed. Specifically, the handbooks are worth to read through if you're just starting out:

* FreeBSD handbook [http://www.freebsd.org/handbook](http://www.freebsd.org/handbook)

* FreeNAS handbook [http://doc.freenas.org/](http://doc.freenas.org/)

### Setup ###

Initial setup has been very quick. I've used a monitor and a keyboard to set-up the IP address. For the rest I've relied on the UI.

A huge advantage of FreeNAS is the ZFS file-system. ZFS is reliable, flexible and functional. The features I've been most impressed with are: snapshots, pools (that obliterate need for RAID) and deduplication.

I've configured a so-called RAID-Z2 on 6 drives which is similar to a RAID6. This leaves usable space of 4 drives and allows failure of 2 drives.

One of the challenges I have faced is moving data from the previous NAS. Luckily, all of my data has fit on a single 2TB drive. I've taken the following strategy:

 1. copy all of my data to a single drive

 2. using CLI initialize a 6-drive RAID-Z2 with a virtual drive

 3. fail the virtual drive

 4. transfer files from the drive containing data to the new array

 5. format the drive with data and put it into the array

 6. import the array into FreeNAS UI

The article that I've relied on is available at [http://forums.freenas.org/threads/quick-and-dirty-creating-a-degraded-raidz-3-of-4-drives-i-e-to-allow-migration.7748/#post-31106](http://forums.freenas.org/threads/quick-and-dirty-creating-a-degraded-raidz-3-of-4-drives-i-e-to-allow-migration.7748/#post-31106).

### Software ###

Once I'd completed the install I've configured NFS, CIFS, AFP (for talking with Apple computers) and set user rights. Setting this up was a breeze!

Then I've configured backup for all computers in my home network. I've used scheduled rsync + ZFS snapshots to backup Linux computers. For Apple machines I rely on Time Machine using AFP-shared volume. On Windows 8 I use File History with a iSCSI drive.

Finally, I needed to run custom applications. As it turns out, it's really easy to setup in FreeNAS. First, you create so-called jails which are basically virtual environments that appear as separate computers. Jails can have their own IP addresses. Inside of the jail you can install software using ports or any way you want. I've created a jail for running bind DNS server, Bittorrent sync. I've also installed midnight commander to move files around the NAS locally.

### Conclusions ###

All in all, I'm a very satisfied user of FreeNAS. So far the server has been running for 11 days and I had no issues whatsoever. I expect the machine to continue running without requiring any maintenance or updates. The only change I intend is to install additional services, like OpenVPN and git repositories.









