---
layout: post
title: "Style guide colours with Sass"
date: 2014-05-14
tags: tutorial
categories: blog
---

Have you ever worked on a project and gone searching through design
files for a reference to the brand colours? Ever seen numerous similar
shades of a colour peppered throughout a codebase? If so, the project
might benefit from a style guide.

I’ve just started a new job and before charging in to building the
header, footer and homepage, I’ve created a page to demo all the base
styles: typography, spacing, grid, form inputs and colours. As I build
out a series of components for the site, those will be added too.

!['Colour swatches'](/images/swatch1.png)

In creating this guide, I came up with a nice technique for creating
colour swatches using Sass map variables, loops, pseudo elements and
interpolation - automatically outputting a series of classes along with
the accompanying hex code for the color on the page.


## The Problem

The big issue I’ve found with style guides is that they are often not
kept up to date. Because of this, I wanted to make it as easy as
possible to add a new colour swatch.

## Create a mapping

Sass 3.3 has introduced the idea of a "map" variable - a bit like
a Javascript object - allowing the ability to create a variable with a
series of key:value pairs.

{% highlight scss %}
$map: (
	'key' : 'value',
	'otherKey' : 'otherValue'
);
{% endhighlight %}

In my project, I have a series of variables for all the commonly used
colours: `$color-brand` for the main brand colour, `$color-copy` for the
text, `$color-link` for links etc. 

I created a map of these variables with a key that would be used in
creating the modifier classes for each colour swatch.

{% highlight scss %}
$colours: (
	'brand'     : $color-brand,
	'copy'      : $color-copy,
	'link'      : $color-link,
	'hover'     : $color-hover,
	'highlight' : $color-highlight,
	'error'     : $color-error
);
{% endhighlight %}

## Iterate

The next step was to iterate over each of the items in the `$colors` map
with a Sass `@each` loop, creating a series of classes with the correct 
background colour for each swatch.

{% highlight scss %}
.sg__colour {
	width:100px;
	height:100px;

	color:#fff;

	text-align:center;
	line-height:100px;
}
@each $name, $color in $colours {

	.sg__colour--#{$name} {
		background:$color;
	}
}
// outputs 
// .sg__colour--brand { }
// .sg__colour--copy { }
// .sg__colour--link { }
// etc.
{% endhighlight %}

I’ve used the BEM naming convention here which I’ve just started
experimenting with - perhaps the topic for a future post...

## Outputting the color code

I thought it would also be handy to output the color hex code beneath
the swatch but I wanted this to be automated to avoid any chance of
variable names and color codes getting out of sync.

Pseudo elements can be used to generate text content and this can be
combined with Sass interpolation to output the value of a variable
instead of using the variable in the code.

{% highlight scss %}
@each $name, $color in $colours {
	.sg__colour--#{$name} {
		background:$color;
		&:after {
			content: "#{$color}";
		}
	}
}
{% endhighlight %}

This pseudo element can then be positioned beneath the swatch using
`position:absolute`.

!['Colour swatches with hex output'](/images/swatch2.png)

And there you have it, an easy to maintain, Sassy colour swatch
generator.
