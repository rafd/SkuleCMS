class SmallPost < ActiveRecord::Base
  
    belongs_to      :club
    belongs_to      :user

    minLimit = 2.freeze
    maxLimit = 200.freeze

  validates_length_of :content, 
                      :within => minLimit..maxLimit,
                      :too_long => "Error: Sorry, you can only have a maximum of %d characters. Would you like to try a twat instead?",
                      :too_short => "Error: Sorry, you need a minimum of %d characters to make a post."

  attr_accessible :content

end
