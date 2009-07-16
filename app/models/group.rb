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

end