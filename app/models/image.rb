class Image < ActiveRecord::Base
  belongs_to :album
  belongs_to :user
  
  validates_presence_of     :name, :album_id, :user_id, :url
  validates_numericality_of :user_id, :album_id
  
  def self.save(upload, properties)
    name =  upload['download'].original_filename
    album = Album.find(properties['album_id'])
    directory = "public/"+album.club.name+"/"+album.name
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['download'].read) }
    return name
  end
  
end
