class DownloadFolder < ActiveRecord::Base
  belongs_to        :club
  has_many          :downloads, :dependent => :destroy
    
  validates_presence_of     :name, :club_id
  validates_numericality_of :club_id
  validates_uniqueness_of   :name, :scope => [:club_id]
end
