---
layout: post
title: "Featured image snippet"
date: 2012-04-24
tags: Snippet
categories: blog
---
Featured images in Wordpress are one of the greatest things ever, making it super simple to associate an image with a bit of content. I often find myself needing to put them out in a loop and often find myself forgetting the syntax. So I packaged this up in a Sublime Text snippet. Here's an example of what's output with all the attributes filled in: 

{% highlight php %}
<?php $image = wp_get_attachment_image_src( get_post_thumbnail_id(get_the_ID()), 'large'); ?> 
<img class="awesome-image" src="<?php echo timthumb($image[0], 600, 400, 1, 1) ?>"  alt="<?php the_title_attribute() ?>">
{% endhighlight %}

And here is the snippet: 

{% highlight html %}
<snippet>
	<content><![CDATA[
		<?php \$image = wp_get_attachment_image_src( get_post_thumbnail_id(get_the_ID()), 'large'); ?>
		<img class="$1" src="<?php echo timthumb(\$image[0], $2, $3, 1, 1) ?>" alt="<?php the_title_attribute() ?>">
	]]></content>
	<!-- Optional: Set a tabTrigger to define how to trigger the snippet -->
	<tabTrigger>image</tabTrigger>
</snippet> ?>
{% endhighlight %}

CLARIFICATION:

These snippets use a function from the theme's `functions.php` that calls timthumb, a server side image resizer. In this case, it's four arguments are `width`, `height`, `crop` and `sharpening`. You can read more about timthumb on their website.
