---
layout: post
title: "Notes on mobile development"
date: 2012-07-02
tags: Notes
categories: blog
---

With all the talk about mobile, responsive design, adaptive design, i-this and i-that and The Mobile Web (whatever the hell that is), you'd almost be forgiven for thinking that fixed width, static websites were the thing of the past. I've had the chance to build a couple of responsive sites over the last few months and they have been a great new challenge and a lot of fun. However, the majority of client work that we do is still a fixed width, highly designed, pixel perfect, relatively fragile things - if the title of a new post is too long, all hell can break loose. I'm sure that this situation is not uncommon (even in 2012) for a design agency with client websites that have been maintained since the mid 2000s. In that vein, we recently launched a pretty big (and complex) site which had a shocking user experience on mobile due to the heavy use of texture, photography, sharing buttons and even JavaScript functionality to a degree. The decision was taken to make the site mobile friendly and here are a few things we learned along the way. 

## Desktop First 

As this site was desktop first, rather than the (perhaps) more ideal Mobile First workflow put forward by [Luke Wroblewski][1] in [the book of the same name][2], it was definitely going to be a challenge to reverse engineer a mobile experience from this existing code-base. The existing site was fixed width and a had a *lot* of absolutely positioned elements, complex form hacks, and a lot of content and a lot of custom templates. 

In this case, tweaking the markup, using a fluid grid and adding a few `@media` queries would not do the job. We would need a separate mobile site - but we wanted a better solution to the typical redirect to `m.sitename.com` which often sends you to the mobile homepage, away from the content, causing lots of user frustration. There are some obvious issues with having two separate sites, namely that there are two code bases and possibly two different sets of content for the different sites. This is obviously a maintenance headache that we wanted to avoid if possible. The site was built on Wordpress so we decided that the most elegant (and strait forward) way to provide a mobile experience would be to switch the active theme for mobile visitors. This way we could keep exactly the same content and just re-write the templates (doing some fairly heavy copy and pasting of the PHP used to get at the Wordpress content from the database). 

## Designing a Tiny Experience

 [1]: http://www.lukew.com/
 [2]: http://www.abookapart.com/products/mobile-first/ 
 
The initial brief was to produce a mobile site consisting of the six main sections of the "main" site. These were designed in a series of 320px wide mockups, signed off by the client and given to me to build. From the outset I decided that it would be best to not for the site to be fixed width at 320px but a fluid single column, this way, devices that had slightly wider screens would still get a full width design rather than a centered strip of content. However, putting that to one side, it quickly became apparent that there was a problem with only designing key sections of this mobile experience. The site had a lot of content in many different sections, content about the business and their values as well as product info, contact details and whole sections for playing games, and user generated content. A lot of this content is cross referenced throughout the site; products link to recipes to give culinary inspiration, blog posts link to pages about company values or the videos section, the homepage has a featured section that links through to a voting form for a competition. Some but not all of these sections were designed but what happens when you follow a link to a page that hasn't been built? Bad times. One way to get around this was to design a default template that would nicely display the title, featured image and content designed in line with the rest of the site. This solved a few problems but the site featured so many custom fields, post types and taxonomies that the default page would only display a fraction of the content. The solution was to create templates for each of these content types but with a simpler design for each of them - in the mobile world where bandwidth is perhaps at a premium, content really is king. 

## Rapid prototyping 

So, the main site had 5 developers and 3 designers working on it pretty much full time for about 6 weeks (or more); I now had the challenge of single handedly building the whole site for mobile in 3 weeks. This called for some rapid development. Looking at the designs, there were some clear patterns in layout, color, texture and structure. I broke these down into a series of reusable modules and classes which could be used site-wide. I tweaked the finer details of these and created new ones as required as the development process progressed. After building the first few 'key sections', I was armed with enough modules or building blocks to build the majority of the other pages without touching the CSS, simply adding classes to the markup which had been (largely) copied and trimmed down from the main site. For example, there were a number of elements that had been designed to have drop shadows and slight rotations throughout the site. Sometimes these were on images, sometimes on paragraphs, sometimes on sections etc. By abstracting this into a class, it could then be dropped on these various elements wherever needed 

{% highlight scss %}
.shadow { @include box-shadow(-5px 5px 10px rgba(0,0,0,0.3)); }
.skew { @include rotate(4deg); }
.skew-flipped { @include rotate(-4deg); }
{% endhighlight %}

{% highlight html %}
<section class="section page-intro shadow"></section>
  <img class="shadow skew polaroid" src="" alt="">
</section>

<article class="featured-post shadow skew-flipped">
</article>

<form>
  <input type="submit" class="button shadow skew">
</form>
{% endhighlight %}

## Small Screen, Big Fingers 

During the development stage, I was previewing my work in a browser (Chrome) with the window resized to a small screen - which looked pretty awkward on my 27" iMac. I found that whilst the browser window won't resize down to 320px, browsing with the developer tools docked to the right and resized appropriately, any screen size from 0px upwards can be faked. Previewing stuff in the browser was certainly the quickest method for checking things but I was very keen to keep an eye on things on real devices as often as possible. Setting up a testing environment as per my post on [device testing][3] and experimenting with [Adobe Shadow][4] this was pretty straightforward. In using the site on an actual device, we made a few observations: 

