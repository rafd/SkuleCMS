class ChangesToPosts < ActiveRecord::Migration
  def self.up
    drop_table :updates
    add_column :large_posts, :club_id, :integer
    add_column :small_posts, :club_id, :integer
    add_column :large_posts, :user_id, :integer
    add_column :small_posts, :user_id, :integer
    add_column :small_posts, :origin, :string  
  end

  def self.down
    create_table :updates do |t|
      t.string :name
      t.timestamps
    end

    remove_column :large_posts, :club_id
    remove_column :small_posts, :club_id
    remove_column :large_posts, :user_id
    remove_column :small_posts, :user_id
    remove_column :small_posts, :class

  end
end
