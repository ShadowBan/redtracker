class Dev < ActiveRecord::Base
  attr_accessible :name, :username
  has_many :posts, :dependent => :destroy

  def self.find_or_create name, username=nil
    dev = Dev.where(:name=>name).first
    dev = Dev.create(:name=>name,:username=>username) unless dev
    dev
  end
end
