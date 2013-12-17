---
layout: post
title: "Don't pollute the CSS Namespace"
date: 2013-03-27
tags:
- Workflow
- Rants
categories: blog
---

I often hear about [not polluting the global namespace][1] in Javascript (and it's probably a thing in other languages too). Rather than getting into the subject of self-executing functions and module patterns, one of the ways around this is to store your script in a single object:

[1]: http://stackoverflow.com/questions/8862665/what-does-it-mean-global-namespace-would-be-polluted

{% highlight javascript %}
var app = {
    doingStuff: false,
    init: function(){
        var now = new Date().getTime();
        app.doStuff(now);
    },
    doStuff: function(when){
        app.doingStuff = true;
        // do the rest of the stuff
    }
}
app.init();
{% endhighlight %}

This keeps everything nicely packaged up and ensures no [implied globals][2]. Everything is then referenced using `app.property` or `app.method` which feels more organised than just calling functions left right and centre. However, more importantly you only introduce a single variable `app` into the global namespace and every time you want your app to do something you use it's name. If you have an app made up of multiple parts (or modules) then you might refer to each of those by the module name - this helps separate responsibilities and makes everything more organised.

[2]: http://stackoverflow.com/questions/4909578/what-are-some-of-the-problems-of-implied-global-variables

I think the same kind of separation of related functionality and name-spacing can be applied to CSS with all the same benefits.

### Limiting Applicability

One reason that you might want to compartmentalise your CSS is to limit the applicability between different sections of a site. You might have a series of pages that all feature titles, articles and paragraphs of text but have a different visual style for each and don't want styles to overlap and override each other.

In the past I've see things like this used to limit styles to a particular page or section of a website:

{% highlight css %}
/* Styles for products page */
body.products { }
body.products #header { }
body.products #header h2 { }
body.products #main-content { }
body.products #main-content article { }
body.products #main-content article h2 { }
body.products #main-content article p { }
body.products #main-content article a.button { }
body.products #main-content a { }
body.products #main-content .sharing-links { }
body.products #main-content .sharing-links a { }
body.products #footer { }
{% endhighlight %}

Here we've limited applicability to the products page. However, this code is way too specific and these styles can only *ever* be used on a page that has a body class of products. That means that if the recipes page, the where to buy page and the blog page also have headings, articles, links and sharing buttons, they will all have to be styled separately there too. This is not [DRY][3] code.

[3]: http://en.wikipedia.org/wiki/Don't_repeat_yourself

We can do better.

### Grouping Styles in a Module

CSS can get pretty complex and disorganised (especially if you're not using a pre-processor). One way of organising things could be to use a parent class to group related styles for a section or module together:

{% highlight css %}
article.recipe { }
article.recipe h2 { }
article.recipe ul.ingredients li { }
article.recipe ol.directions { }
article.recipe .button.print { }
article.recipe .share { }
{% endhighlight %}

This is similar to the first example but has the benefit of being slightly more re-usable because you could put `<article class="recipe">` on a recipes search results page, single recipe page or in a sidebar feature of the homepage without having to worry about coding it up every time.

Another benefit here is that it's fairly easy to see how all the components of a recipe work together within the `.recipe` module. However, there could still be issues with re-usability if too many descendent selectors are used; this would mean the markup in every case would have to be almost identical for the styles to be applied correctly. What if you use a `h3` as the recipe title on the homepage and a `h1` on the single recipe page?

We can make this group of styles more portable by only using classes rather than a chain of descendent selectors:

{% highlight css %}
.recipe { }
.ingredients { }
.directions { } 
.print-button { }   
.share { }
{% endhighlight %}

But now, if all the elements are stripped away, the purpose of these classes can start getting ambiguous; while the words "ingredients" and "directions" make a lot of sense when used in the context of a recipe, it is possible that they are used elsewhere on the site - directions on a "how to find us" page or perhaps directions for how to fill in a form... Sharing links and buttons are ones that I constantly find named in similar yet different ways from site to site as well as by third party plugins.

Naming conflicts are unlikely to mean your styles don't apply as expected but they can be confusing for other developers - or yourself if you come back to a project after many day, weeks or months.

If we had a more organised way of naming things, we could perhaps limit applicability, group things together and avoid naming conflicts in one fell swoop.

### CSS Namespacing

Instead of using descendent selectors like `.recipe h2`, we can use `recipe` as a prefix (or namespace) to group everything together and imply a bit of meaning to our classes and make our code more *developer readable* as well as portable. In doing so we can also remove the desire to over-qualify selectors with their element like `ul.ingredients` which is a less performant selector and (unnecessarily) higher in specificity . If you want to communicate the element that you think should have a certain class you could add it as a comment.

{% highlight css %}
.recipe { } 
.recipe-title { }
.recipe-ingredients li { }
.recipe-method { } /* <ol class="recipe-method"></ol> */
.recipe-print-button { }
.recipe-share { }
{% endhighlight %}

By namespacing the classes, their purpose is more "developer readable", specificity has been reduced and the classes are more portable; you could have a `<section class="recipe">` or `<article class="recipe">`; if there is a specific order to the list of ingredients you could have `<ol class="recipe-ingredients">` or you could use the `.recipe-ingredients` class on a `section` element if you prefer - having options is a good thing.

I've been trying out this technique in my projects for a while now and have been pretty happy with the results. One thing that I've come to realise is that while namespaces are logically determined by the name or title of a certain page or section of a site, sometimes they can be too verbose and produce frustratingly long class names.

{% highlight css %}
.christmas-cracker-send-to-friend-form-submit-button { }
{% endhighlight %}

Unfortunately, shortening these long classnames can be equally problematic. 

{% highlight css %}
.what-we-do { } /* probably a bit verbose */
.wwd { } /* almost certainly too terse */
{% endhighlight %}

Another benefit to this technique is that you can spot patterns in the code more easily and also notice when there's a break in the consistency which means you might be more likely to fix it.

If you're developing with a team, there would obviously need to be some level of agreement to following this pattern of naming classes but if you combine it with a coding standards style guide, that wouldn't be too problematic. It's not a silver bullet to better CSS but anything that improves consistency and (human) readability sounds good to me.

If you've tried a similar technique or have a completely different approach, I'd be really interested to hear about it - just [tweet at me][4]...

[4]: http://www.twitter.com/guyroutledge
