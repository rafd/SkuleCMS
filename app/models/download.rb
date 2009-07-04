class Download < ActiveRecord::Base
  belongs_to      :download_folder

  validates_presence_of     :name, :download_folder_id
  validates_numericality_of :download_folder_id
  validates_uniqueness_of   :name

  def self.save(upload)
    if (upload.blank?)
      return nil
    end
    name =  upload['download'].original_filename
    directory = "public/data"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['download'].read) }
    return name
  end

end
