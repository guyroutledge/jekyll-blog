---
layout: post
title: "Generating multiple colour schemes with Sass"
date: 2013-10-21
tags: Tutorial
categories: blog
---
I've worked on a few sites recently that featured multiple sections or pages with different colour schemes. This is relatively straightforward to do but is even easier and quicker to implement when using [Sass][1] or another pre-processor.

[1]: http://www.sass-lang.com

Generating colour schemes can lead to many hundreds or even thousands of lines of code which increases page-weight and lengthen compile times. Here's my latest solution that tries to avoid overly-bloated code.

## Some examples

In the last few months, I've taken the front-end lead on a number of sites that have called for different colours-schemes. You can see examples by taking a look at the product pages of [Steve's Leaves][2] or [Kallo][3]. Most recently, I implemented an "improved version" on a re-branded site for [Thomas J Fudges][4].

[2]: http://www.stevesleaves.co.uk/the-range
[3]: http://www.kallo.com/things-we-make
[4]: http://www.thomasjfudges.co.uk

## The concept

In each case, the sites would start with a default colour scheme for things like page background, headings and link colours. The colours are added via Sass variables here for nice [DRY code][5]:

[5]: http://en.wikipedia.org/wiki/Don't_repeat_yourself

{% highlight scss %}
body {
    background:$color-background;
}
h1, h2, h3, h4, h5, h6 {
	color:$color-heading;
}
a {
	color:$color-link;

	&:hover, &:focus, &:active {
		color:$color-link-hover;
	}
}
{% endhighlight %}

To create a colour scheme and apply it to a specific page, all we need to do is add a body class and override the styles.

{% highlight scss %}
// <body class="colour-scheme-orange"></body>
.colour-scheme-orange {
    background:$color-orange-background;

    h1, h2, h3, h4, h5, h6 {
        color:$color-orange-heading;
    }
    p {
        color:$color-copy;
    }
    a {
        color:$color-orange-link;
    }
}
{% endhighlight %}

This will work fine but if you had 20 different colour schemes to create, you would end up writing a lot of duplicate code.

## Solution 1: Use `@mixin`

We can save ourselves a lot of hassle and tidy our code up by creating a [Sass mixin][6]. A mixin is like a cookie-cutter for outputting similar blocks of code under variable conditions. The powerful feature of mixins is that they can accept arguments which allows you to create these variable conditions.

[6]: http://sass-lang.com/documentation/file.SASS_REFERENCE.html

{% highlight scss %}
@mixin colour-scheme($background, $heading, $copy, $link ) {
    background:$background;
    h1, h2, h3, h4, h5, h6 {
        color:$heading;
    }
    p {
        color:$copy;
    }
    a {
        color:$link;
    }
}
{% endhighlight %}

Here we create a mixin with four arguments for four different colours. We can now use it as follows:

{% highlight scss %}
.colour-scheme-orange {
    @include colour-scheme($color-orange-background, $color-orange-heading, $color-orange-copy, $color-orange-link);
}
.colour-scheme-pink {
    @include colour-scheme($color-pink-background, $color-pink-heading, $color-pink-copy, $color-pink-link);
}
/* etc. */
{% endhighlight %}

This is fine for the small number of properties we want to override here. However, in the real-world example of the Kallo site, the colour-scheme mixin contained *220* lines of SCSS (with comments and line-breaks removed!). The site also required *25 different colour schemes*. If you do the math, that's 5500 lines of code generated with Sass to simply provide different colours for each product.

## Solution 2: Make use of silent `%placeholders`

Sass 3.2 introduced a feature known as [silent placeholders][7]. These allow you to construct modules for code-reuse and then extend them into a semantically named class. I wrote an article for 12 Devs about [using Sass placeholders for more semantic grids][8] which goes into some depth about how they can be really useful for keeping your code clean and meaningful to fellow developers.

 [7]: http://sass-lang.com/documentation/file.SASS_REFERENCE.html#placeholder_selectors_
 [8]: http://12devs.co.uk/articles/semantic-grids-with-sass-loops-and-silent-placeholders/

We can improve on the mixin solution above by combining placeholders with a mixin. For each colour property we want to change, we create a default placeholder and use that throughout the whole of the codebase and then override it using a mixin in the same way as before.

{% highlight scss %}
/* Default colour-scheme placeholders */
%cc-background {
    background-color:$color-background;
}
%cc-heading {
    color:$color-heading;
}
%cc-copy {
    color:$color-copy;
}
%cc-link {
    color:$color-link;
}

/* Default usage with @extend */
body {
    @extend %cc-background; /* compiles to background-color:#fff; for example */
}
h1, h2, h3, h4, h5, h6 {
    @extend %cc-heading;
}

/* Mixin */
@mixin colour-scheme($background, $heading, $copy, $link ) {
    %cc-background {
        background-color:$background;
    }
    %cc-heading {
        color:$heading;
    }
    %cc-copy {
        color:$copy;
    }
    %cc-link {
        color:$link;
    }
}

/* Mixin usage (same as before) */
.colour-scheme-orange {
    @include colour-scheme($color-orange-background, $color-orange-heading, $color-orange-copy, $color-orange-link);
}
.colour-scheme-pink {
    @include colour-scheme($color-pink-background, $color-pink-heading, $color-pink-copy, $color-pink-link);
}
{% endhighlight %}

It may be useful to look at the sample output of this solution. Imagine, you have a site with a handful of pages split across multiple partials and stylesheets. If they all use the `@extend` directive to set up all the necessary default colours and then override them, the output you get will look a bit like this (simplified version):

{% highlight scss %}
h1, 
h2, 
h3, 
h4, 
h5, 
h6, 
.main-nav-item, 
.footer-nav-item, 
.product-sub-title {
    color:#000;
}
.colour-scheme-orange h1, 
.colour-scheme-orange h2, 
.colour-scheme-orange h3, 
.colour-scheme-orange h4, 
.colour-scheme-orange h5, 
.colour-scheme-orange h6, 
.colour-scheme-orange .main-nav-item, 
.colour-scheme-orange .footer-nav-item, 
.colour-scheme-orange .product-sub-title {
    color:#f60;
}
{% endhighlight %}

This will still split out a lot of code if you have a lot of specific overrides and a lot of colour schemes, but this approach feels cleaner and more succinct to me.

As well as being succinct, this method avoids issues with specificity that comes from applying the colour-scheme via a body class. By doing that, you automatically increase the specificity of each selector across the board. This may mean that all links inherit the colour scheme styles rather than something you had previously set up as a custom case; links in headings or in the site navigation are often designed to be a different colour to links in body copy for example. When you run into this issue (as I did), it's easy to counteract the problem by overriding your overrides in the colour-scheme mixin. However, this is the main culprit behind generating masses of lines of code and we end up right back where we started. We can do better than that and this improved solution seems to go some way to solving the problem.

If you've had success with a different approach, I'd love to hear about your solution! Shoot me a tweet [@guyroutledge][9].

 [9]: http://www.twitter.com/guyroutledge
