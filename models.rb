# Models

# ActiveRecord classes go here. These are object-model
# representations of your database tables. All classes defined
# here must inherit from ActiveRecord::Base

# e.g.
# class User < ActiveRecord::Base
# end

class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
end

class Post < ActiveRecord::Base
  belongs_to :user
end
