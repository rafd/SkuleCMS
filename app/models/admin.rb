class Admin < ActiveRecord::Base
  belongs_to      :club
  acts_as_authentic do |c|
    c.validates_format_of_login_field_options = {:with => /^[A-Za-z\d_]+$/, :message => "name is invalid. Only letters, numbers, and underscores allowed."}
    c.validates_length_of_password_field_options = {:minimum => 6, :if => :require_password?}
  end

end
