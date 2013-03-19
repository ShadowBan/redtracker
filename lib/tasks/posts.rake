namespace :posts do
  task :get_guildwars_dev_tracker => :environment do
    rss = Rss.new("https://forum-en.guildwars2.com/forum/info/devtracker.rss")
    newest_post = Post.newest.first
    rss.items.each do |i|
      if newest_post.nil? || newest_post.published_at < i.created_at 
        p = Post.new(:title=>i.title,:link=>i.link,:published_at=>i.created_at) 
        p.get_post_description!
        p.add_categories_from_link!
        p.get_first_post!
        p.save!
      end
    end
  end

  task :clean_data => :environment do
    pp = Post.all
    pp.each do |p|
      p.get_first_post!
      p.get_post_description!
      p.save!
    end
  end
end

