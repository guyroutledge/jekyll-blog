require "stringex"
class Project < Thor

  desc "new", "create a new project"
  method_option :editor, :default => "vim"

  def new(*title)
    title = title.join(" ")
    date = Time.now.strftime('%Y-%m-%d')
    filename = "_posts/projects/#{date}-#{title.to_url}.md"

    if File.exist?(filename)
      abort("#{filename} already exists!")
    end

    puts "Creating new project: #{filename}"
    open(filename, 'w') do |post|
      post.puts "---"
      post.puts "layout: project"
      post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
      post.puts "date: #{date}"
      post.puts "link:"
      post.puts "categories: projects"
      post.puts "images:"
      post.puts "    - type: desktop"
      post.puts "      src:"
      post.puts "    - type: tablet"
      post.puts "      src:"
      post.puts "    - type: mobile"
      post.puts "      src:"
      post.puts "---"
    end

    system(options[:editor], filename)
  end

end
