class Group < ActiveRecord::Base
  belongs_to      :club
  has_many        :memberships
  has_many        :users,   :through => :memberships
  #better nested tree

  attr_writer :new_page
  validates_presence_of     :name
  validates_uniqueness_of   :name, :scope => [:club_id]

  acts_as_nested_set  :parent_column => "bns_parent_id",
                      :left_column => "lft",
                      :right_column => "rgt",
                      :text_coloumn => "name"
                      
  after_save :move_to_parent, :create_page
  
  
  def new_page
    @new_page
  end
  
  def is_member_list?
    return self.name.eql?("Member List")
  end
  
  def move_to_parent
    if !self.name.eql?("Member List")
      if !self.parent_id.blank?
                puts self.parent_id
        self.move_to_child_of(self.club.groups.find(self.parent_id))
        puts self.parent_id
      else
        self.parent_id = self.club.member_list.id
        self.move_to_child_of(self.club.member_list)
      end
    end
  end
  
  def create_page
    if self.new_page != '0'
      @page = Page.new
      @page.title = self.name
      @page.club = self.club
      @page.save
    end
  end
  
end