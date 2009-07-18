class Image < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :album
  belongs_to :user
  
  validates_presence_of     :name, :album_id, :user_id, :url
  validates_numericality_of :user_id, :album_id
  
  def self.save(upload, album)
    if (upload.blank?)
      return ""
    end
    name = upload.original_filename
    directory = "public/club_data/"+album.club.name+"/"+album.name
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload.read) }
    return name
  end
  
end
