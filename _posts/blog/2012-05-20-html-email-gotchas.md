---
layout: post
title: "HTML email gotchas"
date: 2012-05-20
tags: Notes
categories: blog
---
I recently had the misfortune of building a handful of email templates for a photo competition. Building HTML emails is always a painful experience due to the wide variety of email clients but also because the only way to have any control is using inline styles and tables; a coding style much more like the mid 90s than the modern techniques and best practices we enjoy today. Here are a few nuggests that I have found useful to keep in mind when building email templates: 

*   Most email clients are quite narrow, so don't design for widescreen - 600px wide is good baseline
*   Some clients strip the body tags so you should wrap your main email content in a table that matches the body in terms of background and dimensions.
*   Some clients don't like background images on `<td>` but do display background images on `<table>` elements.
*   When declaring background color via `style` attributes, add in the good ole fashioned `bgcolor` attribute too - these can only take longhand hex values (eg. #FFFFFF) or colour names
*   iOs does observe style tags declared in the `<head>` so link styles can be declared there to override the nasty default blue
*   To force custom link colours in other browsers, wrap the link text in a span with an inline style of the desired color 

{% highlight html %}
<a href="#" style="color:pink"><span style="color:pink">click here</span></a>
{% endhighlight %}

## Resources 

There are also numerous resources available to help with email development, some of which I've used and some of which I've just heard good things about. 

[Campaign Monitor][1] whilst being a full service email marketing app like [Mail Chimp][2] or [Cheetahmail][3] also has a great guide to CSS support in email clients - it's an interesting yet depressing read when you realise how flaky CSS support in email really is. If you want a good basis for starting an HTML email then this dude called Sean Powell has you covered with HTML Email Boilerplate. It may look like a lot of code but one of the things I really like about this project is the way each 'feature' (or hack) is commented and explained as to why it's there and what it's doing. You can grab it from the website [or fork it on github.][4] 

## Test test test

[1]: http://www.campaignmonitor.com/
[2]: http://mailchimp.com
[3]: http://www.cheetahmail.co.uk/
[4]: https://github.com/seanpowell/Email-Boilerplate 
 
If you thought browser testing could be annoying, email testing is even more so as Refresh Driven Development is hardly possible. We use [Litmus][5] for testing emails at work. It's a pay-for service that provides screenshots and detailed reports of how your email will display in a vast range of email clients. It also has spam filter tests and analytics for monitoring your campaigns. There is some pretty nerdy in depth stuff that you can do with Litmus but to be honest, I was glad to successfully pass the tests and get back to something a little bit more standards based!

 [5]: http://litmus.com/
