---
layout: post
title: "An experiment with responsive images"
date: 2012-08-17
tags: Notes
categories: blog
---

Every now and again, I have the good fortune of starting a brand new project from scratch. I shamefully get quite excited when these opportunities come round - partly because it beats maintenance or adding a feature to a site fraught with conflicting content and code - and partly because in the ever changing landscape of front-end web development, there is always new things at the top of my list to experiment with. My currently project is well suited to being a fully responsive, fluid layout and although it's not particularly image heavy, I thought this would be a good opportunity to experiment with responsive image techniques. There's been a lot of #hotdrama recently between the developer community and the working groups, with a lot of back and forth about proposals for a new `<picture>` element or a new `<src-set>` attribute set on the `<img>` tag. That debate is not the concern of this article - I'm just going to recount my experience of implementing a responsive image solution on a real client project. There are a number of solutions to the responsive images problem - a good round up of them can be found at CSS-Tricks: [which responsive images solution should you use?][1]. Perhaps unsurprisingly given how current this debate is, there is not currently a native browser solution for any of these proposals. However, the clever chaps over at [Filament Group][2] have a Polyfill for the proposed `<picture>` element. And having heard quite a lot of chatter about this particular implementation on Twitter (usually via [@wilto][3]) and on various podcasts such as [Shop Talk Show][4] and [The Web Ahead][5], I decided that this was a good option to look in to. 

### Picturefill

[1]: http://css-tricks.com/which-responsive-images-solution-should-you-use/
[2]: http://filamentgroup.com/
[3]: https://twitter.com/wilto
[4]: http://shoptalkshow.com/episodes/020-with-mat-marquis/
[5]: http://5by5.tv/webahead/25 So the first thing I did was hop over to 

