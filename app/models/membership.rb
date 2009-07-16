class Membership < ActiveRecord::Base
    belongs_to       :user
    belongs_to       :group
    
    validates_presence_of     :group_id, :user_id
end