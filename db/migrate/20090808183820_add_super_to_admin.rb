class AddSuperToAdmin < ActiveRecord::Migration
  def self.up
    add_column :admins, :super_admin, :boolean
  end

  def self.down
    remove_column :admins, :super_admin
  end
end
