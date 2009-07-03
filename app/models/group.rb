class Group < ActiveRecord::Base
  belongs_to      :club
  has_many        :users,   :through => :memberships
  #better nested tree
end
