class Page < ActiveRecord::Base
	belongs_to		:club
  
  acts_as_nested_set  :parent_column => "bns_parent_id",
                    :left_column => "lft",
                    :right_column => "rgt",
                    :text_coloumn => "title"
  
 
  validates_length_of     :title, :in => 3..50
  validates_uniqueness_of   :title, :case_sensitive => false, :scope => [:club_id]
  validates_numericality_of :order
  
  attr_protected :club_id, :created_at, :updated_at
  after_save :move_to_parent
  
  def move_to_parent
    if !self.title.blank?
      if !self.parent_id.blank?
        self.move_to_child_of(self.club.pages.find(self.parent_id))
      else
        self.parent_id = self.club.root_page.id
        self.move_to_child_of(self.club.root_page)
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
    Page.all.each do |page|
      page.order_by_weight
    end
  end
  
  def indented_title
    @spacing = ""
    (self.level-2).times { @spacing += "&nbsp;&nbsp;"}
    if (self.level >=2 )
      @spacing += "&nbsp;&nbsp;"
    end
    return @spacing+self.title
  end
  
end
