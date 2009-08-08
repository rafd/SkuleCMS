class RemoveLogoInClubs < ActiveRecord::Migration
  def self.up
    remove_column :clubs, :logo
  end

  def self.down
    add_column :clubs, :logo, :string
  end
end
