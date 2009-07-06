class ClubsAddLogoAndTagline < ActiveRecord::Migration
  def self.up
    add_column :clubs, :tagline, :string
    add_column :clubs, :logo, :string 

  end

  def self.down
    remove_column :clubs, :tagline
    remove_column :clubs, :logo
  end
end
