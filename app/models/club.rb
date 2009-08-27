require "will_paginate"

class Club < ActiveRecord::Base
  acts_as_taggable
    
  has_many      :groups, :dependent => :destroy
  has_many      :events, :dependent => :destroy
  has_many      :download_folders, :dependent => :destroy
  has_many      :admins, :dependent => :destroy
  has_many      :albums, :dependent => :destroy
  has_many      :pages, :dependent => :destroy
  has_many      :small_posts, :dependent => :destroy
  has_many      :large_posts, :dependent => :destroy

  validates_uniqueness_of   :name, :case_sensitive => false
  validates_uniqueness_of   :official_name, :case_sensitive => false
  validates_uniqueness_of   :web_name, :case_sensitive => false
  validates_length_of       :name, :in => 1..20
  validates_length_of       :official_name, :in => 1..100
  validates_length_of       :contact, :maximum => 50
  validates_length_of       :address, :maximum => 250
  validates_length_of       :web_name, :in => 3..15
  validates_length_of       :tagline, :in => 5..100
  validates_length_of       :description, :in => 5..400
  validates_format_of       :web_name, :with => /^[A-Za-z\d_]+$/, :message => "name is invalid. Only letters, numbers, and underscores allowed."
  validates_format_of       :contact, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :allow_blank => true, :message => 'email is invalid.'
  
  attr_accessible :name, :description, :official_name, :tagline, :web_name, :contact, :address, :live
  
  attr_accessor :logo, :banner
  
  after_create :create_member_list, :create_directory, :create_default_content
  before_validation :lowercase_web_name
  before_save   :save_images
  
  def validate
    errors.add_to_base "Invalid logo image. Image must be less than 100 KB." unless valid_image_size?(logo, 100)
    errors.add_to_base "Invalid banner image. Image must be less than 800 KB." unless valid_image_size?(banner, 800)
    errors.add_to_base "Invalid logo image. Only upload png, jpg, gif, or bmp allowed." unless valid_image_type?(logo)
    errors.add_to_base "Invalid banner image. Only upload png, jpg, gif, or bmp allowed." unless valid_image_type?(banner)
  end
  
  def valid_image_size?(upload, max_size)
    if (upload.blank?)
      return true
    end
    max_size *= 1024
    return File.size(upload) <= max_size
  end
  
  def valid_image_type?(upload)
    if (upload.blank?)
      return true
    end
    name = upload.original_filename
    types = ['.png', '.jpg', '.jpeg', '.gif', '.bmp']
    types.each do |check|
      return true if name.ends_with?(check)
    end
    return false
  end
  
  def lowercase_web_name
    self.web_name = self.web_name.downcase
  end
  
  def save_images
    if(!self.logo.blank?)
      File.open(File.join("public/images/avatars", self.web_name), "wb") { |f| f.write(self.logo.read) }
    end
    if(!self.banner.blank?)
      File.open(File.join("public/images/banners", self.web_name), "wb") { |f| f.write(self.banner.read) }
    end
  end  
  
  def create_directory
    directory = "#{RAILS_ROOT}/public"+"/club_data/"+self.id.to_s
    if !File.exist?(directory)
      FileUtils.mkdir_p(directory)
    end
  end
  
  def create_member_list
    @group = Group.new
    @group.club_id = self.id
    @group.name = "Member List"
    @group.misc = "Full member list of the club"
    @group.save
  end
  
  def create_default_content
    @root_page = self.pages.new
    @root_page.save_with_validation(false)
    
    @page = self.pages.new
    @page.title = "About Us"
    @page.content = self.description
    @page.order = "1"
    @page.parent_id = @root_page.id
    @page.save
    
    @page = self.pages.new
    @page.title = "History"
    @page.content = Time.now.strftime('%b. %d, %Y') + " - We created our SkuleClubs site!"
    @page.order = "2"
    @page.parent_id = @root_page.id
    @page.save
    
    @page = self.pages.new
    @page.title = "Constitution"
    @page.content = ""
    @page.order = "3"
    @page.parent_id = @root_page.id
    @page.save
    
    @small = self.small_posts.new
    @small.content = "We just created a SkuleClubs site! Check it out!"
    #@small.origin = "default?"
    @small.save
  end
  
  def search
  end
  
  def search=(query)
  end
  
  def member_list
    @group = self.groups.find(:first, :conditions => {:parent_id => nil})
    if @group.blank?
      @group = Group.new
      @group.club_id = self.id
      @group.name = "Member List"
      @group.misc = "Full member list of the club"
      @group.save
    end
    return @group
  end
  
  def root_page
    @root_page = self.pages.find(:first, :conditions => {:parent_id => nil})
    if @root_page.blank?
      @root_page = self.pages.new
      @root_page.save_with_validation(false)
    end
    return @root_page
  end
  
  def members
    return self.member_list.users
  end
  
  def upcoming_events
    return self.events.find(:all, :order => "start", :conditions => ["finish>=?", Time.now.utc], :limit => 3)
  end
  
  def main_pages
    return self.root_page.children
  end
  
  def all_pages
    return self.pages.find(:all, :conditions => ["parent_id IS NOT ?", nil], :order => 'lft')
  end
  
  def feed_items
  	
    feed = feed_output(self.small_posts.find(:all, :limit => 5), self.large_posts.find(:all, :limit => 5) + self.events.find(:all, :limit => 5))
    #feed = feed[0..20]
    return feed
  end
 

  def feed_output(*feeds)
    feed_out = []
    feeds.each do |feed|
      feed_out = feed_out + feed
    end
    feed_out = feed_out.sort_by{|t| t.created_at}.reverse
    return feed_out

  end
 
end
