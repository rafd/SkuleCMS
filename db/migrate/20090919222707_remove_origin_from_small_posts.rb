class RemoveOriginFromSmallPosts < ActiveRecord::Migration
  def self.up
    remove_column :small_posts, :origin
  end

  def self.down
    add_column :small_posts, :origin, :string
  end
end
