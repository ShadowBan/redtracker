namespace :posts do
  task :get_guildwars_dev_tracker => :environment do
    rss = Rss.new("https://forum-en.guildwars2.com/forum/info/devtracker.rss")
    newest_post = Post.newest.first
    rss.items.each do |i|
      p = Post.new(:title=>i.title,:description=>i.description,:link=>i.link,:published_at=>i.created_at) if newest_post.nil? || newest_post.published_at < i.created_at 
      p.add_categories_from_link!
      p.save!
    end
  end

  task :add_categories => :environment do
    pp = Post.all
    pp.each do |p|
      if p.categories.empty? 
        p.dev = Dev.find_or_create(p.description)
        p.description.gsub!(/^(.*) said\: /i,"")
        p.add_categories_from_link!
        p.save!
      end
    end
  end
end

