---
layout: post
title: "Vim regular expressions and escape characters"
date: 2013-06-03
tags: Rants
categories: blog
---
Today I learned that regex in Vim can be even more irritating than normal regex.

I work for an agency that is (rightly) anal about typography which means that apostrophes should always be curly. This means (mis-)typing `&rsquo;` a lot. I thought I'd write a little `:substitute` command in my `vimrc` to make all apostrophes in body copy (titles, paragraphs, links and spans) "curly". I started off by working out a regex that would find such things:

{% highlight vim %}
/\v\&lt;(h[1-6]|p|a|span).+(\_.)*\zs'\ze(\_.)*\&lt;/\1\&gt;
{% endhighlight %}

Let's break it down

*   `/v` -- very magic switch that means less escape characters
*   `\<` -- find an opening tag
*   `(h[1-6]|p|a|span)` -- any tags for body copy
*   `(_.)*` -- zero or more characters (incl. new lines)
*   `\zs'\ze` -- limit the pattern to apostrophes followed by:
*   zero or more characters and accompanying closing tag (the `\1` matches the captured opening tag)

This (eventually) worked like a charm. It can no doubt be optimised by someone with more of a Vim Regex brain than me.

I also could have been smart about characters trailing the apostrophe (like 's, 'd, 'm, 'll, 've) etc. but this seemed needlessly complex and my brain was already hurting. I was then able to do a global substitute for the encoded curly quote:

{% highlight vim %}
:%s//\&rsquo;/
{% endhighlight %}

The next step was to transfer all this to my `.vimrc` - I mapped it to `<leader> Q` for "Quotes".

{% highlight vim %}
" replace aposrophes with curly ones in body copy
nnoremap &lt;leader&gt;Q :%s/\v\&lt;(h[1-6]|p|a|span).+(\_.)*\zs'\ze(\_.)*\&lt;/\1\&gt;/\&rsquo;/&lt;CR&gt;
{% endhighlight %}

Now I saved my config and was shouted at by Vim (my `.vimrc` auto sources on save).

![vimerror][1]

 [1]: http://www.guyroutledge.co.uk/wp-content/uploads/2013/06/vimerror.png

After a lot of head scratching it turned out that the `OR` operator needed to be escaped even when using `/v` and even though it worked whilst searching and substituting in a buffer - I believe it has something to do with `|` having some kind of special meaning in vimscript.

This is the final snippet:

{% highlight vim %}
" replace aposrophes with curly ones in body copy
nnoremap &lt;leader&gt;Q :%s/\v\&lt;(h[1-6]\|p\|a\|span).+(\_.)*\zs'\ze(\_.)*\&lt;/\1\&gt;/\&rsquo;/&lt;CR&gt;
{% endhighlight %}

Problem solved, designers happy and lots of curly quotes everywhere.
