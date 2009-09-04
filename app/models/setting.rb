class Setting < ActiveRecord::Base
  belongs_to      :club
  
  validates_presence_of     :option_name, :value, :club_id
  
  attr_accessible :option_name, :name, :value
end
