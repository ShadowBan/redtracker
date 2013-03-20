class Post < ActiveRecord::Base
  attr_accessible :description, :link, :title, :published_at, :dev_id
  attr_taggable :categories
  searchable_on :title,:description,:fp_description

  belongs_to :dev



  scope :newest, order("published_at desc").limit(1)

  def add_categories_from_link! link=nil
    link ||= self.link
    tags = link.split("/")[(4..-3)]
    self.categories = self.categories + tags
    self.categories << "spvp" if link.split("/")[(4..-3)] == ["pvp","pvp"]
  end

  def get_first_post!
    agent = Mechanize.new
    link = self.link.gsub(/[^\/]+\/?$/,"")
    feed = agent.get link
    self.fp_username = feed.search('.post .post-header a.member').first.text
    description = 
    self.fp_description = fix_links(feed.search('.post .post-body .message-content').first).inner_html
  end

  def get_post_description!
    agent = Mechanize.new
    post_id = self.link.scan(/[^\/]+\/?$/).first
    feed = agent.get self.link
    self.description = fix_links(feed.search("#post#{post_id} .message-content").first).inner_html
    dev_name = feed.search("#post#{post_id} .post-header a.member").first 
    self.dev = Dev.find_or_create(dev_name.text,dev_name["href"])
  end

  def self.get_tags context=nil
    ActiveRecord::Base.connection.execute("select distinct name from taggings join tags on tags.id = taggings.tag_id where taggable_type='Post'#{"AND context='#{context}'" if context};").collect{|t| t["name"]}
  end

  private
  def fix_links nokonode
    nokonode.css("@href,@src").each{|l| l.value="https://forum-en.guildwars2.com"+l.value unless l.value =~ /https?:\/\//i}
    nokonode
  end
end
