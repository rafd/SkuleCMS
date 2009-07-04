class Image < ActiveRecord::Base
  belongs_to :album
  belongs_to :user
  
  def self.save(upload)
    name =  upload['download'].original_filename
    directory = "public/data"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['download'].read) }
    return name
  end
  
end
