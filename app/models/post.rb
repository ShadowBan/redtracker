class Post < ActiveRecord::Base
  attr_accessible :description, :link, :title, :published_at, :dev_id
  attr_taggable :categories
  
  before_create :parse_additional_info

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
    self.fp_username = feed.search('.post .post-header a').first.text rescue nil
    self.fp_description = feed.search('.post .post-body .message-content').first.inner_html rescue nil
  end

  def get_post_description!
    agent = Mechanize.new
    post_id = self.link.scan(/[^\/]+\/?$/).first
    feed = agent.get self.link
    self.description = feed.search("#post#{post_id} .message-content").first.inner_html rescue nil
  end

  def self.get_tags context=nil
    ActiveRecord::Base.connection.execute("select distinct name from taggings join tags on tags.id = taggings.tag_id where taggable_type='Post'#{"AND context='#{context}'" if context};").collect{|t| t["name"]}
  end

  private

  def parse_additional_info
    puts "==============================================="
    puts "adding aditional information before create"
    puts "==============================================="
    self.dev = Dev.find_or_create(self.description)
    #self.description = self.description.gsub(/^(.*) said\: /i,"")
  end
end
