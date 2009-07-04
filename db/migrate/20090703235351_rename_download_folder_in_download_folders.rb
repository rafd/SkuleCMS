class RenameDownloadFolderInDownloadFolders < ActiveRecord::Migration

  def self.up
    rename_column :downloads, :downloadFolder_id, :download_folder_id
  end
  
  def self.down
    rename_column :downloads, :download_folder_id, :downloadFolder_id
  end

end
