class Membership < ActiveRecord::Base
    belongs_to       :user
    belongs_to       :group
    
    validates_presence_of     :group_id, :user_id
    validates_uniqueness_of   :user_id, :scope => [:group_id],
                              :message => "is already in the group"
end
