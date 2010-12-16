class Person < ActiveRecord::Base
  belongs_to :address

  def full_name
    "#{title}#{fname} #{lname}"
  end
end
