class AddLiveToClubs < ActiveRecord::Migration
  def self.up
    add_column :clubs, :live, :boolean
  end

  def self.down
    remove_column :clubs, :live
  end
end
