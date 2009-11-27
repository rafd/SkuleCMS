class CreateExternalPosts < ActiveRecord::Migration
  def self.up
    create_table :external_posts do |t|
      t.string :title
      t.text :content
      t.integer :club_id

      t.timestamps
    end
  end

  def self.down
    drop_table :external_posts
  end
end
