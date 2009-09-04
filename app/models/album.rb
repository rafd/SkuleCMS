class Album < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user
  belongs_to :club
  has_many :images, :dependent => :destroy
  
  validates_presence_of     :name, :club_id, :user_id
  validates_numericality_of :club_id, :user_id
  validates_uniqueness_of   :name, :scope => [:club_id]
  
  attr_protected :id,
                :club_id,
                :user_id,
                :image_ids,
                :created_at,
                :updated_at,
                :locked
  
  after_save :create_directory
  
  def create_directory
    directory = "#{RAILS_ROOT}/public"+"/club_data/"+self.id.to_s
    if !File.exist?(directory)
      FileUtils.mkdir_p(directory)
    end
    directory = "#{RAILS_ROOT}/public/club_data/"+self.club.id.to_s+"/"+self.id.to_s
    if !File.exist?(directory)
      FileUtils.mkdir_p(directory)
    end
  end
end