class Club < ActiveRecord::Base
  acts_as_taggable
    
  has_many      :groups, :dependent => :destroy
  has_many      :events, :dependent => :destroy
  has_many      :large_posts, :dependent => :destroy
  has_many      :small_posts, :dependent => :destroy
  has_many      :download_folders, :dependent => :destroy
  has_many      :admins, :dependent => :destroy
  has_many      :albums, :dependent => :destroy
  has_many			:pages, :dependent => :destroy

  validates_presence_of     :name, :description, :official_name
  validates_uniqueness_of   :name, :official_name
  
  after_create :create_member_list, :create_directory
  
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
    return self.events.find(:all, :order => "finish", :conditions => ["finish>=?", Time.now], :limit => 3)
  end
end
