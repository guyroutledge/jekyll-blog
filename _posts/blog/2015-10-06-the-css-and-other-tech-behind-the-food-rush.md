---
layout: post
title: "The CSS and other tech behind The Food Rush"
date: 2015-10-06
tags: CSS, business
categories: blog
---

I’m building [a new online magazine to showcase food
innovation](http://www.thefoodrush.com), food startups, food
entrepreneurs and food events. Yesterday [I wrote about what we’re
doing](https://medium.com/@guyroutledge/starting-my-second-startup-of-the-year-43eae24794f0)
and some of the lessons learned from doing this kind of thing in the
past (spoiler alert: they didn’t work so well last time).

My background is web development so I thought I might as well go into
detail about the tech side of the product we’re building. Since this is
a personal project with no client restrictions, no NDAs and no
stakeholders to please (other than myself and my partner) we’re building
the whole thing in the open and blogging, photographing and videoing the
process to help and inspire others and to keep ourselves on the straight
and narrow.

But enough of the why and the what, let’s talk tech.

## The Stack 

The site is build on WordPress on top of a [starter
theme](https://github.com/saplingdigitalltd/fertilizer) that I’ve
developed for my digital agency, Sapling Digital. This boilerplate is
still very much a work in progress but I’m planning to keep it open
source for anyone who cares to use it.

We’re using [Timber and Twig](http://upstatement.com/timber/) for
templating. This provides a kind of model + view architecture for
WordPress in a similar vein to frameworks like Ruby on Rails or Laravel.
Similar but different. This is a plugin I’m experimenting with for the
first time and it’s absolutely fantastic.  More write-ups to come.
Additional plugins in use are the awesome [Advanced Custom
Fields](http://www.advancedcustomfields.com) plugin and [Yoast's SEO
plugin](https://yoast.com/wordpress/plugins/seo/) to help with search
optimization and `og:` meta tags for Facebook, Twitter etc..

We’re using [Sass](http://www.sass-lang.com) for CSS pre-processing.
We’re using a [BEM](http://www.bem.info)-like naming convention to keep
the styles as modular as possible.

We’re using Gulp for task automation (our exact [Gulpfile can be found
here](https://github.com/saplingdigitalltd/assets/blob/master/Gulpfile.js)).
I used to use Grunt but having seen the blazing fast awesomeness of Gulp
on a recent client project, I’m totally sold and have switched
everything over.

The site is hosted on a [Digital Ocean](http://www.digitalocean.com)
droplet running Ubuntu 14.04, PHP FPM, Nginx and MySQL.

Server provisioning is done with [Ansible](http://www.ansibleworks.com)
and deployment is managed through [Jenkins](https://jenkins-ci.org/).

Although this sounds like a lot of stuff to set up in just a couple of
days (which is how long I spent building the first version of the site),
this is something we do a lot at Sapling so we’ve honed the process
somewhat and most of it is automated.

## The CSS 

The site is somewhat in its infancy but there’s a couple of
interesting visual features we’re experimenting with. As the content of
this site is all about innovation and cutting edge stuff, we wanted the
design of the site to be something more than the standard grid of
off-white grey boxes.

### Overlapping Content

One of the ways we’re achieving this look is to have lots of overlapping
content, especially text boxes that cut into images.

![](/images/overlap.png)
![](/images/overlap2.png)

To do this, I've created a simple "overlap" module. It uses a pseudo
`:after` element, negative `z-index` `box-sizing: content-box` and some
positioning to add a solid box behind the text content.

{% highlight scss %}
$overlap: 3rem;
.overlap {
	position:relative;
	z-index: 100;

	&:after {
		content:"";
		box-sizing:content-box;

		position:absolute;
		top:$overlap * -1;
		left:$overlap * -1;

		width:100%;
		height:100%;
		padding:$overlap;

		background:$color-page-background;
		z-index: -1;
	}
}
.overlap__title {
	position:relative;
	z-index:200;
}
{% endhighlight %}

To ensure that any titles in the overlap box aren't overlapped by the
pseudo element, they’re given a higher `z-index` than the content box.

### Filtered Polaroids

Another style of images used throughout the site are more rough and
ready - the kind of thing you might snap on Instagram, Twitter, (or, god
forbid) Snapchat.

This effect has been somewhat overdone so I wanted to try a new spin on
it and have the images look intentionally more unpolished and grainy.

![](/images/grainy-photo.png)

I definitely don't want to have to put all these images through
a Photoshop process so wanted to come up with a CSS only solution.

Making the polaroid effect was very simple and just uses a white border
around a `figure` tag (with an optional image caption provided by
a `figcaption`). A solid `box-shadow` provides a bit of depth whist
still keeping the design fairly flat and blocky.

{% highlight css %}
.polaroid {
	position:relative;
	border:1rem solid #fff;
	border-bottom-width:4rem;
	box-shadow:0.5rem 0.5rem 0 #eee;
}
{% endhighlight %}

The interesting bit comes with the filters and the noise effect. The
noise is added via a pseudo `:after` element which is spread across the
whole width and height of the image. A data-uri image of a noise texture
is used as a background image and repeated across the element.

{% highlight css %}
.polaroid:after {
	content:"";
	position:absolute;
	top:0;
	left:0;

	width:100%;
	height:100%;
	background: url(data:image/png;base64,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);
}
{% endhighlight %}

To complete the effect, CSS filters are applied to boost the contrast
and reduce the saturation - both on the noise texture and the image
itself.

{% highlight scss %}
.polaroid {
	&:after {
		filter:contrast(1.52);
	}

	img {
		display:block;
		filter:contrast(1.25) saturate(0.5);
	}
}
{% endhighlight %}

Pretty nifty and no Photoshop required!

Even though this uses CSS filters which aren't that widely supported,
because this is purely a visual enhancement that doesn't bother me at
all. Users with older browsers will still see an image - and will even
see one with a noise texture - they just won't have the added contrast
and desaturation. No worries.

## More to come

This is just day 2 of our 10-day journey to build an MVP of an online
magazine and I hope there will be many more opportunities to write about
the tech behind the experiment. 

If you'd like to keep in touch with what we're up to, please follow
[@thefoodrush](http://www.twitter.com/thefoodrush) and [sign up to the
mailing list](http://www.thefoodrush.com/food-tech) to be notified of
when our first issue is ready for your viewing pleasure.
