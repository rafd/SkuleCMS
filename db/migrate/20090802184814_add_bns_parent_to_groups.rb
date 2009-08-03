class AddBnsParentToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :bns_parent_id, :integer
  end

  def self.down
    remove_column :groups, :bns_parent_id
  end
end
