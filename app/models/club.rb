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

  validates_presence_of     :name, :description, :official_name, :tagline, :web_name
  validates_uniqueness_of   :name, :official_name, :web_name
  validates_length_of       :name, :maximum => 20
  validates_length_of       :official_name, :maximum => 100
  validates_length_of       :web_name, :maximum => 20
  validates_length_of       :tagline, :in => 5..100
  validates_length_of       :description, :in => 5..400
  validates_format_of       :web_name, :with => /^[A-Za-z\d_]+$/, :message => "name is invalid. Only letters, numbers, and underscores allowed."
  
  after_create :create_member_list, :create_directory
  before_validation :lowercase_web_name
  
  def lowercase_web_name
    self.web_name = self.web_name.downcase
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
  
  def search
  end
  
  def search=(query)
  end
  
  def member_list
    return self.groups.find(:first, :conditions => {:parent_id => nil})
  end
  
  def members
    return self.member_list.users
  end
  
  def upcoming_events
    return self.events.find(:all, :order => "start", :conditions => ["finish>=?", Time.now.utc], :limit => 3)
  end
  
  def feed_items
  	return self.small_posts + self.large_posts + self.events
  end
end
