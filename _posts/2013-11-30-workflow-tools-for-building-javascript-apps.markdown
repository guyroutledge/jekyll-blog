---
layout:     post
title:      "Workflow tools for building javascript apps"
date:       2013-11-30 10:20:28
categories: workflow
---

## Questions, questions

What Javascript framework should I use? Backbone, Ember, Angular, Meteor, Hoodie, one of the others that I've never heard of? What backend language should I use? Javascript, PHP, Ruby, Python, one of the others that I've never heard of? What package manager should I use, what build script should I use, do I need a boilerplate, Less or Sass, do I need dependency management, is there something that does all this for me or should I do it all from scratch?

So. Many. Questions.

But unfortunately, these are all questions that have been rolling around my head over the last few weeks. I'm starting a new project and want to ensure that I go down the right track from the start rather than just cracking open a text editor and riffing. On one hand you could argue that things can be cleaned up once they have started to take shape. On the other hand, if time can be saved early on by having a maintainable project structure and the right tools, that sounds like a good thing to me.

## On picking the right framework

I listed a few front-end frameworks above and I don't know anything about any of them - I've played around with Meteor but not enough to say I know anything about it. Between the others, there are no doubt strengths and weaknesses but I have a feeling the right decision is to just pick one and go with it. Based on recommendation and watching [a great screencast series][1] by [David Mosher][2], I've picked Angular.

 [1]: http://www.youtube.com/watch?v=8ILQOFAgaXE
 [2]: https://twitter.com/dmosher

## On choosing the right tools

I've been reading a lot of tutorials, watching a lot of screencasts and pouring over a lot of code in various github repos. A few tools keep rearing their heads:

*   Yeoman - for generating boilerplate
*   Grunt - for automating workflow
*   Bower - for something I've not quite worked out yet
*   Jasmine - for unit testing
*   Karma - for running tests

There have been lots of others too but these ones stick out. There's lots of potential for improving workflow and automating things by using these tools but they no doubt all come with some degree of leaning curve. I wonder if there are any boilerplates that I can just grab and run with...?

## On choosing a boilerplate

[Boilerplate code][3] is stuff that you drop into a codebase as a starting point rather than starting with a blank screen. Some people have their own that they've crafted over years and others use the community maintained versions - [HTML5 Boilerplate][4] is a very well-known one for building modern websites.

 [3]: http://en.wikipedia.org/wiki/Boilerplate_code
 [4]: http://html5boilerplate.com

I found a link to one for AngularJS referenced in this excellent article series [about AngularJS best practices][5] called [ng-boilerplate][6]. It uses a slightly different directory structure to what I've seen elsewhere in my research as it groups all the files (controllers, views, styles, specs, etc.) into the same folder for a particular section of the app. I could use this...

 [5]: http://blog.artlogic.com/2013/05/02/ive-been-doing-it-wrong-part-1-of-3/
 [6]: https://github.com/ngbp/ng-boilerplate

BUT.

It comes bundled with Bootstrap. And it uses Less rather than Sass. These are both fine in their own right but they're just not my cup of tea; I'd rather create my own styling and I rather do that in Sass.

I could use the ng-boilerplate and just customise it to my own liking - but this will take a lot of time and reduce the momentum of just getting started.

## On choosing a generator

I've recently started leaning Rails too and one of the things that I really like about it is the generators for creating migrations, models, controllers etc. It's a real time saver and it helps you to do things "the Rails way". There's a tool called Yeoman for doing a similar thing for front-end workflows and there's a generator for Angular, so I checked it out.

    $ mkdir angular-project && cd $_
    $ yo angular
    

This creates an Angular project (optionally with Bootstrap) with Bower, Karma for test running and a whole load of grunt tasks for serving a local dev environment, Live Reload, and all manner of other things. The [angular-generator][7] for Yeoman allows you to generate routes, controllers, views, and lots more.

 [7]: https://github.com/yeoman/generator-angular

I like this workflow. I like the fact it doesn't force you to use Bootstrap. I like the fact that it doesn't force you to use Less or Sass.

I don't like the directory structure and how/where the files are generated. And, it may seem a little picky, but I don't like the fact that it generates controllers with names like `MainCtrl` - I like to [name things in a more verbose and human readable way][8] and think that `MainController` is far more appropriate. This is a small detail but I know I'll get annoyed with having to change this all the time if I used the Yo generator. The risk of introducing human error in this case is also greatly increased.

 [8]: http://www.guyroutledge.co.uk/blog/what-should-I-name-my-function

## So what's the solution?

I've decided to re-invent the wheel. Wait, hear me out...

One thing became clear to me when looking into all these tools: there's a shit load for me to learn.

I could piggy back on others' knowledge and it would get me where I need to go faster - which is great - but I'd not (necessarily) understand what everything is doing and this could become a bigger issue further down the line. I like to learn by doing and by shortcutting the process, I'm maybe doing *more* but possibly learning *less*.

## Hang on a second

That's surely madness. I kept looking for a better solution...

The plan was to start doing thing from scratch but then I discovered [Lineman][9] which is a fairly un-opinionated about what you use and the code it generates. Lineman has an Angular starter template, based on Dave Mosher's screencast material. Lineman gives you just enough to get started but then keeps out of the way and this is perfect for my style. I've refactored the directory structure to my liking and am going to look into building some custom Grunt tasks to act as boilerplate generators for controllers, services etc.. I'm going to use the best bits from each of the frameworks, boilerplates and best-practices that I've found and create a workflow that works for me. Angular makes it easy to test your code, so I'm going to have the opportunity to learn about TDD and roll that in to the whole process too - I must confess I've never done any unit testing but that's for another blog post...

 [9]: https://github.com/testdouble/lineman

In this case, the benefit of learning new tools and processes *properly* and crafting a workflow that works for *me* outweighs the extra effort of picking something that mostly keeps out the way. I might have to tune it and tweak it to my liking but I think it's definitely worth the effort.
