class Download < ActiveRecord::Base
  belongs_to      :download_folder, :dependent => :destroy

  validates_presence_of     :name, :download_folder_id, :url
  validates_numericality_of :download_folder_id
  validates_uniqueness_of   :name

  def self.save(upload)
    if (upload.blank?)
      return ""
    end
    name =  upload.original_filename
    directory = "public/data"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload.read) }
    return name
  end

end
