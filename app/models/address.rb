class Address < ActiveRecord::Base
  belongs_to :sub_district
  belongs_to :district
  belongs_to :province
end
