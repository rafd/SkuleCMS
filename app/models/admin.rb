class Admin < ActiveRecord::Base
  belongs_to      :club
  acts_as_authentic
end
