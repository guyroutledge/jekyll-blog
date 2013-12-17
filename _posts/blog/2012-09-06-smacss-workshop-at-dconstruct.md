---
layout: post
title: "SMACSS workshop @dconstruct"
date: 2012-09-06
tags: Notes
categories: blog
---
Here are my notes from the SMACSS workshop @dconstruct conference.

For the real deal check out <http://www.smacss.com>.

## What?

SMACSS stands for Scalable and Modular Architecture for CSS. It's a theoretical best practice rather than a framework - you have to think to use it but that's a good thing

The core idea is to build websites using styles that are re-usable, portable and mean stylesheets are easier to maintain and debug over time.

## How?

Styles should have a single purpose

Style purpose can be broken down into categories:

*   Base
*   Layout
*   Module
*   State
*   Theme (optional)

### Layout

Layout is for layout. More specifically, layout is defined as the major components of a page - at the container level

*   Header
*   Footer
*   Sidebar
*   Main Content

When dealing with layout don't get bogged down in the specifics of modules and content; just think of the main building blocks of the design.

#### Naming Conventions

Naming conventions can be used to reference purpose and should clarify intent

*   layout prefix for layout classes `.layout-header` `.layout-sidebar`
*   modules use the module name - no prefix `.button` `.tab` `.nav`
*   sub-modules prefixed with parent module name `.button-small` `.nav-secondary`
*   apply module and sub-module to the same HTML element `<a class='button button-large'></a>`
*   namespacing in this way can help reduce confusion in code maintainence as each selector's purpose and place in the module heirarchy is clear

### Modules

Keep specificity low by not using IDs and over qualified selectors eg. `.button.search`

Keep CSS modules simple by not combining too many selectors

Be specific but not too verbose

{% highlight html %}
<!--
.module
.module-featured
.module-header
.module-footer
-->

<article class="module module-featured">
    <header class="module-header"></header>
    <!-- content -->
    <footer class="module-footer"></footer>
</article>
{% endhighlight %}

### State

State acts as a modifier for modules - similar to sub-modules although far more visual

{% highlight css %}
.tab {}
.is-tab-active {}
.is-tab-inactive {}
.is-hidden {}
.is-visible {}
{% endhighlight %}

The `.is-` prefix perhaps indicates a JS dependency for dynamically added or removed classes

{% highlight javascript %}
$('.button').on('click', function(){
    $(this).toggleClass('is-active');
});
{% endhighlight %}

This is preferrential over modifying behaviour with JS and adding inline styles

## Where do we start?

We identify patterns in the design and codify them with CSS.

*   Base sets global styles like typography and links
*   Layout sets dimensions (and sometimes background and color)
*   Modules are dimensionless and expand to fill layout
*   Modules override base and layout
*   States can force behaviour with !important

Be careful when declaring Base styles otherwise you might end up working hard to override styles

{% highlight html %}
<!-- Don't get too crazy with styling these -->
<table>
<button>
<input>
{% endhighlight %}

### Depth of Applicability

Avoid massive selectors like:

{% highlight css %}
#comments .comment .meta .comment-author { }
{% endhighlight %}

Also avoid using IDs because of this:

