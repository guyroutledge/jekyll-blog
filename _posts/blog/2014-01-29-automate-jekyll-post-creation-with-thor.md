---
layout: post
title: "Automate Jekyll post creation with Thor"
date: 2014-01-29
tags:
    - Workflow
    - Ruby
categories: blog
---

If you&rsquo;re reading this and you ever visited my old site,
you&rsquo;ll notice that I&rsquo;ve done a redesign. You might not
notice that I&rsquo;ve moved from using WordPress to using
[Jekyll](http://jekyllrb.com/) - a static site generator written in
Ruby.

Instead of writing posts in a browser, I now write them in my favourite
text editor using markdown. All the meta data for a post (title,
category, published date etc.) is setup via a config block of [YAML
front-matter](http://jekyllrb.com/docs/frontmatter/) at the top of the
post. For my blog posts, it looks like this:

{% highlight yaml %}
---
layout: post
title: "Automate Jekyll post creation with Thor"
date: 2014-01-29
tags: Workflow
categories: blog
---
{% endhighlight %}

And for my projects posts, it looks like this:

{% highlight yaml %}
---
layout:     project
title:      "Kallo"
date:       2013-09-05 10:20:28
link:       http://www.kallo.com
categories: projects
images:
    - type: desktop
      src: kallo-desktop.jpg
    - type: tablet
      src: kallo-tablet.jpg
    - type: mobile
      src: kallo-mobile.jpg
---
{% endhighlight %}

It would be a pain in the ass to remember and type out all this stuff
when starting a new post so I&rsquo;ve automated the process with a Ruby
gem called [Thor](https://github.com/erikhuda/thor) and modified
a snippet I found by [Jonas
Forsberg](http://jonasforsberg.se/2012/12/28/create-jekyll-posts-from-the-command-line)
to do so.

> Thor is a simple and efficient tool for building self-documenting
> command line utilities

To create a new post I just crack open the command line, use the `thor
new` command and a new file is created in the correct folder with all
the front-matter filled in and automatically opened in my editor of
choice.

{% highlight bash %}
# create a new post in blog category with today's date
thor post:new "Automate Jekyll post creation with Thor"

# optionally pass in the date for creation
thor post:new "Automate Jekyll post creation with Thor" --date=2014-01-01

# create a projects post instead
thor post:new "The next Facebook" --category=projects
{% endhighlight %}

Guided by Jonas&rsquo; article, I installed the required gems by adding
them to my `Gemfile` and created a single `post.thor` script in the root
of my site. I then added the additional options I wanted with some
sensible defaults - I write more blog posts than post up projects, so
"blog" is the default category. 

This is the final script:

{% highlight ruby %}
require "stringex"
class Post < Thor

  desc "new", "create a new post"
  method_option :editor, :default => "vim"
  method_option :date
  method_option :category, :default => "blog"

  def new(*title)
    title = title.join(" ")
    date = options[:date] || Time.now.strftime('%Y-%m-%d')
    category = options[:category]
    layout = options[:category] == 'blog' ? 'post' : 'project'
    filename = "_posts/#{category}/#{date}-#{title.to_url}.md"

    if File.exist?(filename)
      abort("#{filename} already exists!")
    end

    puts "Creating new post: #{filename}"
    open(filename, 'w') do |post|
      post.puts "---"
      post.puts "layout: #{layout}"
      post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
      post.puts "date: #{date}"
      post.puts "tags:"
      post.puts "categories: #{category}"
      if category == 'projects'
        post.puts "images:"
        post.puts "    - type: desktop"
        post.puts "      src: -desktop.jpg"
        post.puts "    - type: tablet"
        post.puts "      src: -tablet.jpg"
        post.puts "    - type: mobile"
        post.puts "      src: -mobile.jpg"
      end
      post.puts "---"
    end

    system(options[:editor], filename)
  end

end
{% endhighlight %}

In a future post I&rsquo;ll be writing about more Jekyll automation
stuff and show how I&rsquo;ve created a single-command deployment
process for this blog.
