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

  def self.get_tags context
    ActiveRecord::Base.connection.execute("select distinct name from taggings join tags on tags.id = taggings.tag_id where context='#{context}' and taggable_type='Post';").collect{|t| t["name"]}
  end

  private

  def parse_additional_info
    puts "==============================================="
    puts "adding aditional information before create"
    puts "==============================================="
    self.dev = Dev.find_or_create(self.description)
    self.description.gsub!(/^(.*) said\: /i,"")
    #add_tags_from_link
  end
end
