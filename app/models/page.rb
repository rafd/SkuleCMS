class Page < ActiveRecord::Base
	belongs_to		:club
  
  validates_presence_of     :title
  validates_uniqueness_of   :title, :scope => [:club_id]
end
