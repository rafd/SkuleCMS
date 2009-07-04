class Album < ActiveRecord::Base
  belongs_to :user
  belongs_to :club
  has_many :images
end
