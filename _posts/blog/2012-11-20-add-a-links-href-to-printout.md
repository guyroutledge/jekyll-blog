---
layout: post
title: "Add a links <code>href</code> to printout"
date: 2012-11-20
tags: Snippet
categories: blog
---
If I'm printing stuff out, I don't want to see a whole load of text underlined with no reference to what it's linking to. A nice, simple bit of added sugar to a print stylesheet (you are doing a print stylesheet, right?) is adding the URL after each link.

Here's a quick snippet:

{% highlight css %}
a[href]:after{
    content: " [" attr(href) "] ";
    font-size:80%;
}
{% endhighlight %}
