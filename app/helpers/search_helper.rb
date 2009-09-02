module SearchHelper
  def find_clubs_tagged_with(tag)
    clubs = []
    (Club.find_tagged_with(tag.name)).each do |club|
      clubs << Club.find(club.id, :include => :tags)
    end
    return clubs
  end
end