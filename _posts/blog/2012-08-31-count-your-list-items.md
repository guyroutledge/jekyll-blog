---
layout: post
title: "Count your list items"
date: 2012-08-31
tags: Tutorial
categories: blog
---
I'm just finishing off a client site and as one of the last tasks, came to tackle their terms and conditions page. This was a huge document of multiple nested lists, all markuped up with specific (interrelated) clause numbers and sub sections. 

<figure> 
<img src="/images/Screen-shot-2012-08-24-at-14.47.04.png">
<figcaption>Word document showing numbering system</figcaption> 
</figure> 

Now, as things go semantically, this has ordered list written all over it. But while there are some choices of number formats via the `list-style-type` CSS property, I initially had to crank my brain about how to replicate this numbering style. Each section is numbered and then each item within the section is numbered accordingly. Here's the markup: 

{% highlight html %}
<h4>Liability</h4>
<ol>
	<li>Unless otherwise agreed...</li>
	<li>For goods destined...</li>
	<ol>
		<li>We will only accept...
			<ul>
				<li>Arising from... </li>
				<li>Whilst the goods...</li>
			</ul>
		</li>
		<li>Where we engage...</li>
		<li>If the carrying vessle...</li>
	</ol>
	<li></li>
	<li></li>
</ol>
{% endhighlight %}

I thought the best way forward would be to add the numbers via pseudo elements and since the site was supporting IE8+, this wouldn't be an issue with compatibility. Also, there's a lesser known function of pseudo elements 'content' property which is perfect for this exact thing: the count() function and its associated properties. You can initialise a counter (and optionally set its initial value - default is 0) and then set an element to increment it. 

{% highlight css %}
.terms {
	counter-reset:section 1;
}
.section-heading {
	counter-increment:section;
}
{% endhighlight %}

To make use of this count, you call it in the `content` property of a `:before` or `:after` pseudo element. 

{% highlight css %}
.section:before {
	content:counter(section)'. ';
}
{% endhighlight %}

![section numbering][2] 

In the case of these terms, I needed a few different counters and chained them together to create the deep list numbering required. Here is the final code. 

{% highlight css %}
.terms {
	counter-reset:section 1;
	counter-reset:item;
	counter-reset:subsection;
}

	.terms .section-heading {
		counter-increment:section;
		counter-reset:item;
	}
		.section-heading:before {
			content:counter(section)'. ';
		}
	
	.terms ol {
		list-style:none;
	}
		.terms ol > li {
			margin-bottom:0.75em;
		}
			.terms ol > li:before {
				content:counter(section)'.'counter(item);
				counter-increment:item;
				margin-right:1em;
			}
		
		.terms ol ol {
			counter-reset:subsection;
		}
			.terms ol ol > li {
				margin-bottom:0.5em;
			}
				.terms ol ol > li:before {
					content:counter(section)'.'counter(item)'.'counter(subsection);
					counter-increment:subsection;
				}	
		
	.terms ul {
		list-style-type:lower-alpha;
		list-style-position:inside;
	}
		.terms ul li { margin-bottom:0.5em; }
	}
	/* Due to all the nested lists, set font-size in px to stop cascading infinitely decreasing font-size */
	.terms li { font-size:12px; }
}
{% endhighlight %}

This did the job for me, but there are a few other features that it's worth digging through in the 

[W3 spec on counters][3] to find out more. This covers some of the cases like what happens when items are `display:none` or `:hidden` and some of the ways to combine different `list-style-types`. This may not be the most visually stunning use of pseudo elements, but it's still a great one to be able to pull out of the bag for times like this. Been counting anything interesting lately? Probably not. Got anything to add? Let me know in the comments.

[1]: /images/Screen-shot-2012-08-24-at-14.47.04.png "terms and conditions"
[2]: /images/Screen-shot-2012-08-24-at-15.18.30.png "section with prepended number"
[3]: http://www.w3.org/TR/CSS21/generate.html#counters
