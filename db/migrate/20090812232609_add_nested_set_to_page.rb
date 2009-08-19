class AddNestedSetToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :bns_parent_id, :int
    add_column :pages, :lft, :int
    add_column :pages, :rgt, :int
    add_column :pages, :parent_id, :int
    add_column :pages, :order, :int
  end

  def self.down
    remove_column :pages, :bns_parent_id
    remove_column :pages, :lft
    remove_column :pages, :rgt
    remove_column :pages, :order
    remove_column :pages, :parent_id

  end
end