*   Large site navigation should be accessed via a show/hide button and hidden by default to free up screen real estate
*   Font size should be 14px to be easily readable - 12px is bearable but a little on the small side really - think of your gran with her new HTC Desire (or whatever)
*   Touch targets should be at least 26x26px (although Apple's [Human Interface Guidelines][5] suggest 44x44px minimum) for ease of tapping
*   Links in lists should be `display:block;` and spaced with padding rather than margin to allow for a wider tap area
*   Phone numbers should have a `tel:` href attribute so a user can make a call without having to switch apps
*   Email and URL input fields should have the correct HTML5 `type` attributes to enable their respective keyboards for ease of entering info

[3]: /device-testing
[4]: http://labs.adobe.com/technologies/shadow/
[5]: http://developer.apple.com/library/ios/#DOCUMENTATION/UserExperience/Conceptual/MobileHIG/Introduction/Introduction.html

## Device Quirks 

Having trawled our analytics for info about mobile traffic, we knew that the main plays in terms of devices were iOS and Android with iPhone being by far the highest percentage. Given the huge number of internet enabled mobile devices on the market, we had to limit our focus to the ones that our users were actually using. Even in this narrow range we ran into a few quirks: 

### Orientation Change 

A fairly well known issue with iOS devices is that went changing from portrait to landscape (or vice versa) the viewport is zooms in but then remains zoomed in when the orientation is changed again. Scott Jehl has [a really simple pollyfill to fix orientation change][6] which sets maximum-scale on the viewport meta tag just before orientation change and then restores it afterwards to allow user scaling to still work and not piss anyone off. 

### Zooming Inputs

[6]: https://gist.github.com/1568180 

Another quirk (or feature) of iOS is that it zooms into form fields and brings up a keyboard to allow the user to easily see what they are typing. I think this is generally a desirable feature but in a couple of cases, we had a form in a lightbox and didn't want to deal with the user having to pinch and zoom out and risk closing the window. I found [an input-zoom hack on Stackoverflow][7] where someone discovered that when clicking on a form input triggers `mouseover` and `mousedown` events that can be used to intercept the zooming and fiddle with the meta tag, disabling and then enabling `user-scalable`. 

{% highlight javascript %}
var formEls = 'input[type=text], input[type=email], input[type=url], input[type=tel], input[type=number], input[type=search] select, textarea';

  $(formEls).live('mouseover', zoomDisable);
  $(formEls).live('mousedown', zoomEnable);

  function zoomDisable(){
    $('head meta[name=viewport]').remove();
    $('head').prepend('&lt;meta name="viewport" content="user-scalable=0">');
  }
  function zoomEnable(){
    $('head meta[name=viewport]').remove();
    $('head').prepend('&lt;meta name="viewport" content="user-scalable=1">');
  }
{% endhighlight %}

### Scrolly Scrolly

[7]: http://stackoverflow.com/questions/2989263/disable-auto-zoom-in-input-text-tag-safari-on-iphone 
 
Finally, an Android quirk that causes problems with `overflow:scroll`. One of the product pages displayed a list of all the products in each product category as horizontal scrolling list. In iOS using the CSS property `-webkit-overflow-scrolling:touch;` enables some lovely inertia scrolling but in Android even with overflow set to scroll, the browser would zoom out to show the full width of the container. After (quite a lot of) searching, I came across [a post by Chris Barr][8] that dealt with this exact thing. One of the comments offered an abridged jQuery version of his initial concept which fixed the problem without a hitch. 

{% highlight javascript %}
// Scrolling is a bit funky on Android so here's a Polyfill that makes it play nice
// First determine if this is an Android that needs it's scrolling fixed
// Then if it is, and it's being touched, increment an offset and move all the things

  var ua = navigator.userAgent.toLowerCase();
  var isAndroid = ua.indexOf("android") > -1;

  function touchScroll(selector) {
    if (isAndroid) {

      var scrollStartPosY=0;
      var scrollStartPosX=0;

      $('body').delegate(selector, 'touchstart', function(e) {
        scrollStartPosY=this.scrollTop+e.originalEvent.touches[0].pageY;
        scrollStartPosX=this.scrollLeft+e.originalEvent.touches[0].pageX;
      });

      $('body').delegate(selector, 'touchmove', function(e) {
        if ((this.scrollTop &lt; this.scrollHeight-this.offsetHeight && this.scrollTop+e.originalEvent.touches[0].pageY &lt; scrollStartPosY-5) || (this.scrollTop !== 0 && this.scrollTop+e.originalEvent.touches[0].pageY > scrollStartPosY+5))
        e.preventDefault();
        if ((this.scrollLeft &lt; this.scrollWidth-this.offsetWidth && this.scrollLeft+e.originalEvent.touches[0].pageX &lt; scrollStartPosX-5) || (this.scrollLeft !== 0 && this.scrollLeft+e.originalEvent.touches[0].pageX > scrollStartPosX+5))
        e.preventDefault();
        this.scrollTop=scrollStartPosY-e.originalEvent.touches[0].pageY;
        this.scrollLeft=scrollStartPosX-e.originalEvent.touches[0].pageX;
      });
    }
  }

  // call the function passing in your desired selector
  touchScroll('.product-range');
{% endhighlight %}

## Round up

[8]: http://chris-barr.com/index.php/entry/scrolling_a_overflowauto_element_on_a_touch_screen_device/ 

It was a very interesting experience to develop a mobile experience from an existing site - perhaps a backwards way of doing things in this age of responsive design, but perhaps flagged up questions and problems that I would never even have though about under other circumstances. I think that as a workflow, the process of creating a whole website (even a small one) and then trying to retro-fit it on to a small screen is not ideal but any mobile experience is almost certainly better than no mobile experience at all. It's also true that in the case of this site, it's desktop version was so complex that it would have been near impossible to fit such a design into a fluid container and take a responsive, mobile first approach. All that said, I personally prefer the mobile experience of this site to it's big-brother desktop flavour; all the content and functionality is there but in a much simple, easier to read way and that is really what I want when consuming content on the web. What's your experience of mobile development been like? Have you tried Mobile First or built separate mobile experiences for your clients?
