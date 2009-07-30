class RemoveTagsFromAlbum < ActiveRecord::Migration
  def self.up
    remove_column :albums, :tags
  end

  def self.down
    add_column :albums, :tags, :string
  end
end
