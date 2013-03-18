class Dev < ActiveRecord::Base
  attr_accessible :name, :username
  has_many :posts, :dependent => :destroy

  def self.find_or_create description
    dev_username = description.match(/^(.*) said\: /i)[1] rescue nil
    return nil if dev_username.blank?
    dev = Dev.where(:username=>dev_username).first
    dev = Dev.create(:username=>dev_username,:name=>dev_username.gsub(/\..*/i,"")) unless dev
    dev
  end
end
