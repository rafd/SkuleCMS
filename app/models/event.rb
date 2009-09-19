class Event < ActiveRecord::Base

  belongs_to      :club
  belongs_to      :user
  
  validates_presence_of     :start, :finish, :club_id, :location, :name, :description
  validates_length_of       :name, :maximum => 40
  validates_length_of       :link, :maximum => 255
  validates_length_of       :description, :maximum => 200
  validates_length_of       :location, :maximum => 50
  validates_numericality_of :club_id
  
  attr_accessible :start, :finish, :location, :name, :description, :link
  
  def start_at
    return start
  end
  
  def url
    if self.link.blank?
      return
    end
    unless self.link.to_s =~ /https?:\/\/.*/
      return "http://" + self.link.to_s
    else
      return self.link.to_s
    end
  end 


  
  def end_at
    return finish
  end
  
  def validate
    errors.add_to_base "Ending time cannot be before start time" if !(check_time?(start, finish))
  end

  def check_time?(start, finish)
    return finish >= start
  end
end