{% highlight css %}
#content a { color:#000; }
#sidebar a { color:#666; }
.callout a { color:#900; } /* will not work if in the #sidebar */
#sidebar .callout a { color:#900!important; } /* yuck */
{% endhighlight %}

[The single responsibility principal][1] by Harry Roberts

[1]: http://csswizardry.com/2012/04/the-single-responsibility-principle-applied-to-css/

> A chunk of code should do one thing and only one thing

Reduce the depth of applicability:

*   Use fewer selectors
*   Use child selectors to limit depth `.nav > li { }` is fine `.nav .nav-item` could be considered overkill
*   Forget about (layout) context and just worry about module context

Team code review for CSS is very important - following this kind of methodology only works if everyone's on-board. If this is the case, out of control, unmaintainable CSS can be curbed. If this isn't the case, you're screwed.

### Decoupling CSS and HTML

We don't want to have to worry about the structure of the markup - we want our styles to work regardless of content.

By using classes we can use any HTML element and have the same styling.

This means we write less and our code is DRY (Don't Repeat Yourself)

{% highlight html %}
<!-- in this case we need styles for 
    .box { }
    .box ul { }
    .box p { }
    .box div { } -->

<div class="box">
    <ul></ul>
</div>

<div class="box">
    <p></p>
</div>

<div class="box">
    <div></div>
</div>

<!-- in this case we ONLY need
    .box { }
    .box .box-body { } -->

<div class="box">
    <ul class="box-body"></ul>
</div>

<div class="box">
    <p class="box-body"></p>
</div>

<div class="box">
    <div class="box-body"></div>
</div>  
{% endhighlight %}

### State

State can be controlled by dynamically adding/removing classes with JS

State can be controlled via pseudo classes

{% highlight css %}
:hover { }
:visited { }
:focus { }
:valid { }
:invalid { }
:disabled { }
{% endhighlight %}

Multiple states on an element could be applied via attribute selectors

{% highlight css %}
.button[data-disabled] { }
.button[data-pressed] { }
.button[data-active] { }
{% endhighlight %}

Media queries also control state (or layout).

Don't define breakpoints based on known devices, set breakpoints based on broken content.

It can be helpful to use inline media queries rather than defining all of them at the bottom of the stylesheet. This preserves the link between modules and how they behave under different circumstances.

## Process

Modularize - find repeatable patterns but accept that class names may describe visual state and don't try to abstract every repeatable property.

Break modules into separate CSS files - or partials if using a pre-processor (but be sensible with how you split things up)

{% highlight css %}
/* Split modules into SCSS partials 
_base.scss
_layout.scss
_grid.scss
_buttons.scss
_slideshow.scss
_modal.scss
*/
{% endhighlight %}

Use pre-processors to make your life easier and write less; variables, nesting, mixins, extends.

BUT: always think about what the compiled CSS will be like.

When nesting (using pre-processors) don't go deeper than three levels - one or two is better. Think *Inception*.

Prototyping:

*   Build and test individual components.
*   Allow front-end dev to take place separately from back-end engineering
*   Perhaps use a templating engine to ensure each problem isn't re-solved multiple times by each team member
*   Create pattern libraries to act as a visual (and code) reference (eg. [pattern primer by Jeremy Keith][2])
*   By modularizing, it makes it easier for large teams to work on things without the fear of things breaking

[2]: https://github.com/adactio/Pattern-Primer

Performance:

*   Only pull in styles when you need them
*   Smaller rule sets (eg. single class selectors) make it easier on browsers
*   Overriding styles causes reflow and repaint and makes the page-load slower

## Examples

These don't necessarily use SMACSS but are similar in theory

*   [Twitter Bootstrap][3]
*   [https://github.com/stubbornella/oocss/wiki][4]

[3]: http://twitter.github.com/bootstrap/
[4]: OOCSS

## Abstract Modules

Abstract patterns such as the media object by Nicole Sullivan are modules. Another example is the Nav module by Harry Roberts. These allow repeated patterns to be coded once and re-used site wide. They don't necessarily fit in to the SMACSS naming convention but could be altered to do so.

### The Icon Module

When icon fonts aren't an option (due to multiple colors) use an icon sprite.

Give icons their own specific element to reside in to stop sprite bleed.

{% highlight html %}
<a class="button" href="#"><i class="icon icon-16 icon-inbox"></i> Inbox</a>
{% endhighlight %}

{% highlight css %}
.icon { 
    /* styles common to all icons */

    display:inline-block;
    width:16px;
    height:16px;
    margin:0 16px 0 0;
}
.icon-16 {
    /* the specific icon sprite map 
    16 referrs to 16x16px icons */

    background:url('/path/to/icons/icons-16.png');
}
.icon-inbox {
    /* the specific background position for the inbox icon */

    background-position:-32px 0;
}
{% endhighlight %}

## Slides

<http://snk.ms/sres>
