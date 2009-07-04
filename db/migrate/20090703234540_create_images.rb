class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :name
      t.string :url
      t.string :desc
      t.string :tags
      t.integer :album_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
