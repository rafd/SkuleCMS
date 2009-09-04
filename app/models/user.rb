class User < ActiveRecord::Base
    has_many        :memberships
    has_many        :groups,   :through => :memberships
    acts_as_tagger
    
    validates_uniqueness_of   :name
    validates_length_of       :name, :in => 3..30
    
    attr_accessible :name
end
