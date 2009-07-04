class RemoveLockedFromAlbum < ActiveRecord::Migration
  def self.up
    remove_column :albums, :locked
    add_column :albums, :locked, :boolean
  end

  def self.down
    remove_column :albums, :locked
    add_column :albums, :locked, :string
  end
end
