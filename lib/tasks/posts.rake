namespace :posts do
  task :get_guildwars_dev_tracker => :environment do
    Post.where("published_at >= #{Date.today - 180.days}").delete
    rss = Rss.new("https://forum-en.guildwars2.com/forum/info/devtracker.rss")
    newest_post = Post.newest.first
    rss.items.each do |i|
      if newest_post.nil? || newest_post.published_at < i.created_at 
        p = Post.new(:title=>i.title,:link=>i.link,:published_at=>i.created_at)
        puts p.link 
        p.get_post_description!
        p.add_categories_from_link!
        p.get_first_post!
        p.save!
      end
    end
  end

  task :clean_data => :environment do
    pp = Post.where("dev_id is null").all
    pp.each do |p|
      puts p.link
      p.get_post_description!
      p.save!
    end
  end
end

