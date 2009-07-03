class Download < ActiveRecord::Base
  belongs_to      :downloadFolder

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
