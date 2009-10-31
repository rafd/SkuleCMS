class AddGcalToClubs < ActiveRecord::Migration
  def self.up
    add_column :clubs, :gcal, :string
  end

  def self.down
    remove_column :clubs, :gcal
  end
end
