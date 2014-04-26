---
layout: post
title: "Custom radio buttons"
date: 2014-04-26
tags: Tutorial
categories: blog
---

Form elements aren’t the most fun thing in the world to style. I was
given a design recently that featured radio buttons with "on brand" 
colours to indicate the selected state. 

![Custom radio buttons for Noble Union](/images/custom-radios.png)

Instead of dismissing this and
saying "you can’t customise native form controls", I had a go at
replicating the desired effect.

## `:checked`

The `:checked` pseudo class allows styling of input elements that can be "checked" 
like radio buttons and checkboxes.

{% highlight css %}
input[type="radio"]:checked {
	/*styles for checked radio button*/
}
{% endhighlight %}

Using sibling selectors like the adjacent sibling selector allows the
styling of an element that is next to another. In the case of inputs,
they are often adjacent to a label in the document.

{% highlight html %}
<input type="radio" value="app idea">
<label>I’ve got an idea for an app</label>
{% endhighlight %}

We can style the label differently when the radio button is checked as
follows.

{% highlight css %}
input[type="radio"]:checked + label {
	/*styles*/
}
{% endhighlight %}

## Labels & inputs

So, we can style nearby elements differently based on the state of the
chceked attribute. But we can also link labels and inputs together so
that clicking on the label activates the checking and unchecking of the
input.

{% highlight html %}
<label for="input1_1">I’ve got an idea for an app</label>
<input id="input1_1" name="input1" type="radio">
<label for="input1_2">I’m an agency interested in partnering</label>
<input id="input1_2" name="input1" type="radio">
{% endhighlight %}

Here the `for` attribute on the label maps to the `id` attribute on the
input. The value of the `name` attribute on each input match as these
two inputs are both part of the same group of inputs.

Now, clicking on the label will select the input that it’s linked to and
mark it as checked.

## Hide the input

This behaviour still works with the input "visually hidden". The could be achieved
by positioning it off the page with `position:absolute` or setting
`visibility:hidden`.

## Replace the input

The form behaves as before but now we don’t have any visual indication
that this is a radio button or which option has been selected. We can
now re-create our own version of the input.

Using pseudo elements `:before` and `:after` on the label, we can create
our own custom unchecked and checked representation of the input.

The unchecked state is handled by the `:before` element.

{% highlight css %}
label {
	position:relative;
}
label:before {
	content: "";

	position: absolute;
	top: 6px;
	left: 0;
	width: 20px;
	height: 20px;

	background: #fff;
	border: 2px solid #999;
	border-radius: 100%;
}
{% endhighlight %}

The red dot in the center, representing the active state can be added
via an `:after` element.

{% highlight css %}
input[type="radio"]:checked + label:after {
	content: "";

	position: absolute;
	top: 12px;
	left: 6px;
	width: 8px;
	height: 8px;

	background: #ff4f4b;
	border-radius: 100%;
}
{% endhighlight %}

And there you have it. Custom radio buttons with no additional elements.
