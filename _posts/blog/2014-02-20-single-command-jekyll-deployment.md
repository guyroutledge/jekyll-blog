---
layout: post
title: "Single command Jekyll deployment"
date: 2014-02-20
tags: Workflow
categories: blog
---

I love Jekyll. Now I&rsquo;ve set myself up with [an automated way to
create new
posts](http://www.guyroutledge.co.uk/blog/automate-jekyll-post-creation-with-thor/),
it&rsquo;s super easy to get writing a new article quickly. The next
thing on my list was automated deployment. 

I&rsquo;ve created a single command that uses a series of different
steps that I&rsquo;ll outline first and then bring together as
a whole&hellip;

## Grunt

I use Grunt to watch files in development but I also have a default task
that cleans and compiles my Sass into a `dist` (distribution) folder,
compresses images and would uglify my JavaScript if I used any on my&nbsp;site. 

## Jekyll Build

`jekyll build` is a command that builds the static HTML of my site
from all the component parts - the separate blog posts, project
posts and page templates from a series of includes and page templates.

This build command generates a `_site` folder ready to send up to my
server.

## `scp`

The first iteration of my deployment process used `scp` which is
a command line tool for securely transferring files. The reason
I&rsquo;ve moved away from using `scp` is that it will transfer
everything in the `_site` folder (because that&rsquo;s what I told it to
do) rather than just transferring files that have been modified in the
latest merge. After a little digging, I found another utility that would
do just that.

## `rsync`

`rsync` is similar to `scp` but more powerful - its&rsquo; used for
syncing files and folders rather than just blindly copying what
it&rsquo;s told to.

I use `rsync` with a couple of option flags:

* `-r` recursive - recurse into directories
* `-u` update - skip files that are newer on the receiver
* `-i` itemize - output a change summary

These flags are combined with the files to transfer (`.` means the
current directory) and the destination as follows:

{% highlight bash %}
rsync -rui . guyroutledge.co.uk:/path/to/site
{% endhighlight %}

## Shell alias

I use ZSH as my shell and have a `.zshrc` in my home directory. This
contains a bunch of helper scripts and aliases, one of which is for
deploying my Jekyll site. I&rsquo;ve created an alias of `deploymyblog`
which strings together all the commands necessary to get the lastest
version of my site from my machine to my server with as little hassle as
possible. 

These commands break down like this:

{% highlight bash %}
% cd ~/path/to/local/dev/site
% grunt
% jekyll build
% cd _site
% rsync -rui . guyroutledge.co.uk:/path/to/site/on/server
{% endhighlight %}

These commands can be strung together with the `&&` operator and aliased
to a nice, memorable name:

{% highlight bash %}
alias deploymyblog="cd ~/path/to/local/dev/site && grunt && jekyll build && cd _site && rsync -rui . guyroutledge.co.uk:/path/to/site/on/server"
{% endhighlight %}

Blogging consistently is hard but since I&rsquo;ve made creating new
post templates and deploying new articles to the server as easy as
possible, I have two fewer excuses for not posting often enough...!
