class CreateDownloadFolders < ActiveRecord::Migration
  def self.up
    create_table :download_folders do |t|
      t.integer :club_id
      t.string :name
      t.string :icon

      t.timestamps
    end
  end

  def self.down
    drop_table :download_folders
  end
end
