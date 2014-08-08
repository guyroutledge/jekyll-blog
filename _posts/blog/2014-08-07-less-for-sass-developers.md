---
layout: post
title: "Less for Sass developers"
date: 2014-08-08
tags: Workflow
categories: blog
---

I'm a Sass fan. I've used it for the last couple of years now and would
use it on every project if I had the choice. However, as
a contractor, I've had the opportunity (been forced) to use numerous
productivity tools such as pre-processors on a range of projects.

Currently I'm working for an agency that uses both
[Sass](http://www.sass-lang.com) and [Less](http://www.lesscss.org)
- they initially used Less but are transitioning into Sass for some
projects. I'm currently stuck on one of their legacy project so have had the
chance to try my hand at the "other" pre-processor for the last couple
of weeks.

## First impressions

While I prefer Sass, I don't want this post to become a 
Less-bashing one. To be brutally honest, the two tools are pretty much the
same these days and they *both* make writing CSS easier, more powerful
and more fun. 

The most notable thing is a difference in syntax - but
even then, the differences are minor. It was incredibly quick to get
used to - doing the same things and working (mostly) the same way I'm used
to, just with different syntax.

## What do they share?

As far as I could tell within the boundaries of a fairly simple project,
Less and Sass both have the following features in common:

* Variables
* Nesting
* Interpolation
* Parent selectors
* Math
* `@import` to concatenate multiple files
* Mixins
* Extend (sort of)
* Custom Functions (sort of)
* Built in functions
* Loops (recursive mixins in Less)

## How are they different?

Instead of going into lengthy descriptions about all the differences, I thought
I'd cut to the chase and provide a side-by-side comparison of the
syntax. The Sass will be first, the Less will be second.  Here goes:

### Variables

{% highlight scss %}
$color-pink: #cc3f85;
a { 
	color: $color-pink;
}
{% endhighlight %}
{% highlight scss %}
@color-pink: #cc3f85;
a { 
	color: @color-pink;
}
{% endhighlight %}

Sass uses the `$` sign to create a variable, Less uses the `@` symbol.
I'm not keen on Less' choice to use `@` as it's already used in vanilla
CSS to mark a block rule like `@media` or `@supports`.

### Nesting

These are the same in both languages. Nesting selectors reduces the
amount you need to type but I always like to keep the number of levels
to a minimum.

{% highlight scss %}
.nav-primary {
	li {
		display:inline-block;

		&:hover .sub-menu {
			display:block;
		}
	}
}
// outputs
// .nav-primary li { display:inline-block; }
// .nav-primary li:hover .sub-menu { display:block; }
{% endhighlight %}

The `&` character is used to reference the parent selector - both Sass
and Less have this feature too.

### Interpolation

Interpolation allows a variable value to be used as a selector name or
as part of an image path. The major difference is the placement of the
variable token `$` or `@`.

{% highlight scss %}
$selector: 'carousel';
.#{$selector} {
	display:none;
}
// outputs .carousel { display:none; }
{% endhighlight %}
{% highlight scss %}
@selector: carousel;
.@{selector} {
	display:none;
}
{% endhighlight %}

### @import to concatenate multiple files

While both Sass and Less can have a single compiled stylesheet made up
of multiple `@import`ed files, there are some differences. Sass
`partials` start with an underscore character and never compile into
their own stylesheet.

