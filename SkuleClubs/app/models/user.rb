class User < ActiveRecord::Base
    has_many        :groups,   :through => :memberships
end
