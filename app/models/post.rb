class Post < ActiveRecord::Base
  default_scope :order=>'begin_on DESC'
  named_scope :recent, :limit => 10
end
