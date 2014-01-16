---
layout: post
title: "Using variables in Javascript object&nbsp;keys"
date: 2014-01-14
tags: Tutorial
categories: blog
---

I use Javascript object variables to keep my code organised and store
sets of data. It is common to get or set object properties directly, but
it's also possible to reference an object key based on another variable
value.

There are many types of variables in Javascript, and they look like this:

{% highlight javascript %} 
	var someString = 'some-value'; 
	var someNumber = 42; 
	var someArray = ['an', 'array', 'of', someString, someNumber]; 
	var someObject = { 
		'string' : someString,
		'number' : 0,
		'array' : [1, 2, 3, 4], 
		'object' : { 
			'someProperty' : 'someValue' 
		},
		'function' : function(){
			return 'I am a function';
		}
	}; 
	var someFunction = function(){ 
		console.log( "I'm a function" ); 
	}; 
{% endhighlight %}

In the object variable `someObject`, the string variable `someString` is
set as the value of the property with a key of `string`. We can
reference this using dot notation:

{% highlight javascript %} 
	console.log( someObject.string );
	// logs 'some-value'
{% endhighlight %}

An alternative method to dot notation is bracket notation which is
written as follows:

{% highlight javascript %}
	console.log( someObject['string'] );
	// logs 'some-value'
{% endhighlight %}

If we wanted to log the value of each of the properties in `someObject`
we could write out a bunch of `console.log` statements but that would be
a bit tedious. To save a bit of time and have much DRYer code, we could
write a loop and use bracket notation to reference each property in the
object as a _variable_:

{% highlight javascript %} 
	var variableTypes = ['string', 'number', 'array', 'object', 'function'];
	for ( var i = 0; i < variableTypes.length; i++ ) {
		console.log( someObject[ variableTypes[i] ] );
	}
	// logs:
	// 'some-value', 
	// 42, 
	// ['an', 'array', 'of', 'some-value', 42], 
	// { 'string' : 'some-value', 'number' : 0, 'array' : [1, 2, 3, 4], { 'some-property' : 'some-value' }, 
	// function(){ return 'I am a function'; } 
{% endhighlight %}

Here, instead of dot notation like `someObject.number` we use bracket
notation and insert a variable `key` using the counter variable `i` for
each position in the array of variable types. Bracket notation is also
used to reference the i<sup>th</sup> index of the `variableTypes` array
on each iteration of the loop.

This example is trivial and doing a similar task might be more suited to
using a [`for...in`
loop](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/for...in).
However, for more complex situations like a recent side project of mine
where I created [an interactive box model
demo](http://guyroutledge.github.io/box-model), we can use other
Javascript operations and construct a _variable_ object key with bracket notation:

{% highlight javascript %}
    var setProperties = function(){
		var boxModel = {};
		var properties = ['Margin', 'Padding', 'Border'];
		var sides = ['top', 'right', 'bottom', 'left'];

		for ( var i = 0; i < properties.length; i++ ) {
			boxModel[ 'box' + properties[i] ] = {};

			for ( var j = 0; j < sides.length; j++ ) {
				boxModel[ 'box' + properties[i] ][ sides[j] ] = i * 10;
			}
		}
		console.log(boxModel);
		logs:
		// {
		// 	boxMargin :  { top : 0, right : 0, bottom : 0, left : 0 },
		// 	boxPadding : { top : 10, right : 10, bottom : 10, left : 10 },
		// 	boxBorder :  { top : 20, right : 20, bottom : 20, left : 20 }
		// }
	};
{% endhighlight %}

It could be argued that this code isn't that easy to read, but it certainly
gets the job done in a concise way, avoids repetition and (once
understood) would be easy to maintain if additional properties were to
be added to the list.

