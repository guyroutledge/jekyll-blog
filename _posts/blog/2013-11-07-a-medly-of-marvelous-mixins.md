---
layout: post
title: "A medly of marvelous mixins"
date: 2013-11-07
tags: snippet
categories: blog
---

When starting a new project, I begin by importing boilerplate code - stuff that I've written and improved upon over time. Here are a few of my favourite Sass mixin snippets which I use constantly to help speed up my workflow. I've created a gist for each of them so you can copy, paste and comment on to your heart's content. On with the round-up...

## Style highlighted text

Because you can't comma-separate the declarations for selection (or at least you couldn't at one point), it's easier to create a mixin that can accept foreground and background colours. I also find it makes highlighted text easier to read if any text-shadow is removed.

{% highlight scss %}
@mixin selection($background, $foreground:#fff) {
    ::-moz-selection { 
		background: $background; 
		color: $foreground; 
		text-shadow: none; 
	}
    ::selection { 
		background: $background; 
		color: $foreground; 
		text-shadow: none; 
	}
}
{% endhighlight %}

[Gist: mixin-selection.scss][1]

 [1]: https://gist.github.com/guyroutledge/7041727

## Background Image Replacement

This mixin takes advantage of the `image-width()` and `image-height()` functions in [Compass][2] that returns the dimensions of an image.

 [2]: http://www.compass-style.org

{% highlight scss %}
@mixin background-image-dimensions($image) {
    width:image-width($image);
    height:image-height($image);
    background-image:url($image);
}
{% endhighlight %}

[Gist: mixin-background-image-dimensions.scss][3]

 [3]: https://gist.github.com/guyroutledge/7041755

## Text Replacement

An old-school but still reliable way of doing image replacement. Keeping the `screen-reader-text` placeholder separate means it can be used elsewhere in the codebase without image replacement.

{% highlight scss %}
%screen-reader-text {
    text-align:left;
    text-indent:-9999px;
}
@mixin image-replacement($image) {
    @include background-image-dimensions($image);
    @extend %screen-reader-text;
}
{% endhighlight %}

[Gist: mixin-image-replacement.scss][4]

 [4]: https://gist.github.com/guyroutledge/7041797

## Respond to breakpoint: simple media queries

I get bored of typing out media query syntax so this nice little wrapper comes in handy. If you work [Mobile First][5] you can set the default property to "min-width".

 [5]: http://www.abookapart.com/products/mobile-first

{% highlight scss %}
@mixin respond-to($breakpoint, $property:max-width) {
    @media screen and ($property:$breakpoint) {
        @content;
    }
}
{% endhighlight %}

[Gist mixin-respond-to.scss][6]

 [6]: https://gist.github.com/guyroutledge/7041830

## Placeholder

Style the placeholder text in form inputs.

{% highlight scss %}
@mixin placeholder() {
    ::-webkit-input-placeholder {
        @content;
    }
    ::-moz-placeholder {
        @content;
    }
    :-moz-placeholder {
        @content;
    }
    :-ms-input-placeholder {
        @content;
    }
}
{% endhighlight %}

[Gist mixin-placeholder.scss][7]

 [7]: https://gist.github.com/guyroutledge/7041847

## Bonus - turn `px` into `em`

Not a mixin but a function and it's really useful for calculating a size in ems based on a known pixel size and context.

{% highlight scss %}
@function calc-em($target-px, $context) {
    @return ($target-px / $context) * 1em;
}
{% endhighlight %}

[Gist function-calc-em.scss][8]

 [8]: https://gist.github.com/guyroutledge/7041896

* * *

If you found any of these mixins useful or if you have any of your own that you can't live without, I'd love to hear about them. Drop me a tweet [@guyroutledge][9] or leave a comment below.

[9]: http://www.twitter.com/guyroutledge
