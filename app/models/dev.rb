class Dev < ActiveRecord::Base
  attr_accessible :name, :username
  has_many :posts, :dependent => :destroy

  def self.find_or_create name
    dev = Dev.where(:name=>name).first
    dev = Dev.create(:name=>name) unless dev
    dev
  end
end
