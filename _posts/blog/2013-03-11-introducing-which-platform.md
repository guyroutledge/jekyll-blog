---
layout: post
title: "Introducing Which Platform?"
date: 2013-03-11
tags: Apps
categories: blog
---
[Which Platform?][1] is a handy mobile "web-app" that helps commuters find out which platform they need for a given destination at "the UK's busiest interchange".

[1]: http://www.whichplatform.co.uk

I travel through Clapham Junction station every day; it's a maze of tunnels and walkways, connecting 17 platforms that transport commuters to almost 270 destinations. The station is predominantly an interchange, so a great deal of the people passing through it have to change platforms to switch lines or networks. To alleviate the confusion of which platform serves which destinations, there are printed boards scattered around the station providing this information.

![Which Platform Signs at Clapham Junction][2]
[2]: /images/IMG_0300.jpg

These boards are few and far between and in some cases, located in walkways that are filled with swarms of commuters, making stopping to read the information difficult, not to mention an obstacle to those rushing by. But putting that aside, the more pressing issue is that stopping whilst running to catch a train to read through pages and pages of place names is madness. I know I've been caught out a couple of times, searching to find where I need to be, only to arrive on the platform to see the tail-lights of the train that I wanted to be on disappearing into the distance...

It was this (and the fact that I thought it would be a nice simple project) that prompted me to turn this set of data into something more manageable (and something better looking) that could be consumed on the go. So here it is:

[![Which Platform Screenshot][3]][4]
[3]: /images/Google-ChromeScreenSnapz007.png
[4]: http://www.whichplatform.co.uk

### Nerdy stuff

The site is built as a mobile-first single page app. You can drill-down alphabetically or use the auto-complete search field to find exactly where you need to be. The whole thing is pretty simple with a limited feature set and is designed to get you to the info you need quickly. I've tried to make it as lightweight as possible so it's quick to grab the data on the go - it's currently 200kb in total - and I haven't even set up minification or gzip (yet).

There is no database, the data is just JSON that is processed using array methods and loops.

I'm not a designer by trade, but I really enjoyed doing both the visual design and interaction design - there are still things to tweak and more devices to test on, but as a first version, I'm pretty happy with things.

### Iterate, Iterate, Iterate

One of the main goals of this project was just to release *something*. I've gone for the simplest version of a simple thing. I'd like to integrate live departure information but that will be a quite a lot of work. What I've decided to do is fix all the little bugs I know about and wait and see if it gets any traffic; if it proves to be a useful tool, I'll try and add some features; if it doesn't, I'll just enjoy it for what it is and all the things I learned whilst doing it.

If you like it, hate it, find it useful or know someone who might, I'd love to have some feedback - feel free to drop a note in the comments.
