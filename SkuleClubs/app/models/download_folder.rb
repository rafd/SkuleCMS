class DownloadFolder < ActiveRecord::Base
  belongs_to        :club
  has_many          :downloads
end
