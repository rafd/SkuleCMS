class AddClubIdToAlbum < ActiveRecord::Migration
  def self.up
    add_column :albums, :club_id, :integer
  end

  def self.down
    remove_column :albums, :club_id
  end
end
