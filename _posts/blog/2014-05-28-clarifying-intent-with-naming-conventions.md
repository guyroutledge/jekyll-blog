---
layout: post
title: "Clarifying intent with naming conventions"
date: 2014-05-28
tags: Workflow
categories: blog
---

Have you ever worked on a project and felt it would be easier to just
quickly knock out some new code rather than learn how the codebase has
been structured already? 

I often find that the way some developers structure (or not) their code
and name things tells very little about their intent or thought process.
Trawling a codebase then becomes a chore that I don’t want to do.

I’ve recently been experimenting with a new combined methodology that feels the
most successful yet.

## Naming conventions 

I have a thing for naming conventions and have written about things like
not [polluting the CSS
namespace](http://www.guyroutledge.co.uk/blog/dont-pollute-the-css-namespace)
and [something else](#) before. However, I’ve just started using the 
[BEM](http://www.bem.info) methodology and am really enjoying how it can
keep CSS class naming neat and tidy, meaningful and tell other
developers more about the codebase as a whole.

## Group related classes

I used to take an approach of using a prefix to group related classes
together.

For example, if building a product page (that had a completely different
design to other pages in a site) I’d take the word "product" and use it
as a prefix for most of my classnames:

* `product-title`
* `product-sub-title`
* `product-intro`
* `product-packshot`
* `product-related-products`

This is organised and easy to see how all the classes are related to
each other but there’s a risk of duplicating code or repeating yourself.
Chances are there are similarities between titles and intro copy on
other pages too. Repetetive output code could be reduced by using
a pre-processor like Sass or Less and using their `extend` directives
which group related properties together.

## Separate into modules

## Trade one convention for another

## Conclusion
