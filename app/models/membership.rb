class Membership < ActiveRecord::Base
    belongs_to       :user
    belongs_to       :group
    
    validates_presence_of     :group_id, :user_id
    validates_uniqueness_of   :user_id, :scope => [:group_id],
                              :message => "is already in the group"
                              
    after_create    :add_to_member_list
    
    #This is for fixture loading. Don't use unless necessary.
    def self.rebuild_memberships
      @memberships = Membership.find(:all)
      @memberships.each do |member|
        member.add_to_member_list
      end
    end
    
    def add_to_member_list
      if self.group.is_member_list?
        return
      end
      @member_list = self.group.club.member_list
      if @member_list.users.find(:first, :conditions => {:name => self.user.name}).blank?
        @membership = Membership.new
        @membership.user = self.user
        @membership.group = @member_list
        @membership.save
      end
    end    
    
end
