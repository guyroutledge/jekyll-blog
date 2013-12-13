---
layout: post
title: "How to get your face in Google search results in&nbsp;minutes"
date: 2013-10-16
tags: tutorial
categories: blog
---
I remember looking into this years ago and remember being baffled by complex tutorials about rich snippets and microdata. However, I revisited the idea today and made it happen within minutes. It's likely it will take you longer to read this post than it will to implement the code!

### How does Google know who I am?

Google uses the photo from your Google Plus account and adds it to search results for content that they know you created. Here's how to set it up:

### Get a Google+ account

If you don't have one, you'll need one. I have one that I hardly use, but that may change now. You can tell I hardly use it because I still have the default Google cover image...!

### Log in to Google+

The default view is your posts but you want to view your profile information. To do so, click on the "About" tab at the top of the page.

![Screenshot showing the about tab][1] 
Scroll down and locate the "Links" section. The important section is the "Contributor to" one. This is how you tell Google where you contribute content.

[1]: /images/gplus1.jpg

![Screenshot of Google+ profile links section][2] 
Edit the links section and add your site name and URL.

[2]: /images/gplus2.jpg

![Screenshot of adding title and URL][3] 
### Add Author tag to site

[3]: /images/gplus3.jpg

This is the most technical bit - and it's not technical at all.

All you need is to add a link back to your Google+ profile with a `rel=author` attribute somewhere on your site. If you use Wordpress (or similar) you could add it to your blog single-post template or in the header of every page.

Here's an example of the code:

{% highlight html %}
<a href="https://plus.google.com/105864067956325551667" rel="author">Guy Routledge</a>

{% endhighlight %}

That's it. You're done. Push any template changes up to your live site (unless you went commando via FTP) and check that everything went as planned.

### Check it's all working

Google has a [Rich Snippets testing tool][4] that you can use to check everything went smoothly. Just add in your site URL and check the preview. If all went well, you'll see your smiling face next to your search listing.

[4]: http://www.google.com/webmasters/tools/richsnippets

![Screenshot of avatar next to search results][5]

[5]: /images/gplus4.jpg
