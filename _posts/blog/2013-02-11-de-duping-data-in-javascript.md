---
layout: post
title: "De-duping data in Javascript"
date: 2013-02-11
tags: Tutorial
categories: blog
---
Here's a nice little trick for dealing with data that has duplicate entries in it. I've tried to keep it simple by using an entirely unlikely set of data but I think it should illustrate the point.

Imagine you have some data about ingredients for some tasty fruit smoothie recipes that looks a bit like this:

{% highlight json %}
{
    "recipes" : [
        {
            "name" : "Tropical Delight",
            "ingredients" : [
                "pineapple",
                "apple",
                "banana",
                "coconut"
            ]
        }
        ,{
            "name" : "Green Machine",
            "ingredients" : [
                "apple",
                "kiwi",
                "lime"
            ]
        }
        ,{
            "name" : "Very Berry"
            "ingredients" : [
                "strawberry",
                "raspberry",
                "banana"
            ]
        }
    ]
}
{% endhighlight %}

If you looped through each recipe to get an array of all the ingredients, the output would end up something like this:

{% highlight javascript %}
console.log(ingredients);
// logs ['pineapple', 'apple', 'banana', 'coconut', 'apple', 'kiwi', 'lime', 'strawberry', 'raspberry', 'banana'];
{% endhighlight %}

If you wanted to work with this array of data, it's likely that you would'nt want any duplicate items ("apple" and "banana" are both in there twice).

This can be remedied by turning the array into an object.

Javascript objects are a bit like associative arrays in that they contain a series of `key`, `value` pairs. Each `key` can only occur once so we can use this feature to dedupe the ingredients array.

{% highlight javascript %}
var ingredients = ['pineapple', 'apple', 'banana', 'coconut', 'apple', 'kiwi', 'lime', 'strawberry', 'raspberry', 'banana'];
var tmpObj = {};
for (var i = 0; i &lt; ingredients.length; i++) {
    tmpObj[ingredients[i]] = true;
}
console.log(tmpObj);
// logs { 'pineapple':true, 'apple':true, 'banana':true, 'coconut':true, 'kiwi':true, 'lime':true, 'strawberry':true, 'raspberry':true }
{% endhighlight %}

Pretty simple, eh? Now if you want to be manipulating an array rather than an object then you can do that with another little loop:

{% highlight javascript %}
var ingredientsList = [];
for ( var ingredient in tmpObj ) {
    ingredientsList.push(ingredient);
}
console.log(ingredientsList);
// logs ['pineapple', 'apple', 'banana', 'coconut', 'kiwi', 'lime', 'strawberry', 'raspberry']
{% endhighlight %}

This technique leaves the original data untouched and gives the ability to work with a portion of it in a nice manageable way and with no duplicates. It's not going to be useful in every case, but it's something that I came up against recently and was happy to find a nice simple solution.
