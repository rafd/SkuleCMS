class RenameEndToFinishInEvent < ActiveRecord::Migration
  def self.up
    rename_column :events, :end, :finish
  end

  def self.down
    rename_column :events, :finish, :end  
  end
end
