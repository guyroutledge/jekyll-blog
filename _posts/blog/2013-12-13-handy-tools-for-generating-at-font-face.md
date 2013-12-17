---
layout: post
title: "Handy tools for generating <code>@font-face</code>"
date: 2013-12-13
tags:
- Apps
- Workflow
categories: blog
---

I've always liked typography and having worked at a design agency, I've grown to
love it even more. Because of the many and varied sites and projects I've worked
on, it's common for me to need to generate webfonts from a variety of font
files. Here's a selection handy tools that make it a breeze.

## Font Squirrel

[Font Squirrel](http://www.fontsquirrel.com) is an excellent resource for
finding and downloading fonts but it also has a great [webfont generator
service](http://www.fontsquirrel.com/tools/webfont-generator) which will convert
any TTF or OTF font-file into everything you need to include a custom font on
your page.

[![Font Squirrel Generator Screenshot](/images/font-squirrel1.jpg)](http://www.fontsquirrel.com/tools/webfont-generator)

But what if your font files aren't in TTF or OTF format? 

## DfontSplitter

I was in this position recently and the guy that I usually ask for help with
converting fonts for me (on his fancy expensive type-designy software
thingy) wasn't available. So I went on a Google search.

I came across a [Stack Overflow
thread](http://stackoverflow.com/questions/15455895/convert-or-extract-ttc-font-to-ttf-how-to)
and a link to a cross-platform app called
[DfontSplitter](http://peter.upfold.org.uk/projects/dfontsplitter) that does
exactly what I was looking for; it would take a `.ttc` or `.suit` file - a font
collection or font suitcase in addition to dfont files and output all the
component fonts as a TTF in a directory of my choosing. Very useful!

[![DfontSplitter app screenshot](/images/dfontsplitter.jpg)](http://peter.upfold.org.uk/projects/dfontsplitter)

This worked great so I went back to Font Squirrel to create my webfonts.

Unfortunately, there was a problem with uploading the file. It was corrupt.
According to Font Squirrel anyway.

## Convert Fonts

Going back to the drawing board and 1 more Google search later, I found the
imaginatively named [Convert Fonts](http://convertfonts.com) and tried the
webfont creation process with them.

Boom. It worked. Their UI might not be as nice as Font Squirrel but when
stuff works, I can let things like that slide.

## Generating `@font-face` code with Sass

As a Sass lover and someone who always has a small handful of webfonts to
use in my projects, I've written a simple Sass loop that does a lot of the
heavy lifting of outputting all the necessary `@font-face` blocks.

{% highlight scss %}
// Generate @font-face declarations for a list of fonts
// relative path to fonts
$font-path: '../fonts/';
// the name that will be used in font-family property
$font-families: 'font1', 'font2', 'font3';
// the filename of your font without the file extension
$font-filenames: 'font1_filename', 'font2_filename', 'font3_filename';
$i: 1;
@each $font-family in $font-families {
  @font-face {
    font-family: $font-family;
    src: url($font-path + nth($font-filenames, $i) + '.eot');
    src: url($font-path + nth($font-filenames, $i) + '.eot?#iefix') format('embedded-opentype'),
         url($font-path + nth($font-filenames, $i) + '.woff') format('woff'),
         url($font-path + nth($font-filenames, $i) + '.ttf') format('truetype'),
         url($font-path + nth($font-filenames, $i) + '.svg#' + $font-family) format('svg');
    font-weight: normal;
    font-style: normal;
  }
  $i: $i+1;
}
{% endhighlight %}

This snippet takes all the fonts in the list of `$font-families` and generates 
the necessary CSS for using them as webfonts. 

It takes advantage of the Sass `nth()` function that returns the value of an
item in another list variable at the index of the *current* list variable. As such, both
the `$font-families` variable and `$font-filenames` need to be the same length
and map their corresponding values at the same index. It might help to think of
them as a bit like a JSON object:

{% highlight json %}
{
	"fonts" : [
		{ "family": "font1", "filename": "font1_filename" },
		{ "family": "font2", "filename": "font2_filename" },
		{ "family": "font3", "filename": "font3_filename" }
	]
}
{% endhighlight %}

All pretty straighforward - try it out yourself.

If you have any other recommendations for font related apps, tools and resources,
I'd love to hear about them. Just drop me a tweet [@guyroutledge](http://www.twitter.com/guyroutledge)
and let me know...
