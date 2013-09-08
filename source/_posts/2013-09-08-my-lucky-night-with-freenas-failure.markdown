---
layout: post
title: "My lucky night with a FreeNAS failure"
date: 2013-09-08 01:34
comments: true
categories: 
---

It's 1:35am right now and something really bad has happened about 4 hours ago. First, Time Machine on my Mac Mini complained that the backup network disk became inaccessible. Then network shares have stopped responding on all computers. This means something wrong has happened with the wonderful reliable NAS server that I had built weeks ago.

First, I connect to the server via SSH and start poking around. Once I notice that file-system commands, such as `ls`, cause sessions to hang I become worrisome. I do a reboot hoping that solves the problem. 10 minutes pass. The server does not start.

<!-- more -->

{% img right /images/chinese_monitor.jpg %}

Once I've connected a handy [8" VGA monitor](http://dx.com/p/8-tft-lcd-car-reverse-rear-view-color-monitor-w-vga-bnc-cable-black-149114) I noticed SCSI driver related problems in the kernel logs. As it turns out, the USB drive on which FreeNAS had been installed has failed. This monitor is really handy for troubleshooting problems with servers - small, easy to carry and occupies little space in the toolbox. The picture quality is god-awful but good enough for reading terminal output.

I have been expecting the worst - that I would need to re-configure everything. After a quick search on the Internet I found out that FreeNAS keeps configuration in a SQLite database file on the 4th partition in `freenas-v1.db` file. A bleak hope ran through my mind. I've connected the flash disk to a Linux computer and started poking around. All I needed to do was to compile UFS file-system support in kernel and then mount the partition with:

`mount -r -t ufs -o ufstype=44bsd /dev/sdc4 /tmp/mm`

I copied the file over and verified that it's not corrupted. YES! I had been stupidly postponing back-up of the configuration file. If I had to re-configure FreeNAS from scratch I would feel like a fool and waste a week worth of evenings. Now, I just need to burn the FreeNAS image to a replacement drive and I'm all set.

The last step took embarassingly long time. None of the images that I had written either on Linux or Mac would boot. FreeNAS would get to an error saying `corrupt or invalid GPT detected.`. No matter what I did the outcome was the same. The solution was to delete GPT by running parted from Linux and doing `mklabel msdos`, followed by write of the disk image. I believe this problem occurred because I had previously used the drives for experimentation with Chromebook and some GPT headers apparently remained there.

{% img left /images/msata.jpg %}

Finally, I found a spare mSATA SSD drive lying around with no use (a leftover from an upgrade to a notebook). I also had a mSATA adapter so I've put them together inside of the NAS to use as a boot device for FreeNAS. Now the NAS has 8 SATA devices (6 HDDs and 2 SSDs) maxing out all available SATA ports in the system.

Once I have successfully booted the server and got to the web UI and initiated import of the recovered configuration database file. Then the server rebooted twice and everything was back!

The machine is back online and running beautifully. I now have a backup of the configuration. In case anything goes wrong again reinstalling FreeNAS is really quick & simple IFF the backup configuration file is available. I am once again pleasantly surprised at how well FreeNAS is made.

