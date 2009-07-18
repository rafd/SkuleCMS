class CreateLargePosts < ActiveRecord::Migration
  def self.up
    create_table :large_posts do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :large_posts
  end
end
