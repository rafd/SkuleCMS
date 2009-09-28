class Page < ActiveRecord::Base
	belongs_to		:club
  
  acts_as_nested_set  :parent_column => "bns_parent_id",
                    :left_column => "lft",
                    :right_column => "rgt",
                    :text_coloumn => "title"
  
 
  validates_length_of     :title, :in => 3..50
  validates_uniqueness_of   :title, :case_sensitive => false, :scope => [:club_id]
  validates_numericality_of :order
  
  attr_protected :id, :club_id, :created_at, :updated_at
  before_validation :check_parent_id
  after_save :move_to_parent
  
  def check_parent_id
    if self.parent_id.blank? && !self.title.blank?
      self.parent_id = self.club.root_page.id
      self.bns_parent_id = self.club.root_page.id
    end
  end
  
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
  
  def show_banner?
    return ( Setting.find(:first, :conditions => ['club_id = ? AND option_name = ? AND name = ? AND value = ?', self.club_id, 'Banner', 'pages', self.id.to_s]).blank? ? false : true )
  end

  def order_by_weight
    @sorted = self.children.sort_by{ |i| i[:order] }
    1.upto(@sorted.length-1) do |n|
      @sorted[n].move_to_right_of(@sorted[n-1])
    end
  end
  
  #This is for fixture loading. Don't use unless necessary.
  def self.rebuild_tree
    @pages = Page.find(:all, :conditions => ['bns_parent_id IS ?', nil])
    @pages.each do |page|
      page.recreate_node
    end
    @clubs = Club.all
    @clubs.each do |club|
      club.root_page
    end
    #rebuild!
    Page.find(:all, :conditions => ['bns_parent_id IS NOT ?', nil]).each do |page|
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
  
  def recreate_node(parent_node = nil)
    @childs = Page.find(:all, :conditions => ["parent_id = ?", self.id])
    @node = self.club.pages.new
    @node.parent_id = parent_node
    @node.bns_parent_id = parent_node
    @node.content = self.content
    @node.title = self.title
    @node.order = self.order
    @node.save_with_validation(false)
    @childs.each do |child|
      child.recreate_node(@node.id)
    end
    self.destroy
  end
end
