---
layout: post
title: "Better dotted borders with border image"
date: 2013-01-28
tags: Tutorial
categories: blog
---
A recent client project used dotted borders as a design feature; they were used on calls to action, in the secondary navigation and in form elements.

![Call to action][1]
[1]: /images/PreviewScreenSnapz001.png

![Navigation][2]
[2]: /images/PreviewScreenSnapz002.png

![Form Fields][3]
[3]: /images/PreviewScreenSnapz003.png

At first glance it seemed a simple case for CSS `border-style:dotted` but this resulted in some pretty crappy looking borders.

![CSS border-style:dotted][4]
[4]: /images/Google-ChromeScreenSnapz001.png

For one thing, CSS dotted borders are square rather than circular and the dots appear to double up in the corners. In this case, the design called for slightly larger dots with slightly more spacing too. After a bit of a head-scratch, I thought this could be a good case for the under-used and slightly confusing CSS `border-image` property.

### Enter CSS Border Image

The CSS3 `border-image` property does exactly what it says on the tin - it allows an image to be applied as the border to an element. However, it's one of those properties that's a little bit tricky to get your head round to start with.

I found a real world example of border image in use on [Chris Spooner's blog][5] and looking at the image used to generate the border, gave me a good enough starting point to make my own.

[5]: http:/.spoongraphics.co.uk/

![Border image in use][6]
[6]: /images/Google-ChromeScreenSnapz002.png

The long-hand declaration for border image looks a bit like this:

{% highlight css %}
.dotted-border {
    border-image-source: url('border-image.png');
    border-image-slice: 0px 0px 5px 0px;
    border-image-width: 1;
    border-image-outset: 0px 0px 0px 0px;
    border-image-repeat: repeat;
}
{% endhighlight %}

The only required properties are `border-image-source`, `border-image-slice` and `border-image-repeat`.

The slice, width and outset properties act just like margin and padding shorthand - Top, Right, Bottom, Left. Similarly if two values are specified, the first represents Top and Bottom, the second Right and Left etc.

`border-image-repeat` can take four values: `repeat`, `stretch`, `round` and `space`. These affect the scaling and tiling of the sides and middle portion of the border. I recommend [reading the border-image spec][7] and playing around in you're favourite web inspector to see the differences.

[7]: http://www.w3.org/TR/css3-background/#border-images

So a more compact declaration of border image could look like this

{% highlight css %}
.dotted-border {
    border-image:url('border-image.png') 5 repeat;
}
{% endhighlight %}

This is far more preferable - especially when you [think about the vendor prefixes you need to add][8]. Alternatively, you could use a pre-processor like SASS to cut down on some keystrokes.

[8]: http://caniuse.com/#search=border-image

### Creating the `border-image` image

Having grasped the concept behind border-image, the most complicated thing is to create the image in question. In this case, I needed a regularly spaced set of dots that could repeat infinitely.

One quirk (although necessary quirk) of border image is that it takes the supplied image and slices it into 9 parts as defined by the `border-image-slice` property. The center slice is ignored by default. I found the best way to work through the process of making the image was to add guides top, right, bottom and left at the same distance from the cavas edge as the `border-image-slice` (in this case 5px on all sides).

![border image with guides][9]
[9]: /images/guides.jpg

One thing to note is that when working out the spacing, it is the distance from the edge of the slice not the distance from the edge of the image canvas that counts. After a fair bit of trial and error to get the spacing just right, I had created my assets.

![border-assets][10]
[10]: /images/border-assets1.jpg

### Cross browser compatibility

`border-image` is supported in most modern browsers but not IE (not even IE10). To ensure that the layout and design were not totally broken, I agreed with the designer that in non-supporting browsers, the dotted borders would fall back to `border-style-dotted`. Using [a custom build of Moderizr][11], I tested for support and applied the following fall-back:

[11]: http://modernizr.com/download/#-borderimage

{% highlight css %}
/* fallback border style for legacy browsers (IE8-10 at time of writing) */
.no-borderimage .dotted-border {
    border-image:none;
    border:1px dotted #ccc;
}
{% endhighlight %}

Some of the non-supporting browsers tried to do something funky unless I explicitly unset `border-image`. I also found that Firefox didn't display the border correctly at all despite supporting `border-image`. 

After a bit of digging around, I found that Firefox needs a `border-style` property to be set to correctly display `border-image`. I added:

{% highlight css %}
border-style:dotted; /* for FF */
{% endhighlight %}

Which seemed to make the most sense.

One other cross-browser issue that I noted was sub-pixel rendering issues. In Chrome sometimes the borders looked a little non-uniform where as in Firefox they looked spot on. This is to do with how each browser handles rendering of non-whole pixels and something that is a little over my head to explain. The design was far from broken but it was a shame to have slightly inconsistent results that were out of my control (please let me know if there is any solution to this!)

Border image may be a little bit fiddly to use but it certainly has far more uses than just improving CSS dotted borders.

PS. you can check out the client project in question at [www.ward-thomas.co.uk][12].

[12]: http://www.ward-thomas.co.uk
