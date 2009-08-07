class ClubsAddWebName < ActiveRecord::Migration
  def self.up
  	add_column :clubs, :web_name, :string
  	remove_column :clubs, :icon
  end

  def self.down
  	remove_column :clubs, :web_name
  	add_column :clubs, :icon
  end
end
