class CreateSmallPosts < ActiveRecord::Migration
  def self.up
    create_table :small_posts do |t|
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :small_posts
  end
end
