class ClubsNameChanges < ActiveRecord::Migration
  def self.up
  	remove_column :clubs, :short_name
  	add_column :clubs, :official_name, :string
  end

  def self.down
  	add_column :clubs, :short_name, :string
  	remove_column :clubs, :official_name
  end
end
