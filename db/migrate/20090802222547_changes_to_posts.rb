class ChangesToPosts < ActiveRecord::Migration
  def self.up
    add_column :large_posts, :club_id, :integer
    add_column :small_posts, :club_id, :integer
    add_column :large_posts, :user_id, :integer
    add_column :small_posts, :user_id, :integer
    add_column :small_posts, :origin, :string  
  end

  def self.down
    remove_column :large_posts, :club_id
    remove_column :small_posts, :club_id
    remove_column :large_posts, :user_id
    remove_column :small_posts, :user_id
    remove_column :small_posts, :class

  end
end
