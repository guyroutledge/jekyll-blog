---
layout: post
title: "Git branch naming&nbsp;conventions"
date: 2014-03-18
tags: Workflow
categories: blog
---

I like systems and conventions and consistnecy. Some might say I have
OCD, but really, I&rsquo;m lazy and like to standardise everything so
I dont&rsquo;t have to think too much. I&rsquo;ve developed a system
that I use for naming branches in version control that helps me organise
my code (and my thoughts).

Firstly, I&rsquo;ll look at why having a naming convention is a good
thing, then outline a few common approaches to branch naming and
then wrap up with my preferred method.

## Why use a naming convention?

I&rsquo;ve already allued to my main reason for having a system:
_consistency_. But a second major one is just being _organised_.

Keeping your separate bodies of work organised in branches, is not too
disimilar to organising the rest of your project into folders; grouping
related content or file types together.

	- index.html
	|- assets
	   |- css
	   |- img
	   |- js
	   |- scss
	|- includes
	|- documentation

I think it&rsquo;d be crazy to organise a large project with all files
in a single folder, so why do the same with your branches? 

## Branch types

In order to start organising our work, it&rsquo;s helpful to look at the
different types of additions or changes that might be done on a new branch.

* Updating a page
* Adding a new feature
* Adding a new library, plugin or framework
* Adding a section to an exisiting page
* Fixing something that&rsquo;s broken
* Upgrading a plugin or framework
* Removing or undoing any of the above
* Something else

With some idea of the different reasons a feature branch might be used,
we can start organising by the type of work or feature name.

## Naming convention options

There are a few different naming approaches that I&rsquo;ve seen in
various workplaces or on collaborative projects. Here&rsquo;s some of
the most common ones:

### Name or initial

To find your own work or know who was responsible for a feature,
I&rsquo;ve seen teams use a name or initial prefix as an identifier:

	gr-twitter-feed
	jd-homepage-carousel
	rm-backend

There is some degree of logic here, but does `rm-backend` mean
"remove backend" or is this a branch created by someone with initials
"R. M."? What happens when one person does the setup for a feature but
someone else finishes it off? 

This approach could quickly become unintuitive and meaningless
- although the sentiment of associating a team member with their work is
a good one, that knowledge can be gleaned from `git blame`

### Dash notation

Hyphen separated words make it easy to create human-readable labels for
branches:

	new-feature-twitter-feed
	twitter-feed-documenation
	refactor-twitter-feed-docs
	fix-twitter-feed

It&rsquo;s clear what each of these branches might be doing. However,
this method can lead to quite a bit of inconsistency: should it always
be "docs" or always be "documentation"; is it best to start with the
feature name or the type of change?

	# feature name first
	twitter-feed-new-feature
	twitter-feed-documentation
	twitter-feed-documentation-refactor
	twitter-feed-hotfix

	# type of change first
	new-feature-twitter-feed
	documentation-twitter-feed
	documentation-refactor-twitter-feed
	hotfix-twitter-feed

The consistency can be easier seen with the first, but across an entire
project, I&rsquo;d argue that the second is more organised as
you&rsquo;d be able to see a list of all the new features, or all the
documentation branches together.

### Bracket notation

Another common style that I&rsquo;ve seen is bracket notation. 

	feat(twitter feed)
	docs(twiter feed readme)
	refactor(docs)
	fix(twitter feed z-index bug in IE)

This clears up any confusion with whether the feature name or type of
change comes first because it&rsquo;s always the type of change with the
description or feature name in parenteses. There&rsquo;s also a bit more
room for being descriptive without lots of extra dashes - which is more
readable. 

Iv&rsquo;e also seen this notation used for commit messages
too which is helpful for bringing some sense to describing changes there
too.

## Slash notation

A third style of naming that I&rsquo;ve seen is slash notation - similar
to how you would write out the path to a folder on your computer:

	new-feature/twitter-feed
	docs/twitter-feed/readme
	refactor/twitter-feed/layout
	fix/twitter-feed/z-index

While the slashes don&rsquo;t make this any easier to read, they do have
one benefit when using git: git will actually create these as separate
folders in the `.git/refs/heads/` directory of your remote repository.

Throughout the lifetime of a project, using the above naming
convention, you would end up with a top-level set of folders for each
change type with sub-folders of each named feature:

	|- .git/refs/heads
	  |- new-feature
	    |- twitter-feed
	    |- homepage
	      |- promotion
	      |- carousel
          |- lastest-article
	  |- refactor
	    |- twitter-feed
	      |- layout
	    |- homepage
	      |- carousel
	      |- promotion
	  |- fix
	    |- twitter-feed
	      |- z-index
	      |- number-of-tweets

Organised, neat, tidy and consistent.

## My preferred technique

It might not come as a surprise that my preference is the last approach,
using slash separated terms to create folders of grouped change types
and features on the remote. I also like the added bonus of having all
this automatically split into folders on the remote which could then be
shuffled around, renamed and deleted all together, with a bit of command
line wizzardry.

With this approach, I tend to use a handful of change types as a prefix. 
The most common ones are:

* `new-feature`
* `new-section`
* `new-page`
* `update`
* `upgrade`
* `fix`
* `amend`
* `refactor`
* `remove`

If you&rsquo;ve got a different approach or a different set of terms,
I&rsquo;d love to hear about it, just shoot me a tweet
[@guyroutledge](http://www.twitter.com/guyroutledge).
