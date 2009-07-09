class Album < ActiveRecord::Base
  belongs_to :user
  belongs_to :club, :dependent => :destroy
  has_many :images
  
  validates_presence_of     :name, :club_id, :user_id
  validates_numericality_of :club_id, :user_id
  validates_uniqueness_of   :name, :scope => [:club_id]
end