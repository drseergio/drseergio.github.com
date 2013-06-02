---
layout: post
title: "Introducing photofs: FUSE file-system for browsing photos"
date: 2013-06-02 09:21
comments: true
categories: [projects]
---

With yeach passing year the number of photos in my collection is growing. The trend only hockey-sticked once I got my own camera. I've tried various programs to organize and browse photos. I recall using or trying ACDSee, digiKam, Adobe Bridge, IrfanView, F-Spot, Shotwell and possibly others that I don't recall.

<!-- more -->

The thing I don't like about these tools is that they build an index of photos in their proprietary formats. Usually, it takes a while to generate the index and the programs will obviously work only on the computer where the program is installed. 

The other problem is performance. With 15 000+ photos many of the photo organizers simply don't work well: become slow, crash and hang. Applying changes to many photos at a time is especially thorny.

Finally, I like to have photos to be neatly organized not only in the indexes inside of the photo management programs but also on disk. It's quite possible that I will switch to another program in future (or to another operating system altogether). Having a manageable folder structure is crucial. Otherwise, I need to go through re-organizing all photos every time this happens.

My first attempt of solving this issue was to write a simple desktop program that imports photographs and sorts them nicely on disk in a well-defined folder structure. This is convenient because I can browse the collection on any computer running any operating system.

However, I quickly realized that there is not a single definitive way of arrangement that would be useful in all occasions. Sometimes, I want to look at pictures taken in certain years. Most of the time I really care about albums. I also like the idea of tags. It's obvious that a static arrangement won't answer all useful queries.

Couple of weeks ago an idea struck me. Why not to create a virtual file-system that would take meta-data information from the photos (dates, tags, album names, camera settings) and create a hierarchy that would be transparent to the operating system. You would simply browse a folder with your favorite file manager or photo viewer and photos would be neatly organized in various ways. Furthermore, if you store photos on a NAS you could run the virtual file-system on it and the view would be exposed to all clients of the NAS.

And that's exactly what I have done in **photofs** project. Simply put, **photofs** takes a path to folder with your photos and creates a set of virtual views of the photos at a specified mount point. Internally, it creates an index similarly to how the other photo management tools do it. The advantage, however, is that in the end you seemingly get a regular folder with files in it. You can browse photos using a terminal, any file-manager or even expose the view via network to other computers.

Here's a screen-shot of Dolphin file-manager showing 4 panels with the modes that **photofs** supports:

{% img /images/photofs.png %}

Upon first invocation **photofs** generates an index and creates 4 virtual sub-folders at the mount point. Each of the sub-folders, in turn, exposes a single view of your photos:
  
  * **albums** lists all albums in your photo collection as folders. To determine what album a photo belongs to **photofs** reads XMP label. This is what I have decided to use as an album marker. Each album sub-folder has a *selects* sub-folder. That is intended for separating really good pictures from the rest. A picture is deemed as *select* if it has IPTC keyword "select" (IPTC is what almost all photo management tools use for storing tags in photos).
  * **date** creates a hierarchy of date information: YYYY/MM/DD. At each level you can view all photos for that period by going into *all* sub-folder (e.g. all photos for year 2012).
  * **camera** creates a hierarchy based on camera settings that had been used when a photo has been taken. For example, you could find photos taken at 2.8F on a 55mm using Canon camera with this view.
  * **tags** exposes a tag view. You can choose photos based on intersection of tags. For example, to find photos that have tags "milan" and "racing" you would go into sub-folder milan/racing.

**photofs** is written in Python and runs on Linux only because it relies on inotify kernel feature of Linux to know when certain files have changed without doing full traversals of the photo folder. The core of **photofs** is built on top of FUSE - a Linux kernel feature that allows user-land programs to act as file-systems. I believe **photofs** could be adapted to OSX by using an alternative to inotify (not sure what that is in OSX). The index is stored as a sqlite database.

You can argue that what I have done with **photofs** is yet another program that runs on one O/S only and also has a proprietary index. However, I believe it's different because **photofs** exposes a file-system. At home, I expose a virtual **photofs** view via NFS and Samba to other computers and it works well enough.

 **photofs** is not perfect. First and foremost, it solves a problem I personally had. If you believe you can make use of it or even improve it - go ahead and clone the github repository. Requirements and installations steps are documented in the README file.
