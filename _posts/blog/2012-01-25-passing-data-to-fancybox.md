---
layout: post
title: "Passing data to fancybox"
date: 2012-01-25
tags: Snippet
categories: blog
---

As much as the humble Lightbox has probably been overdone on the web of late, I'm still a big fan. I like the fact that you don't need to make room for yet more stuff on the page and I like the AJAX-y feel of something that gives you more info without having to reload the page or redirect you away from where you were. I have a site with an email sign up form in the footer and the client wanted users to be able to select multiple (optional) options which there really wasn't space for. So I went with some pretty basic markup for the sign-up form: 

{% highlight javascript %}
<form method="get" action="">
  <input type="email" placeholder="Enter your email address" id="footerEmail" name="footerEmail">
  <input type="submit" value="Sign Up">
</form>
{% endhighlight %}

A bit of jQuery steps in and opens an iframe in Fancybox my lightbox of choice at the moment: 

{% highlight javascript %}
$('.signUp').submit(function(e){
	e.preventDefault();
	var signUpEmail = $(this).parent().find('input[type=email]').val();
	$.fancybox({ 
		'width':400, 
		'height':400, 
		'transitionIn':'elastic', 
		'transitionOut':'elastic', 
		'speedIn':350, 
		'speedOut':350, 
		'href':'/modal-sign-up.php?email='+signUpEmail+'' 
	})
});
{% endhighlight %}

As an aside, you might wonder why I used 

{% highlight javascript %}
$(this).parent().find('input[type=email]').val
{% endhighlight %}

rather than 

{% highlight javascript %}
$('#footerEmail').val()
{% endhighlight %}

and it's because on the homepage there is another more call-to-action-y sign up form as well, and this bit of code is used for both of them. The key bit is the `'href':'/modal-sign-up.php?email='+signUpEmail+'` which passes a GET query string along with the href to modal-sign-up.php. In the modal-sign-up page, I use PHP to output the value of this querystring `$_GET[email]`

{% highlight html %}
<form id="signUpModal">
  <label for="modalEmail">Email:</label>
    <input id="modalEmail" name="email" type="email" value="<?php echo $_GET[email] ?>" required="required">
  <label for="optional1">Optional Thing 1:</label>
    <select id="optional1">
      <option value="option1">Option 1</option>
      <option value="option2">Option 2</option>
    </select>
  <label for="optional2">Optional Thing 2:</label>
    <select id="optional2">
      <option value="option1">Option 1</option>
      <option value="option2">Option 2</option>
    </select>
</form>
{% endhighlight %}

This form in the fancybox then submits via AJAX and displays a Thank You message when successful and closes itself. All very nice and compact for those who want to sign up, keeping the more cumbersome form out of sight for those that don't. I used this technique in other areas of the site and passed multiple variables in the query string too.
