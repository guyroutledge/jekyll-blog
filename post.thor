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
