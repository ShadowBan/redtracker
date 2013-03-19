class Dev < ActiveRecord::Base
  attr_accessible :name, :username
  has_many :posts, :dependent => :destroy

  def self.find_or_create username
    return nil if username.blank?
    dev = Dev.where(:username=>username).first
    dev = Dev.create(:username=>username,:name=>username.gsub(/\..*/i,"")) unless dev
    dev
  end
end