Less doesn't use this underscore naming convention and any partial file
*can* be compiled into it's own file if told to. I started off using the
[Less.app Mac app](http://incident57.com/less/) to compile my code
before moving over to a [Grunt
task](https://github.com/gruntjs/grunt-contrib-less).  Unless you're
careful, the app will build every component file into it's own
stylesheet - which is probably not what you want!

### Mixins

One of the major differences between the two languages comes in the area
of `mixins`. The basic syntax is as follows for each:

{% highlight scss %}
@mixin button($foreground, $background) {
	color:$foreground;
	background-color:$background;
}
.submit-button {
	@include button(#000, #fff);
}
{% endhighlight %}

{% highlight scss %}
.button(@foreground, @background) {
	color:@foreground;
	background-color:@background;
}
.submit-button {
	.button(#000, #fff);
}
{% endhighlight %}

I personally find the Less method here a bit confusing because without
the `@include` keyword, you could be easy to mistake this for nesting
selectors. 

In Sass, the code for a mixin is never output until used with
`@include`. In Less, mixins are output by default. This can be avoided
by adding parentheses after the selector - even if the mixin doesn't
accept any arguments.

{% highlight scss %}
.brand-colors() {
	color:#000;
	background:#fff;
}
.call-to-action {
	.brand-colors;
}
// outputs
// .call-to-action { color:#000; background:#fff; }
{% endhighlight %}

### Extend

`extend` is a bit like `mixin` but instead of outputting (and repeating)
styles everywhere, common styles are comma separated in the compiled
output.

{% highlight scss %}
.copy-font {
	font-family:'Baskerville', 'Palatino', 'Times', serif;
	text-transform:uppercase;
}
.sub-heading { @extend .copy-font; }

// output
//.copy-font,
//.sub-heading {
//	font-family:'Baskerville', 'Palatino', 'Times', serif;
//	text-transform:uppercase;
//}
{% endhighlight %}
{% highlight scss %}
.copy-font {
	font-family:'Baskerville', 'Palatino', 'Times', serif;
	text-transform:uppercase;
}
.sub-heading { 
	&:extend(.copy-font); 
}
{% endhighlight %}

Sass has silent `%placeholder` classes that can be `@extend`ed as needed
but not output in the compiled code.  Less doesn't have this feature but
does do all kinds of weird and wonderful things with [it's version of
the extend directive](http://lesscss.org/features/#extend-feature).

### Custom Functions (sort of)

In Sass we have the `@function` declaration which allows an `@return`
value to be passed back out of the function. In Less, something similar
can be achieved with mixins.

{% highlight scss %}
@function calc-em($px-value, $context-px) {
	@return ($px-value/$context-px) * 1em
}
.headline {
	font-size: calc-em(10px, 16px);
}
// outputs 
//.headline { font-size:0.625em; }
{% endhighlight %}
{% highlight scss %}
.calc-em(@px-value, @context-px) {
	@font-size:(@px-value/@context-px) * 1em;
}
.headline {
	.calc-em(10px, 16px);
	font-size:@font-size;
}
{% endhighlight %}

In the Less world, the `@font-size` variable created by the mixin is
scoped within the `.headline` selector so can be used just like any
normal variable.

### Built in functions

Both pre-processors have an extensive reference of built-in functions:

* [Sass function reference](http://sass-lang.com/documentation/Sass/Script/Functions.html)
* [Less function reference](http://lesscss.org/functions/)

These functions do things like lightening or darkening colours, checking
variable types, rounding numbers up or down etc. Less has a vast array
of built in math functions, some of which you'd have to use a library
like [Compass](http://www.compass-style.org) for in Sass.

### Loops (recursive mixins in Less)

Sass has three different types of loops - I like them a lot! Less gets
close with recursive mixins which are kind of like a `for` loop.

{% highlight scss %}
@for $i from 1 through 3 {
	.grid-#{$i} {
		width: $i * 300px;
	}
}

// outputs
//.grid-1 { width:300px }
//.grid-2 { width:600px }
//.grid-3 { width:900px }
{% endhighlight %}

{% highlight scss %}
.generate-grid(@n, @i:1) when (@i =< @n) {
	.grid-@{i} {
		width: @i * 300px;
	}
	.generate-grid(@n, (@i + 1));
}
.generate-grid(3);
{% endhighlight %}

Sass also has `@while` and `@each` loops which I use a lot - given how
complex things get with Less recursive mixins, I'm not sure how
practical it would be to try and replicate that kind of functionality
- although if it can be done, I'd love to see it!

## Wrap up

So, there you have it. A lot of similar functionality with a few
differences in syntax and approach. As I've already mentioned, I'm
a Sass fan and I'll be sticking with it whenever I can - but that's only
because I'm used to it and find the syntax easier to read. The small
amount of extra power of Sass goes slightly in it's favour but if you're
already a Less power user, stick with what you know.

If you're not pre-processing at all yet, hopefully this has given you an
insight into the kind of things that can be done and a bit of a flavour
of two of the more popular contenders.

I'd love to hear your thoughts, so [shoot me
a tweet](http://www.guyroutledge.co.uk) and let me know your preference
and why...!
