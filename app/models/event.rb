class Event < ActiveRecord::Base
  has_event_calendar

  belongs_to      :club
  belongs_to      :user
  
  validates_presence_of     :start, :finish, :club_id, :user_id, :location, :name
  validates_numericality_of :club_id, :user_id
  
  def start_at
    return start
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
