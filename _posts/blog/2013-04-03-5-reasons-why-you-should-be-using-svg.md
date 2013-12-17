---
layout: post
title: "5 reasons why you should be using SVG"
date: 2013-04-03
tags: Rants
categories: blog
---
I'm not normally allowed to do design these days - for a start, I can barely use Illustrator (my workplace's design tool of choice) but I've recently been dabbling. And I've quite enjoyed it.

Some of my recent dabbling has been with a side-project: [Regexcavate][1] - a natural language regex parser. Part of the design process was to create a logo and having listened to some designer types talking about logos, I knew it should be vector based. I think I learned more about Illustrator during this process than I have in the last 12 months of using it to reference designs I've been coding up.

[1]: http://www.regexcavate.com/

Having created the logo I wanted to add it to the site; I thought it would be silly to export it as a PNG having taken the time to make it all vector so I went to check out the support tables for SVG and that led me to come up with these 5 big reasons to use SVG.

### 1. The browser support is very good

<figure>
<img src="/images/svg-support1.jpg" alt="Support tables for SVG in Mar 2013">
<figcaption>SVG support 03/2013</figcaption>
</figure>

Holy crap, [SVG is supported everywhere][3] (except < IE8), I thought, why the hell aren't more people using it? The above image is for basic support but it's the same story with embedded `img` tags and CSS backgrounds. The only thing that gets a little experimental is filters, animations and fonts but they are still pretty well supported.

[2]: /images/svg-support1.jpg
[3]: http://caniuse.com/svg

### 2. Retina Ready

With the responsive images debate still raging in some corners of the internet and hi-def displays springing up all over the place, the days of raster graphics are surely numbered. Who wants to manually create multiple 1x and 2x (and everything in between) assets for everything? Icon fonts have been gaining popularity and are a great way to deal with the need for small high resolution graphics so why have larger SVG graphics not caught on so widely? They are in use, but haven't yet become the next buzz word.

### 3. Easy to implement

Want a code example? Here it is:

{% highlight html %}
<img src="logo.svg" alt="Logo" width="512" height="216">
{% endhighlight %}

Or if you prefere the background image approach

{% highlight css %}
.logo {
    width:512px;
    height:216px;
    background:url('logo.svg');
    background-size:100%;
}
{% endhighlight %}

### 4. The file size is small

The Regexcavate logo as an SVG is 13kb and as a PNG is 19kb at 512 x 216

![PNG regexcavate logo][4]

[4]: /images/logo-fallback.png

The difference in file size may seem negligible but a difference of 6kb is actually a difference of 46% in this case.

Now, when looking at a retina PNG vs. the SVG, the PNG (1028 x 432) has a file size of 86kb which makes the SVG 560% smaller!

### 5. SVG can be optimised

Here is how a JPEG looks when you try and open it in a text editor:

![jpg as code][5]

[5]: /images/jpg.jpg

And this is what SVG looks like

![svg as code][6]

[6]: /images/svg.jpg

Look familiar? SVG is XML so it can be optimised and minified - you can compress a lot of the redundant information and if you serve gzipped content to your visitors, that will also improve things here too (although I'm not an expert in that kind of thing). Why not check out this [handy command line tool for minifying SVG][7].

[7]: http://code.google.com/p/svgmin/

* * *

Obviously there are some areas where SVG is not a viable (or appropriate) option - such anything photographic. But with the emerging trend of ["flat design" aesthetic][8] perhaps websites littered with layers of texture and photographic elements will decline...?

[8]: http://howells.ws/posts/view/160/on-the-flat-design-aesthetic

I personally think this will happen as responsive design continues and websites start to ditch the clutter in favour of simpler, more focused, user friendly websites. I hope that happens anyway.
