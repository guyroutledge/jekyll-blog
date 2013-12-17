---
layout: post
title: "Device testing"
date: 2012-06-25
tags: Apps
categories: blog
---
I've recently been working on a number of projects that have required a separate mobile site or fully responsive build. During development I tend to lean on resizing the browser window to quickly layout at different breakpoints. For testing for the iPhone/iPad I also use the iOS simulator that comes with XCode. <blockquote class="quote post-quote">
  Nothing beats testing on a range of devices
</blockquote> Despite the ease of using a simulator, nothing beats testing on (a range of) real devices so here is a quick guide for broadcasting your local site to any mobile device. The only caveat is that both your local computer and mobile device must be connected to the same wifi network. 1. Grab your IP Address An easy way to do this is visit System Preferences > Network. 

<figure> 
<img src="/images/Screen-Shot-2012-08-25-at-01.44.44.png" alt="MAMP port settings">
<figcaption>System Preferences > Network</figcaption> 
</figure> 

Alternatively, via the command line you can get your ip details by running 

	ifconfig | grep inet

2. Grab the port number that your local server is on I'm using MAMP Pro and it's default is 8888 but in my case, it's 80. 

<figure> 
<img src="/images/Screen-Shot-2012-08-25-at-01.46.10.png" alt="IP details">
<figcaption>MAMP Port Settings</figcaption> 
</figure> 

3. Combine the two to get the URL to enter on your mobile device 

	http:// + ip + : + port</code></pre> for example: 

![IP and port combined][4] 

4. If you are using Wordpress, add a couple of things to your wp-config 

{% highlight php %}
<?php 
// Setup local host for viewing on other devices
define('SITEURL', 'http://192.168.254.10:80');
define('WP_HOME', 'http://192.168.254.10:80'); ?>
{% endhighlight %}

5. You're all set 6. If it didn't work In my case, the localhost was set up correctly but the document root was pointing to /Applications/MAMP/htdocs: To fix this, I set up a new host in MAMP Pro that pointed to my local directory. After that, you should be all good to go.

 [1]: http://guyroutledge.co.uk/wp-content/uploads/2012/06/Screen-Shot-2012-08-25-at-01.44.44.png
 [2]: http://guyroutledge.co.uk/wp-content/uploads/2012/06/Screen-Shot-2012-08-25-at-01.46.10.png
 [3]: http://guyroutledge.co.uk/wp-content/uploads/2012/06/Screen-Shot-2012-08-25-at-01.47.58.png
 [4]: http://guyroutledge.co.uk/wp-content/uploads/2012/06/Screen-Shot-2012-08-25-at-01.49.05.png
