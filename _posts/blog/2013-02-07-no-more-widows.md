---
layout: post
title: "No more widows"
date: 2013-02-07
tags: Snippet
categories: blog
---
A widow is a term in typography that describes a single word on it's own line at the end of a paragraph. Designers and typographists *hate* widows and are forever complaining about them.

A super simple way of fixing them is to add a `<br>` where you want to force a line break. However, `<br>` doesn't play well with responsive or fluid design and sooner rather than later you'll face an even uglier situation.

A better way to avoid widows is to add a non-breaking space between the last two words of a paragraph. This is what the `&nbsp;` character is for. However, it can be a little tedious (and impossible if you don't have access to the raw text) to add these all over your website.

However, we can inject them using Javascript and a regular expression. Here's a little jQuery snippet:

{% highlight javascript %}
jQuery(function($){
    $('p').html(function(i, html) {
        return html.replace(/\s([\S]+)$/,'&nbsp;$1');
    });
});
{% endhighlight %}

This snippet loops through each paragraph and grabs the existing HTML. It then finds whitespace (`\s`) followed by one or more non-whitespace characters (`\S`) to the end of the line (`$`). It then replaces everything matched as non-whitespace to the end of the line with `&nbsp;` and then everything matched is appended. `$1` refers to everything matched in the group `([\S]+)`.

Nice and easy - and no more hassle about widows!
