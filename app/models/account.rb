class Account < ActiveRecord::Base
  default_scope :order=>"atype,code"
  has_many :account_trans, :order=>"reported_on DESC", :class_name=>"AccountTrans"
end
