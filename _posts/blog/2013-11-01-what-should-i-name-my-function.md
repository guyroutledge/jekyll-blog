---
layout: post
title: "What should I name my function"
date: 2013-11-01
tags: Workflow
categories: blog
---
Yesterday, I saw a tweet from [@benhowdle][1] that got me thinking.

[1]: http://twitter.com/benhowdle

> Devs: trying to name a function, it basically turns "quotes" into "Quote", so it un-pluralises it and capitalises. function proper() ?
>
> Ben Howdle (@benhowdle)
> [October 31, 2013][2]

[2]: https://twitter.com/benhowdle/statuses/395859007362985985

I suggested, `capitalizeAndUnpluralize()` but Ben wasn't keen on the length of that as a function name. This is a totally legit response but it got me thinking about the age old question of readability...

If I saw a function named `proper()`, I'd have to dig in to find out what it did. If I come across a function named `capitaliseAndUnpluralise()` I'd have an idea of what I expect it to do: capitalise a word and un-pluralise it. I wouldn't really need to read the body of the function at all to know exactly what it did as the name conveys meaning. This is largely a good thing - I'm a lazy developer and the less code I have to read and the less I have to think to understand it, the better!

I guess an alternative could have been to have two functions - `capitalise()` and `unpluralise()`, both with nice short names and both communicating meaning within them. These could then be chained together to achieve the desired result - or used elsewhere on their own, which is a win for reusability.

Naming things is hard, and it's a constant battle when writing code. As I work almost exclusively on the front-end of things, I find that my code needs to be more geared towards being read by humans than machines. As such, I lean towards much longer names, as long as it makes the code more readable. However, in other cases such as writing a simple helper function for generating a random number I'd go with `rand(min, max)` rather than `generateRandomNumberBetween(min, max)`.

Horses for courses, I suppose.