[Scott Jehl's picturefill Github repo][6] and had a look at the code and [the demo][7]. I grabbed a copy, linked up the script and it worked perfectly as described and without any configuration or anything - definitely one of those set-it-and-forget-it scripts. Sorted. Here is a sample of the markup used to generate the responsive image: 

{% highlight html %}
  <div data-picture="" data-alt="A giant stone face at The Bayon temple in Angkor Thom, Cambodia">
    <div data-src="small.jpg"></div>
    <div data-src="medium.jpg" data-media="(min-width: 400px)"></div>
    <div data-src="large.jpg" data-media="(min-width: 800px)"></div>
    <div data-src="extralarge.jpg" data-media="(min-width: 1000px)"></div>
    <!-- Fallback content for non-JS browsers. Same img src as the initial, unqualified source element. -->
    <noscript><img src="external/imgs/small.jpg" alt="A giant stone face at The Bayon temple in Angkor Thom, Cambodia"></noscript>
  </div>
{% endhighlight %}

It may be a lot of markup, but it simply provides a series of sources of different sized images to be used when associated media query conditions are satisfied. For a (better and) more detailed description, including info on how to additionally add HD images, have a look at [the readme at the picturefill repo][6]. This pollyfill uses divs to do the job that (perhaps one day) a new `<picture>` element might do slightly more gracefully: 

### The Real World

[6]: https://github.com/scottjehl/picturefill
[7]: http://scottjehl.github.com/picturefill/ 
 
The image in my project that I wanted to responsify (sp?) needed to have a class associated with it to be used in a slideshow. My first thought was to add 

`data-class="slide"` to the wrapper `<div data-picture="">`. However, this didn't work, so I went and had a bit of a Google. I found [a branch of picturefill][8] by a dude called John Michel that adds support for adding classes to generated images and grabbed a copy of that instead. Everything was working great but I had a feeling that there would be an element of frustration and tedium in having to create multiple versions of *every* image for use throughout this site. As the majority of our sites use [Timthumb][9]for dynamically resizing images in Wordpress templates, I wondered if I might be able to use it here to do some of heavy lifting. Traditionally Timthumb works like this: 

{% highlight html %}
  <img src="/path/to/timthumb.php?src=some-awesome-photo.jpg&w=400&h=300&zc=1&q=10" alt="some awesome photo">
{% endhighlight %}

Now that's pretty ugly looking but it simply tells the Timthumb script to generate an image on the server using the parameters passed via the query string - width ('w'), height ('h'), crop ('zc'), quality ('q') etc. To make the implementation a bit nicer looking, we wrapped it up in a function: 

{% highlight php %}
<?php
function timthumb($src, $w = 500, $h = 500, $zc = 1, $s = 1, $a = 'c') { 
  return 'path/to/timthumb' . '?' . http_build_query(compact('src', 'w', 'h', 'zc', 's', 'a')); 
} 
?>
/* sample usage: echo timthumb($image[0], 200, 100, 1, 12); */ 
{% endhighlight %}

So I got to thinking, if this little function can be used to create dynamically resized images, then maybe I can substitute it for every instance of `data-src` in picturefill. A bit like this: 

{% highlight php %}
<?php $image = wp_get_attachment_image_src( get_post_thumbnail_id(get_the_ID()), 'large'); ?>
  <div data-picture="" data-alt="photo" data-class="photo">
    <div data-src="<?php echo timthumb($image[0], 200, 100, 3, 12) ?>"></div>
    <div data-src="<?php echo timthumb($image[0], 400, 200, 3, 12) ?>" data-media="(min-width: 400px)"></div>
    <div data-src="<?php echo timthumb($image[0], 600, 400, 3, 12) ?>" data-media="(min-width: 800px)"></div>
    <!-- Fallback content for non-JS browsers. Same img src as the initial, unqualified source element. -->	
    <noscript><img src="<?php echo timthumb($image[0], 200, 100, 3, 12) ?>" alt="photo" class="photo" ?></noscript>
  </div>
{% endhighlight %}

It worked like a charm. Using the Network tab of the Chrome web inspector, you can also see that the script works as it should, only sending requests to Timthumb as each media query is triggered. To make implementing this even easier, I wrote a little snippet for Sublime Text 2 that allows you to tab through each attribute and mirror ones that are meant to be identical - reducing the risk of typo bugs. 

{% highlight php %}
<snippet>
  <content><![CDATA[
    <?php \$image = wp_get_attachment_image_src( get_post_thumbnail_id(get_the_ID()), 'large'); ?>
    <div data-picture data-class="$1" data-alt="$2" >
    <div data-src="<?php echo timthumb(\$image[0], $3, $4, 1, 12) ?>"></div>
    <div data-src="<?php echo timthumb(\$image[0], $5, $6, 1, 12) ?>" data-media="(min-width: ${7:400}px)"></div>
    <div data-src="<?php echo timthumb(\$image[0], $8, $9, 1, 12) ?>" data-media="(min-width: ${10:800}px)"></div>
    <div data-src="<?php echo timthumb(\$image[0], $11, $12, 1, 12) ?>" data-media="(min-width: ${13:1000}px)"></div>
    <!-- Fallback content for non-JS browsers. Same img src as the initial, unqualified source element. -->
    <noscript>
      <img src="<?php echo timthumb(\$image[0], $3, $4, 1, 12) ?>" class="$1" alt="$2">
    </noscript>
    </div>
  ]]></content>
  <tabTrigger>pic</tabTrigger>
</snippet>
{% endhighlight %}

### Fluid Images

[8]: https://github.com/johnmichel/picturefill
[9]: http://www.binarymoon.co.uk/projects/timthumb/ 

Typically when doing responsive design, images are given a little bit of CSS to make them flex and ensure that they don't overflow their containers and maintain their aspect ratio: 

{% highlight css %}
img { 
  max-width:100%; 
} 
{% endhighlight %}

This still works using this responsive images technique. However, if you are a crazed browser resizer, you will notice the images changing dimension as different media queries are trigged (this can be seen in 

[the picturefill demo][7]). 

In my use case of a slideshow which had to be fully fluid, this wasn't an ideal situation. But using a simple bit of CSS, any obvious changes in image dimensions were removed: 

{% highlight css %}
[data-picture] img { 
	width:100%; 
} 
{% endhighlight %}

At the edges of breakpoints there was some pixellation as an image was being stretched beyond it's actual size, but there was no skewing of aspect ratio. Of course, giving your responsive images 

`width:100%` will only work when they are constrained by a container (such as a slideshow wrapper or grid column) otherwise, you could end up with some pretty stretchy stretchy images. I think these are particular special cases when you would want seamless responsive images and most of the time, having images that noticeably change size would be totally acceptable. 

### Mobile First 

This technique (like most responsive web design techniques) is probably best used inline with the *Mobile First* concept. However, as RWD is only just being adopted at our agency, the concept of designing (and building) mobile first is a hard sell to clients and we tend to tackle things from a *Desktop First* perspective, although being as mindful as possible of all different devices from the outset. Fortunately, the picturefill script accepts `max-width` media queries as well as `min-width` ones; the only difference (and downside) here is that the largest image size is served to non-JS devices and non-media-query supporting devices which goes against the 'suggestion' that these are less capable and shouldn't be served the largest assets. As such, here is the version of the markup I used to implement picturefill using a desktop first process: 

{% highlight php %}
<div data-picture data-class="slide-img" data-alt="slide" ?>">
  <div data-src="<?php echo timthumb($src[0], 620, 330, 1, 12) ?>"></div>
  <div data-src="<?php echo timthumb($src[0], 620, 330, 1, 12) ?>" data-media="(max-width: 1000px)"></div>
  <div data-src="<?php echo timthumb($src[0], 450, 240, 1, 12) ?>" data-media="(max-width: 500px)"></div>
  <!-- Fallback content for non-JS browsers. Same img src as the initial, unqualified source element. -->
  <noscript><img src="<?php echo timthumb($src[0], 620, 330, 1, 12) ?>" class="slide-img" alt="slide"></noscript>
</div>
{% endhighlight %}

Have you used this or any other responsive images technique? Got any thoughts on the `<picture>` element or `<src-set>` proposals? Shoot me a tweet to let me know...
