---
date: 2017-04-28T21:00:05+02:00
subtitle: "migrating from Octopress to Hugo"
categories: personal
tags: []
title: "Hugo static site generator"
---

{{%img class="center noborder" src="/images/hugo-logo.png" %}}

I don't like talking about blog platforms. Usually, you find such posts on abandoned personal web pages. As a rule, such a post goes on to talk in length about the technical solution and the configuration. Unfortunately, the author then posts a couple of brief updates and disappears forever. In other words, posting about the blogging platform is a bad omen. I have restrained myself from discussing this blog's setup until now and I hope this won't ruin it.

This blog is powered by a static site generator. I type content into plain text files and then a program generates a complete website with all the links, styles and pages. There is no admin console and no WYSIWYG editor. There is no database and no dynamic server-side environment. Last week I have migrated from one generator ([Octopress](http://octopress.org/)) to another ([Hugo](https://gohugo.io/)). In this post I'd like to briefly share how I run this blog and how the migration went.

<!--more-->

## Benefits of a static generator ##

After a string of abandoned blogs I chose a static generator mostly for the ease of maintenance and for the pleasure of editing. It just works. A system that requires almost no maintenance leaves time for actual writing. A typical dynamic content management system requires a database, a server-side runtime and usually lots of plugins. All of these moving parts need to be regularly updated. Also, the interfaces between components are not simple and one regularly needs to dive into code to change a minor a thing. Scripts and stylesheets are also typically complex.

There are many hosted blog portals, such as wordpress.com and blogpost, available. But the hosted platforms still suffer from complexity and at the same time are limited in customization. The most annoying problem though is the editing process. Most of the content management systems have awkward input fields and intrusive formatting. It's just not pleasant to type long articles into a small box in a browser. Also, most of the platforms won't work offline.

Instead, I find typing articles in my favorite text editor ([Sublime](https://www.sublimetext.com/)) using Markdown markup language vastly superior. I don't need to fiddle with plugins, dependencies, server maintenance, upgrades. Instead, to create a new page I just run one command `$ hugo new post/my-new-post.md` which then creates a file I can edit. When I'm done editing I run `./deploy.sh` and the site is generated and published on the world wide web. Of course, I can preview the site locally on my computer and see the changes appear dynamically as I type.

There are many site generators available and I have been using Octopress since 2013 but after a bit of hesitation I decided to migrate to Hugo.

## Reasons to migrate ##

First and foremost, my switch from Octopress to Hugo hasn't been grounded in a chase for the next great thing. I couldn't easily modify the existing blog to introduce thematic sections that display complete articles (see [Pro](/categories/pro) and [Personal](/categories/personal)). Before trying to modify Octopress I looked around and found Hugo. Hugo had the functionality I wanted and the effort to migrate seemed smaller than trying to modify Octopress to suit my needs.

In addition, Hugo presented a couple of significant advantages over Octopress. Namely:

 * Hugo is built as a single binary that does everything. Octopress, on the other hand, requires a whole folder of Ruby scripts and various files. I never programmed in Ruby and I was getting concerned that at some point it may stop working and I won't have desire to fix it.
 * I didn't like the fact that creating new Octopress environments wasn't easy. I've mostly used the same Virtual Machine and hoped I won't need to create a new one. In contrast, installing Hugo is easy:

{{< highlight bash >}}
$ apt-get install golang-go # not necessary when running a prebuilt Hugo binary
$ dpkg -i hugo.deb
$ apt-get install python-pip # for syntax highlighting
$ pip install Pygments
{{< /highlight >}}

 * [Excellent documentation](https://gohugo.io/overview/introduction/).
 * Simpler theme and template modifications.
 * Immediate and reliable preview generation. I had to sometimes wait for minutes for Octopress to update the preview. That's painful when you would like an immediate feedback.

Unlike others, I haven't praised that Hugo is written in Go. I really don't care what language is the generator written in as I have no intention of modifying it. I just want it to work reliably. For that reason I'm glad Hugo is compiled to a binary that I can keep using even if fancier incompatible versions come out.

Octopress has been a venerable tool and I've enjoyed using it. At this point, however, I'd be pressed to find a reason to keep using it or choose it over Hugo. Hugo is better. The only department Hugo lacks in is themes. It doesn't come with a good default blogging theme. There's a whole bunch of themes on the site but I'd appreciate if there was a default official Hugo theme that looked decent and could be minimally customized (e.g. color).

## Migration ##

Both Hugo and Octopress use Markdown text files so migrating from one to another is a matter of slight modifications to the content pages. I imagine migrating from one hosted blogging platform to another is a nightmare. Each might use its own syntax, have weird export or import problems. The worst part is going through hundreds of pages and doing manual changes to make sure everything looks and works right. The benefit of simple text files is that they are amenable to powerful command line text editing utilities available in most modern operating systems, such as sed, grep, awk and their various combinations.

There are a couple of blog posts on the Internet about migration from Octopress to Hugo. [https://nathanleclaire.com/blog/2014/12/22/migrating-to-hugo-from-octopress/](https://nathanleclaire.com/blog/2014/12/22/migrating-to-hugo-from-octopress/) helped me to get started. Basically, I've run into the same problems as the author. Also, the linked page is from late 2014 which speaks for Hugo's maturity.

### Basics ###

The folder structure of a Hugo site is not complicated.

`archetypes` contains skeletons for new pages. When you create a new post Hugo will insert a corresponding skeleton. For example, the front matter with the current date and necessary tags would be there.

`content` contains content of the blog. By default, `post` folder is treated specially as a folder with blog articles. If necessary, custom page types can be created.

`layouts` contains templates of how various content pages should be generated. I used this to create an "Archives" page (like in Octopress) to display a list of all blog entries.

`public` contains the complete generated site. After Hugo generates the site this folder can be copied to the web server.

`static` contains miscellaneous files that will be served from the site, for example stylesheets, JavaScript and images.

`themes` contains folders with themes. Each theme folder, in turn, contains a folder substructure that is similar to the parent Hugo folder.

Configuration is stored in one file `config.toml`.

As a first thing I copied all `*.markdown` files from my Octopress installation to the `content/post/` folder. Then, I changed file extensions to `*.md`:

{{< highlight bash >}}
$ find . -name "*.markdown" -exec rename 's/.markdown$/.md/' {} \;
{{< /highlight >}}

Then I removed `layout: post` line from all files (it causes problems in Hugo because it's likely used for something else):

{{< highlight bash >}}
$ sed --in-place '/layout: post/d' *md
{{< /highlight >}}

The date format is different so that also needs to be changed:

{{< highlight bash >}}
find -type f -exec sed -i 's/\([0-9]\+-[0-9]\+-[0-9]\+\).*$/"\1"/' {} \;
{{< /highlight >}}

I intended to use few categories and a couple of tags. The way I used categories in Octopress maps to tags in Hugo so I changed all Octopress categories to tags:

{{< highlight bash >}}
$ sed -i 's/^categories: \(.*\)$/tags: [\1]/g' *.md
{{< /highlight >}}

and inserted a default `personal` category into to each post:

{{< highlight bash >}}
$ sed -i '/^tags:/a categories: personal'  *.md
{{< /highlight >}}

To change YouTube embed links I ran the following:

{{< highlight bash >}}
$ sed -i 's/{% \(youtube.*\) %}/\{\{< \1 >}}/g' *
{{< /highlight >}}

I was pretty happy with the Octopress appearance so I initially tried the Octopress theme for Hugo. Unfortunately, there's something wrong with it. It doesn't render correctly and I sense that the look isn't clean anymore. I think whoever ported the theme made minor adjustments and it doesn't look right anymore.

I won't pretend there weren't manual changes in the process. I figure it's quicker to do changes manually when there aren't that many occurrences rather than to come up with scripts. I've spent most of the migration time on making sure that existing URLs remain unchanged and on the image tags. Since there isn't standard syntax for images in Markdown each static generator comes up with an own approach.

### URLs and permalinks ###

Hugo generates URLs differently by default. It was a critical requirement to keep all existing links working. As a first measure it's necessary to configure Hugo so that it uses a specified link structure so I've put the following in the configuration file:

```
[Permalinks]
  post = "/blog/:year/:month/:day/:title/"
```

This partially solves the problem. However, Hugo treats punctuation differently. To make sure that URLs are completely consisted I downloaded the "Archives" page from my existing blog, extracted all URLs and then compared them to a similar list compiled from the new blog. Hugo allows individual pages to override their URL so I inserted static URLs into the front matter for all pages that differed in their URLs. A third of all pages required URL overrides.

### Archives page ###

Hugo doesn't come by default with a page that displays links to all posts. To create a page that lists all posts grouped by year (like Octopress does) I modified layout for the `post` page type. Basically, I modified how the "list" view is generated. This change doesn't interfere with "home" (that displays all blog articles) because "home" is treated as a separate view. By default "list" and "home" behave identically. Since "home" view was all I needed I didn't care about keeping the existing "list" view behavior.

`layouts/post/list.html`:

{{< highlight go >}}
{{ define "header" }}
  <header class="header-section ">
    <div class="intro-header no-img">
      <div class="container">
        <div class="row">
          <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
            <div class="page-heading">
              <h2>Blog Archive</h2>
            </div>
          </div>
        </div>
      </div>
    </div>
  </header>
{{ end }}

{{ define "main" }}
  <div class="container" role="main">
    <div class="row">
      <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
        <div class="posts-list">
        {{ range .Data.Pages.GroupByDate "2006" }}
        <div class="archive-year">
        <h3>{{ .Key }}</h3>
        <ul>
        {{ range .Pages }}
        <li>
        <div class="">{{ .Date.Format "Jan 2" }}</div>
        <a href="{{ .Permalink }}">{{ .Title }}</a>
        </li>
        {{ end }}
        </ul>
        </div>
        {{ end }}
        </div>
      </div>
    </div>
  </div>
{{ end }}
{{< /highlight >}}

### Image tags ###

Octopress uses `{% img %}` tag to insert images. It's possible to set dimensions, alignment and a caption. Hugo doesn't have such functionality by default but creating a so-called "shortcode" is straightforward. Essentially, I created a new shortcode that looks similar. `layouts/shortcodes/img.html`:

```
<img src="{{ .Get "src" }}"
{{ with .Get "class" }} class="{{.}}"{{ end }}
{{ with .Get "width"}} width="{{.}}"{{ end }}
{{ with .Get "height"}} height="{{.}}"{{ end }} />
{{ with .Get "caption"}}<div class="caption">{{.}}</div>{{ end }}
```

To convert existing Octopress image tags I used sed. Unfortunately, I initially used a snippet from another blog and that had messed up the files because of a greedy regular expression. Now image tags look like (`%` is escaped with `\`):

{{< highlight html >}}
{{\% img class="center noborder" src="/images/hugo-logo.png" %}}
{{< /highlight >}}

The end result is a bit more verbose than I would prefer but on the other hand it's clearer than positional argument image tag in Octopress. I was always forgetting the order in which the arguments are given.

## Current setup ##

I'm satisfied with the end result. The new generator simplifies maintenance, improves editing process and all while retaining the existing content. To serve generated pages I use a free service that's available on GitHub. It's called [GitHub pages](https://pages.github.com/). It's configured with a custom domain.

Files are stored in a GitHub repository. `master` branch contains files that are served on the Internet. `source` contains a folder with Hugo's files. I configure a local repository using git's workspace functionality. I clone the `source` branch and then I attach the `master` branch to the `public` subfolder. With this setup I don't need to switch between branches or keep two copies of the repository to modify source files and push generated site. All works from the same place.

I wrote a couple of scripts that automate two recurring tasks.

`preview.sh` starts the Hugo's internal web server to serve a preview version of the site:

{{< highlight bash >}}
#!/bin/bash
hugo server -b http://192.168.69.108 --bind 0.0.0.0 -p 4000
{{< /highlight >}}

`deploy.sh` generates a new version of the site and deploys it to GitHub pages:

{{< highlight bash >}}
#!/bin/bash
rm -rf public/*
hugo
cd public
MESSAGE="Site updated at `date +"%Y-%m-%d %H:%M:%S %Z"`"
git add .
git commit -m "${MESSAGE}"
git push origin master
cd ..
{{< /highlight >}}

