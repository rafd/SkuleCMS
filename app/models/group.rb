class Group < ActiveRecord::Base
  belongs_to      :club
  #better nested tree
end
