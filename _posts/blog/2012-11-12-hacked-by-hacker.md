---
layout: post
title: "Hacked by hacker"
date: 2012-11-12
tags: Rants
categories: blog
---
I came to post a quick snippet yesterday and found that the `index.html` and `index.php` in my site root had been overwritten by the words "Hacked by hacker". 

This was quite annoying.

I was at work at the time and had no access to my backup and version controlled local copy of the files but I was able to FTP in remotely and check things out. It seemed that these were the only two files affected - no new users in the database and all the content in tact.

After a quick Google search, it became apparent that this isn't a unique attack - after all this is not exactly a high profile blog! It seems that the same thing had happened to a lot of people who host their sites on HostPapa and was due to a "cPanel .htaccess follow symlinks Exploit". There is a big ole thread about others who have had issues on the [HostPapa support forums][1]. I've never had any issues with HostPapa despite the fact that they are *super* cheap hosting and you often get what you pay for. However, the fact that they tried to blame this issue on user error rather than the fact that they had not updated their cPannel patches, is not cool. Fortunately, I was able to restore my index.php and refresh my permalink settings and was back up in no time.

[1]: http://forum.hostpapasupport.com/index.php?topic=2199.0

This brief experience has taught me a few things and re-affirmed a few things that I already thought:

*   Always keep a backup
*   Always install Wordpress in its own folder
*   Version control makes keeping track of files and backups much easier and safer
*   You get what you pay for
*   It's probably time to get better webhosting that includes features like RAID storage, regular backups and ssh access for working with version control
