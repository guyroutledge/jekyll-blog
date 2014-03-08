---
layout: post
title: "Reduce sub-pixel rendering issues with Sass functions"
date: 2014-03-03
tags: Snippet
categories: blog
---

Responsive design calls for lots of measuring, number crunching and
resizing of containers. To help with the maths side of things, I make heavy
use of custom Sass mixins and functions, but today I reached for
a handful of built-in Sass functions: `floor()`, `ceil()` and `round()`.

## The problem

I needed to position a HTML5 video over the viewport area of an
illustrated iPhone. I&rsquo;ve done something similar before with
background images and `background-size` (as seen in [the Kallo project
page](/projects/kallo/)) but as you can&rsquo;t set a video as
a background image (as far as I&rsquo;m aware) I had to take a different
approach.

I used an `img` tag for the device illustration and a `video` tag for
the video, laying them on top of each other with absolute positioning.
The benefit of using an image tag for the phone was so that it could
scale as the browser reduced in size. In order to maintain the correct
position of the video, I used percentage width, height and positioning
values. 

![Illustration of iPhone with video](/images/iphone-video.png)

To keep things simple, I used a couple of variables and did some inline
calculations with Sass:

{% highlight scss %}
$device-width:658; $device-height:300;
$video-width:480; $video-height:275;
$video-top:13;
$video-left:86;

.device-video {
	position:absolute;
	top:($video-top / $device-height) * 100%;
	left:($video-left / $device-width) * 100%;

	width:($video-width / $device-width) * 100%;
	height:($video-height / $device-height) * 100%;

	// other styles
}
{% endhighlight %}

This worked great on Chrome on desktop but black lines were being
introduced around some of the edges on some mobile devices.

I tweaked the values around in the web inspector to see if my
calculations were off at all. I found that using round numbers gave the
best results which could have been down to how different browsers handle
sub-pixel rendering.

## Rounding values with Sass

Much like other programming languages such as JavaScript, Sass has
in-built functions to help turn floating point numbers into
integers; decimals into whole numbers.

Sass can round your numbers up, down or to the nearest whole number. 
Using the example above, here is some sample output from each of these
functions. You can test this output in the console using `@debug` in
your own Sass files.

{% highlight scss %}
top: floor(($video-top / $device-height) * 100%);
// always round down to the nearest whole number
// 91.666666667% --> 91%

top: ceil(($video-top / $device-height) * 100%);
// always round up to the nearest whole number
// 91.666666667% --> 92%

top: round(($video-top / $device-height) * 100%);
// round to the nearest whole number
// 91.666666667% --> 92%
{% endhighlight %}

Using a combination of `floor` and `round` I was able to get consistent
rending across all devices. The beauty of this method is that if a new
device image is produced with different dimensions or the video needs to
change size, all the numbers can be plugged in and Sass can do all the
hard work. 

## Tidying up

In reading up on these rounding functions, I also noticed that Sass has
a `percentage()` function that turns a whole number value into
a percentage which makes the `* 100%` part of the calculation redundant.

{% highlight scss %}
width:floor( percentage($video-width / $device-width) );
height:round( percentage($video-height / $device-height) );
{% endhighlight %}

It&rsquo;s worth mentioning that Sass won&rsquo;t remove the problem of
sub-pixel rendering, but it provides a few additional tools in it&rsquo;s
box for helping work around the problem. 

I&rsquo;ve said it before and I&rsquo;ll say it again: Sass is awesome.
