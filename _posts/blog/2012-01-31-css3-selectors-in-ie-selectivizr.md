---
layout: post
title: "CSS3 selectors in IE - Selectivizr"
date: 2012-01-31
tags: Apps
categories: blog
---

I like progressive enhancement and keep it in mind throughout a project. However, I tend to do my IE testing towards the end which may mean I'm really doing graceful degradation. However, what ever you want to call it, the concept of making stuff work everywhere but having a bit of sparkle in the browsers that can make it happen, is a good thing. Fortunately, using the process of progressive enhancement and starting with a good foundation of semantic markup, the HTML rarely needs much work when I get it into IE. However, the CSS can be a different matter. I've recently been taking advantage of some of the more interesting CSS3 selectors for styling which makes IE do a big ole nothing when it doesn't understand them. Things like: 

Attribute Selectors: 

{% highlight css %}
input[type=email]
label[for=name]
div[class$=red]
a[href^=http://]
{% endhighlight %}

Pseudo Classes: 

{% highlight css %}
:before
:after
:invalid
:focus
:not
{% endhighlight %}

Child Selectors: 

{% highlight css %}
p:first-of-type 
li:last-of-type
tr:nth-child(2n+1)
{% endhighlight %}

Combinations: 

{% highlight css %}
input[required=required]:invalid:focus:after
{% endhighlight %}

There are some very interesting combinations that can be played with but one of the nice things about these selectors is it means you need fewer classes in the markup which can help readability (and page size to a degree, I guess). If you want to style all links that have an href starting with `http://` (external links) you don't need to add `class=external` to each one, just use the CSS selector `a[href^=http://]`.  If you want to make rows of a table have an alternating background colour use: `tr:nth-child(2n)` to select every even numbered row. 

Great stuff. However, all this falls apart with browsers that don't support the selectors which varies depending on which you use. I found this recently but then stumbled across "Selectivizr" which is a small JavaScript library that enables all this selective goodness in IE6-IE8. Head over to [http://selectivizr.com/][1] to grab a copy [or get Selectivizr from Github][2]. 

It works with many different JavaScript libraries (like jQuery, Dojo, Mootools, Prototype etc. and others) and is activated by use of conditional comments for IE browsers greater than or equal to IE6 and less than or equal to IE8, providing a CSS fallback if JS is disabled: 

{% highlight html %}
<!--[if (gte IE 6)&(lte IE 8)]> 
<script type="text/javascript" src="selectivizr.js"></script> 
<noscript><link rel="stylesheet" href="[fallback css]" /></noscript> 
<![endif]-->
{% endhighlight %}

 [1]: http://selectivizr.com
 [2]: https://github.com/keithclark/selectivizr 
 
 And that's it. Just make sure the path to 'selectivizr.js' is correct and make sure you spell selectivizr right because it's a bit of a bugger to do.
