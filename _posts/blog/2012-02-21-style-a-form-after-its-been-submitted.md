---
layout: post
title: "Style a form after it's been submitted"
date: 2012-02-21
tags: Snippet
categories: blog
---
A quick snippet from a recent project. The requirement was to be able to style a form after it was submitted to ensure all the validation messages were styled correctly. Using a bit of PHP it was easy to add a class to the form: 

{% highlight php %}
<?php
	$class = ''; 
	if ( $_SERVER['REQUEST_METHOD'] == 'POST' ) { 
		$class = 'submitted'; 
	} 
?>
<form class="<?php echo $class ?>">
{% endhighlight %}
