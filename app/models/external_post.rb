class ExternalPost < ActiveRecord::Base
  
  belongs_to      :club

  attr_protected :id,
                :club_id,
                :created_at,
                :updated_at

end
