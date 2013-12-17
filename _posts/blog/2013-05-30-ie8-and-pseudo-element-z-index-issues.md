---
layout: post
title: "IE8 and pseudo element z-index issues"
date: 2013-05-30
tags:
- Rants
- What I learned today
categories: blog
---
Today I learned that IE8 and positioned pseudo elements aren't always friends.

It's quite common for sites I work on these days to have bits and pieces of visual flair and I would always rather add these via pseudo elements to keep the markup clean. This is often done by `position:absolute` on the pseudo element relative to a parent container.

{% highlight css %}
.parent {
    position:relative;
    z-index:0;
}
.parent:after {
    content:"";

    position:absolute;
    z-index:10; /* should stack above .parent but won't in IE8 :0( */
}
{% endhighlight %}

However, IE8 seems to enforce inheritance of `z-index` from the parent element to any injected `:before` or `:after` elements, which can scupper your plans of lean markup.

I wasn't able to find an elegant workaround so ended up using an extra element as the information provided by the pseudo element was key to the UX. Another solution would have been to inject the extra element with JS but for the sake of ease, I decided to just add it to the template.

If you've got any suggestions for a more elegant solution, I'd love to hear about them
