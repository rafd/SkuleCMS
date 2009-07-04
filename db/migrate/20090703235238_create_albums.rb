class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.string :name
      t.string :desc
      t.string :tags
      t.string :locked
      t.string :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :albums
  end
end
