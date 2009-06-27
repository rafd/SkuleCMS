class Club < ActiveRecord::Base
  has_many      :groups
  has_many      :events
  has_many      :updates
end
