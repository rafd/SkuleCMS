class CreateDownloads < ActiveRecord::Migration
  def self.up
    create_table :downloads do |t|
      t.integer :downloadFolder_id
      t.string :name
      t.string :desc
      t.string :url
      t.string :tags

      t.timestamps
    end
  end

  def self.down
    drop_table :downloads
  end
end
