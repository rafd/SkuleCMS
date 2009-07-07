class RenameUpdateToUpdatesInAdmins < ActiveRecord::Migration
  def self.up
    rename_column :admins, :update, :updates
  end
  
  def self.down
    rename_column :admins, :updates, :update
  end
end
