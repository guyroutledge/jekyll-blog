---
layout: post
title: "Hover delay"
date: 2012-02-08
tags: Snippet
categories: blog
---
CSS dropdown menus have been around for ages and work a treat. However, sometimes I find that they are a bit keen to activate, even if the mouse is just passing through the hover region. Using a bit of JavaScript, you can set a delay on the hover so that the menu only drops down if the mouse pauses for the given amount of time. Here is some simplified HTML: 
     
{% highlight html %}
<nav>   
	<ul>     
		<li><a href="#">Menu Item 1</a>       
			<ul>         
				<li><a href="#">Sub Menu Item 1</a></li>         
				<li><a href="#">Sub Menu Item 2</a></li>         
				<li><a href="#">Sub Menu Item 3</a></li>       
			</ul>     
		</li>     
		<li><a href="#">Menu Item 2</a></li>     
		<li><a href="#">Menu Item 3</a></li>   
	</ul> 
</nav>
{% endhighlight %}

We have a bog-standard unordered list of links, the first of which has a class of 'has-submenu' and a nested unordered list within it with a class of 'dropdown'. Using a specific height on the 'li.has-submenu', overflow hidden and a bit of absolute positioning the 'ul.dropdown' menu can be positioned correctly to appear as though it's dropping down underneath the target menu item. When the user hovers over .has-submenu, jQuery can be used to add a class called .pause (or .waiting or .delay or something similarly semantic and descriptive). When the mouse leaves the target area, the .pause class is removed. This way, jQuery can traverse the DOM to find .pause and display the menu - this will only happen if the .pause class has been present for the specified duration of the setTimeout (here, just over half a second). 

{% highlight javascript %}
$('nav .has-submenu').hover(
	function(){ 
		$(this).addClass('pause'); 
		$('.pause').find('a').addClass('selected'); 
		setTimeout(function(){ 
			$('.pause').find('ul.dropdown').stop(true, true).slideDown(750, 'easeOutExpo'); 
		}, 600); 
	}, function(){ 
		$('nav.main-menu li.styles').removeClass('pause'); 
		$('ul.dropdown').stop(true, true).slideUp(500, 'easeInOutExpo', function(){ 
			$('nav.main-menu li.styles').find('a').removeClass('selected'); 
		}); 
	}
); 
{% endhighlight %}

A class of 'selected' is also added on mouseenter and removed at the end of the slideUp for a nice bit of user feedback. stop(true, true) is called on the animation to cause it to stop and go to the end of its behaviour to stop animations queuing up with multiple hover events. In the real world situation where I used this, I was using the jQuery easing plugin elsewhere so took advantage of it here, choosing easeOutExpo and easeInOutExpo for some nice smooth action.
