class Club < ActiveRecord::Base
  acts_as_taggable
    
  has_many      :groups, :dependent => :destroy
  has_many      :events, :dependent => :destroy
  has_many      :updates, :dependent => :destroy
  has_many      :download_folders, :dependent => :destroy
  has_many      :admins, :dependent => :destroy
  has_many      :albums, :dependent => :destroy
  has_many			:pages, :dependent => :destroy

  validates_presence_of     :name, :description
  validates_uniqueness_of   :name
<<<<<<< HEAD:app/models/club.rb
  
  def search
  end
  
  def search=(query)
=======

  def members
    return Group.find(:first, :conditions => {:club_id => self, :parent_id => nil, :name => "Member List"}).memberships
>>>>>>> 04beceb21f745cba60f853c975b1ab834c128005:app/models/club.rb
  end
end
