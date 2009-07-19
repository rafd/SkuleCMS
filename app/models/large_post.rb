class LargePost < ActiveRecord::Base
  
    belongs_to      :club, :dependent => :destroy
    belongs_to      :user
  
  
  minLimit = 2.freeze
  maxLimit = 100.freeze

  validates_length_of :title, 
                      :within => minLimit..maxLimit,
                      :too_long => "Error: Sorry, your title can only have a maximum of %d characters.",
                      :too_short => "Error: Sorry, your title needs a minimum of %d characters to make a post."
  
  validates_length_of :content,
                      :minimum => 1,
                      :too_short => "Error: You need to have something to actually post!"
  
end
