class DownloadFolder < ActiveRecord::Base
  belongs_to        :club, :dependent => :destroy
  has_many          :downloads
    
  validates_presence_of     :name, :club_id
  validates_numericality_of :club_id
  validates_uniqueness_of   :name, :scope => [:club_id]
end
