---
layout: post
title: "The developer feedback loop"
date: 2014-01-08
tags: Workflow
categories: blog
---

Workflow is really important to me, because I hate faffing around and
like to be as efficient as possible. Regardless of how complex your
build process is or how you run your tests or what text editor you use,
the developers feedback loop is something that everyone has.

	:w<enter> <cmd + tab> <cmd + r>

This is my feedback loop. I write some code, save it and want to preview
the changes in a browser. I write in Vim so to save, I type `:w<enter>`
- other text editors typically have a save shortcut like `<cmd + s>`.
  After saving, I want to see the results so I switch over to Chrome and
  refresh the page. This takes less than half a second so my feedback
  loop is pretty&nbsp;tight. 

If I had to reach for my mouse, move up to the top of the screen, click
`File > Save`, move the mouse to the task-bar, find the Chrome icon,
click it and then move the mouse back to the top of the screen, find the
refresh icon and click it, my feedback loop for previewing
a change could be a few seconds rather than a few tenths of a second.

<figure>
	<img src="http://imgs.xkcd.com/comics/is_it_worth_the_time.png" alt="Is it worth the time">
	<figcaption>source: <a href="http://xkcd.com/1205/">xkcd</a></figcaption>
</figure>

This whole idea of tuning process reminded me of this xkcd comic
which shows how long you could spend making a routine task more
efficient without wasting your time. Quite incredibly, according to this
chart, I could spend a whole day optimising the "save, switch, refresh"
feedback loop because it&rsquo;s almost certainly something that&rsquo;s
done more than 50 times a day.

## Live reload

If this is true, I should optimise my already tight feedback loop even
futher. I could do this by removing the refresh step entirely and this can
be accomplished with [LiveReload](http://livereload.com/) which watches
for changes in the file system and automatically injects them into
the browser.  I&rsquo;ve tried to use this in the past without much
luck, but recently found a nice way of integrating it with my workflow,
on this very blog...

## Grunt

[Grunt](http://www.gruntjs.com) is a Javascript task runner that allows
you to automate stuff like compiling Sass and concatenating and
minifying JS. I also use it to compress images and build this site
before deploying it. Grunt has a bunch of core plugins for things like
watching files and can be told to automatically reload the page when
your files change using LiveReload. This is accomplished by setting the
`livereload` option in your `Gruntfile.js` on a per file-type basis.

{% highlight javascript %}
module.exports = function(grunt) {
grunt.initConfig({
	watch: {
		css: {
			files: ['assets/css/main.min.css'],
			options: {
				livereload: true,
			}
		}
	}
});
grunt.loadNpmTasks('grunt-contrib-watch');
}
{% endhighlight %}

As long as you have the [LiveReload Chrome
extension](https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei)
you should be good to go and your can start reaping the benefits of time
saved by never having to refresh a page again.

The only downside I find when using Grunt is that it&rsquo;s a lot
slower to compile CSS than using Ruby and `sass watch` - the concept of
fine tuning workflow is the real takeaway here though.
