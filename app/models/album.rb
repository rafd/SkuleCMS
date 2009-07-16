class Album < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user
  belongs_to :club
  has_many :images, :dependent => :destroy
  
  validates_presence_of     :name, :club_id, :user_id
  validates_numericality_of :club_id, :user_id
  validates_uniqueness_of   :name, :scope => [:club_id]
end