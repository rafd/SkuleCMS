class MakeClubDescriptionText < ActiveRecord::Migration
  def self.up
    remove_column :clubs, :description
    add_column :clubs, :description, :text
    remove_column :events, :description
    add_column :events, :description, :text
  end

  def self.down
    remove_column :clubs, :description
    add_column :clubs, :description, :string
    remove_column :events, :description
    add_column :events, :description, :string
  end
end
