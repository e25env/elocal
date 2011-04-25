class Post < ActiveRecord::Base
  default_scope :order=>'begin_on DESC'
  named_scope :recent, :limit => 10
  def post_type_name
    POST_TYPE[post_type-1]
  end
end
