---
layout: post
title: "Introducing qeytaks: trivial photo tag editor"
date: 2013-06-02 10:38
comments: true
categories: [projects]
---

In the previous post I have introduced **photofs** - a tool I have written for myself that universally solves my photo management problems.

With **photofs** I can easily locate photos by albums, tags, dates. But how would I add the tags in the first place? I use Adobe Lightroom and absolutely love it! I don't use it to manage photos. Lightroom is a gateway from the camera to my collection. Once I'm done processing photos Lightroom kisses them goodbye.

What if I mislabel something? For example, I typically use album names with the following template: "YYYY.MM.DD - &lt;album name or event name or something descriptive&gt;". I could easily make a typo or choose a wrong year. Or what if I want to add an additional tag to some of the pictures?

Originally, with **photofs** I would need to somehow magically figure out what are the true paths to the files I want to alter. Then I would need to use a tool such as exiv2 to make the changes.

I immediately realized that this is not a work-able solution. So instead, I've added support of modifying files through the virtual view. In other words, if you edit a file that you have opened through **photofs** the changes will be transparently channeled to the original images.

Furthermore, I had to implement a hack to let exiv2 library work (exiv2 is the only widely supported and maintained library for altering image photo data I could find). When a file is sufficiently large, exiv2 library wants to write its changes to a temporary file in the same folder as original and then rename it. Obviously, this cannot "just work" in a virtual folder so I had to implement a mechanism that tricks exiv2 into believing that a temporary file has been opened. In reality, **photofs** opens a file in memory and lets exiv2 write into it. When exiv2 tries to do a rename operation **photofs** dumps the file in memory to the original image.

{% img left images/qeytaks.png 400 %} Back to our problem. So now we have a possibility to not only view photos in some virtual arrangements but also modify photos. In other words, it's now possible to locate all photos with tag "travel", modify them (say, by adding tag "fun") and expect the original photos to have a new tag "fun"!

That's great but what to use for editing tags? I've mentioned in my last post that I am using XMP label tag as a marker for album names. I'm almost certain nobody else is using it in the same way. I also don't want to use overly complex and ugly programs for changing just 2 things.

I've decided to write my own simple tool - meet **qeytaks**. Essentially, **qeytaks** is a pane of pictures, 2 fields and a "Save" button. With **qeytaks** I can add new tags and alter existing ones. **qeytaks** indicates when a tag is not common to all selected pictures with a pre-pended star (*) similarly to how Lightroom does it. I've added integration with KDE by creating a contextual right-click menu entry. When I am browsing photos through **photofs** view I can simply select some photos and open them in **qeytaks** for editing tags.

**qeytaks** is written in Python and uses PyQt4 to create the UI. I've never worked with Qt before so I had to learn its concepts first. I've got an impression that the Qt concepts (at least the UI part, Qt library includes a lot more than just UI) are very similar to other desktop UI frameworks (e.g. events handling).

Again, I solved a personal problem and I am very happy with the result. I've spent total of about a day working on it and learned a couple of things along the way. You can clone the github repository if you're interested. I've documented the requirements and instructions in the README file.