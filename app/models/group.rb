class Group < ActiveRecord::Base
  belongs_to      :club
  has_many        :memberships
  has_many        :users,   :through => :memberships
  #better nested tree

  validates_presence_of     :name
  validates_uniqueness_of   :name, :scope => [:club_id]

  acts_as_nested_set  :parent_column => "parent_id",
                      :left_column => "lft",
                      :right_column => "rgt",
                      :text_coloumn => "name"
                      
  after_save :move_to_parent
  
  def move_to_parent
    if !self.parent_id.blank?
      self.move_to_child_of(Group.find(self.parent_id))
    end
  end
  
  def is_member_list?
    return self.name.eql? "Member List"
  end
  
end