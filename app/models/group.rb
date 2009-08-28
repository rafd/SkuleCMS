class Group < ActiveRecord::Base
  belongs_to      :club
  has_many        :memberships
  has_many        :users,   :through => :memberships
  #better nested tree

  attr_writer :new_page
  validates_length_of       :name, :in => 3..50
  validates_length_of       :misc, :maximum => 400
  validates_uniqueness_of   :name, :case_sensitive => false, :scope => [:club_id]
  validates_numericality_of :order

  attr_protected :id, :club_id, :created_at, :updated_at, :memberships_ids, :users_ids

  acts_as_nested_set  :parent_column => "bns_parent_id",
                      :left_column => "lft",
                      :right_column => "rgt",
                      :text_coloumn => "name"
                      
  after_save :move_to_parent
  
  
  def new_page
    @new_page
  end
  
  def is_member_list?
    return self.name.eql?("Member List")
  end
  
  def move_to_parent
    if !self.name.eql?("Member List")
      if !self.parent_id.blank?
        self.move_to_child_of(self.club.groups.find(self.parent_id))
      else
        self.parent_id = self.club.member_list.id
        self.move_to_child_of(self.club.member_list)
      end
      self.parent.order_by_weight
    end
  end
  
  def order_by_weight
    @sorted = self.children.sort_by{ |i| i[:order] }
    1.upto(@sorted.length-1) do |n|
      @sorted[n].move_to_right_of(@sorted[n-1])
    end
  end
  
  #This is for fixture loading. Don't use unless necessary.
  def self.rebuild_tree
    renumber_all
    Group.all.each do |group|
      group.order_by_weight
    end
  end
  
  def indented_name
    @spacing = ""
    (self.level-2).times { @spacing += "&nbsp;&nbsp;"}
    if (self.level >=2 )
      @spacing += "&nbsp;&nbsp;"
    end
    return @spacing+self.name
  end
  
end