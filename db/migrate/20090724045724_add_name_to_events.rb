class AddNameToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :name, :string
  end

  def self.down
    remove_column :events, :name
  end
end
