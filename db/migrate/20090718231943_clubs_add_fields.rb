class ClubsAddFields < ActiveRecord::Migration
  def self.up
    add_column :clubs, :short_name, :string
    add_column :clubs, :website, :string 
		add_column :clubs, :contact, :string
		add_column :clubs, :affiliated, :boolean
  end

  def self.down
    remove_column :clubs, :short_name
    remove_column :clubs, :website
    remove_column :clubs, :contact
    remove_column :clubs, :affiliated
  end
end
