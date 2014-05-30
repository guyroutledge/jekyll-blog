---
layout: post
title: "Simplify font size with rems"
date: 2014-05-29
tags: Tutorial
categories: blog
---

First everyone used pixels - because they are easy to get your head
around - then `em` became the new hotness, and now I find `rem` are
being used more and more in modern web development. This makes sense
because they greatly simplify the amount of thinking required when
sizing things in CSS. 

## What are ems?

`em` is a unit of measurement that is relative to the font size of it’s
parent. They can be used anywhere in CSS where you’d specify a width,
height, margin, padding, font-size, media query, and many other places.

The great thing about using a relative font size for spacing things is
that increasing the font size (in CSS or by the user) increases
everything proportionally.

If using `em` in `@media` queries, increasing the font size will also
trigger breakpoints which is a nice feature.

## Calculating sizes in ems

When transitioning from pixels to relative units, it’s common to want to
"convert" a pixel size into `em` or `rem` - as you use them more
frequently, you start thinking relatively and thinking in pixel values
becomes less of a thing.

To calculate `20px` in `em` for an element in a given container, you
divide the target pixel value by the the font size of the container;
this is often the base font size, which is usually `16px`.

	ems = target / context
	20px in ems = 20px / 16px = 1.25em
	10px in ems = 10px / 16px = 0.625em

If you use a CSS pre-processor you could create a function to do this
for you. Shown here in Sass:

{% highlight scss %}
@function calc-em( $target-px, $context-px ) {
	@return ( $target-px / $context-px ) * 1em;
}
.thing {
	font-size: calc-em(20px, 16px);
}
{% endhighlight %}

## The trouble with ems

Because `em` is a relative unit, and relative to the parent font size,
you can get some slightly strange behaviour with nested elements that
have a size greater than or less than 1em.

{% highlight html %}
<ul>
	<li>lorem ipsum</li>
	<li>lorem ipsum
		<ol>
			<li>lorem ipsum</li>
			<li>lorem ipsum</li>
		</ol>
	</li>
	<li>lorem ipsum</li>
</ul>
{% endhighlight %}

Take a nested list for example, if the font size of the list items is
set to `0.75em` any nested list items will have font size "`0.75em` of
`0.75em`" which is `0.5625em`. You’d end up with an ever decreasing font
size which is probably not what you want.

The same would be true of a font-size greater than 1 but font sizes
would *increase* exponentially.

## What are rems?

The "r" in `rem` stands for "root". `rem` is a measurement sized
relative to the root `<html>` element. As every `rem` dimension is
measured from the root rather than an element’s parent, the issue of
growing or shrinking text is removed.

`rem` is supported in IE9+ but if you need support for old versions of
Internet Explorer, you can specify a `px` fallback.

{% highlight css %}
.thing {
	font-size:10px;
	font-size:0.625rem; /*assuming default root font size of 16px*/
}
{% endhighlight %}

## Simplify calculations

`rem` simplifies the issue of growing or shrinking text but there is
still a calculation needed and there can be a bit of thinking required
when writing the fallback - especially because (as in the example above)
there is a disconnect between the number "10" for `px` and "0.625" for
`rem`.

If you set the root font size to `10px` instead of the default `16px`,
the relationship is a lot easier to see.

{% highlight css %}
html {
	font-size:10px;
}
.thing {
	font-size:20px;
	font-size:2rem;
}
{% endhighlight %}

Seems a lot more intuitive, right?

The only issue here is that setting the root font size in pixels can
overwrite any user defined preferences in the browser. This can be
worked around by setting `font-size:62.5%` instead which is the
equivalent to `10px`.

To automate the fallback writing process (with Sass) you could write
a `mixin` for generating both lines of code.

{% highlight scss %}
@mixin calc-rem-with-px-fallback( $font-size ) {
	font-size: $font-size * 1px;
	font-size: $font-size/10 * 1rem;
}
.thing {
	@include font-size(20);
	/* outputs
	font-size:20px;
	font-size:2rem;
	*/
}
{% endhighlight %}

Whether you like the idea of setting the root font size to `10px` (or
equivalent) or just use the default root font size, moving to `rem` for
sizing things takes away some of the pain of using `em` without
sacrificing any of the benefits. Sounds good to me!
