---
layout: post
title: "Some useful Vim commands"
date: 2013-01-23
tags: Snippet
categories: blog
---
In a slightly quieter period than usual I've decided to take a deep dive into learning Vim. I figured the best way was to use it on an actual project and so far it's going well but there's a pretty steep learning curve! However, as I become more and more comfortable in the terminal, it's great to not have to `Cmd-Tab` away from it each time I wan't to edit a file or commit to version control or jump onto a server to put changes live.

> Emacs is a nice OS - but it lacks a good text editor. That's why I am using Vim.
> -- Anonymous

I'm using [MacVim][1] but launching it with the `-v` flag to run "like vi" within the terminal. This has forced me to learn how to properly use buffers and tabs and not fallback on old muscle memory and hammer `Cmd-s` to save a file and `Cmd-w` to close one.

[1]: http://code.google.com/p/macvim/

Each time I come across something that I want to do but have no idea about, I do a quick Google and make a note of the commands for future reference. Here are some of the more useful ones I've found on my travels:

### Editing between quotes and tags

{% highlight vim %}
ci"  // replace between ""
ciw  // change inner word
ysiw"  // wrap word with " using the surround plugin
VS&lt;p&gt;  // auto wrap selection with opening and closing &lt;p&gt; tags using surround plugin
{% endhighlight %}

### Searching & Replacing

{% highlight vim %}
/pattern  // search for pattern
:s//&replace/  // search for previous pattern and append replace to it
%s/search/replace/  // search and replace whole file
:bufdo %s/pattern/replace/e  // search and replace in all buffers, ignoring errors
{% endhighlight %}

### Cut, Copy & Paste

{% highlight vim %}
:%y  // copy whole file
:%d  // cut whole file
:r [file]  // insert contents of [file] below cursor
{% endhighlight %}

### Visual Selections

{% highlight vim %}
gv  // re-select the last visual selection
I  // insert text in visual mode
{% endhighlight %}

### Tabs & Windows

{% highlight vim %}
gt  // next tab
gT  // previous tab
1gt  // go to tab 1
:tabe [file]  // edit [file] in tab
:tabo  // close all tabs but the open one
:wa  // save all open buffers
:ccl  // close the quick fix window
{% endhighlight %}

### Easy Motion

{% highlight vim %}
,,f[character]  // easily display results matching [character] for jumping around file
{% endhighlight %}
