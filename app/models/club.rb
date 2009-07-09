class Club < ActiveRecord::Base
  has_many      :groups, :dependent => :destroy
  has_many      :events, :dependent => :destroy
  has_many      :updates, :dependent => :destroy
  has_many      :download_folders, :dependent => :destroy
  has_many      :admins, :dependent => :destroy
  has_many      :albums, :dependent => :destroy

  validates_presence_of     :name, :description
  validates_uniqueness_of   :name

end
