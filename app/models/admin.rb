class Admin < ActiveRecord::Base
  belongs_to      :club, :dependent => :destroy

end
