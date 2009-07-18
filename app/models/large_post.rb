class LargePost < ActiveRecord::Base
  
    belongs_to      :club, :dependent => :destroy
    belongs_to      :user
  
end
