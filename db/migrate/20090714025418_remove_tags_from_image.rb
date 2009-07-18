class RemoveTagsFromImage < ActiveRecord::Migration
  def self.up
    remove_column :images, :tags
  end

  def self.down
    add_column :images, :tags, :string
  end
end
