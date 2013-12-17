---
layout: post
title: "The checkbox design pattern"
date: 2013-06-13
tags: Snippet
categories: blog
---
Working on a lot of client sites that all want to capture data and ensure people agree to terms and conditions, the "checkbox floated next to a label" design pattern is something that comes up all the time.

It may be a common pattern and straightforward to implement but as a result, there are many different ways to apply CSS to get the desired result. I've seen countless variations on a theme of floats and positioning but here's the snippet that I use consistently:

{% highlight css %}
/*
<li class="checkbox-container">
	<input type="checkbox" id="checkbox">
	<label for="checkbox"></label>
</li>
*/
.checkbox-container input,
.checkbox-container label {
    display:inline-block;
    vertical-align:top;
}
.checkbox-container input {
    margin-right:0.25em;
}
.checkbox-container label {
    width:90%; /* tweak depending on the overall width of your form */
    cursor:pointer; /* label linked to input via "for" attribute */
}
{% endhighlight %}

One of the benefits here is that there is no need to clear any floats. The module is also robust and portable as there are no explicit widths declared.

If you were overly concerned with the `label` coming first in the source order, you would have to use `float:left` on the input instead of `display:inline-block`. This wouldn't be a big deal - I'm just trying to keep the number of floats to a minimum these days...

As `inline-block` can be a bit flakey in IE (and not working in IE7 at all), you may want to use some [star hacks][1] and add `*zoom:1` and `*display:inline` to get IE7 into shape.

[1]: http://www.phpied.com/the-star-hack-in-ie8-and-dynamic-stylesheets/

If you found this snippet useful, or have anything else to say, shoot me a tweet [@guyroutledge][2].

[2]: http://www.twitter.com/guyroutledge
