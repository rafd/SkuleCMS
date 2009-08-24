class AddOrderToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :order, :int
  end

  def self.down
    remove_column :groups, :order
  end
end
