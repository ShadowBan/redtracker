class Post < ActiveRecord::Base
  attr_accessible :description, :link, :title, :published_at

  scope :newest, order("published_at desc").limit(1)
end
