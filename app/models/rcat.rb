class Rcat < ActiveRecord::Base
  has_many :rtypes, :order=>:id
end
