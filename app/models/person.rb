class Person < ActiveRecord::Base
  belongs_to :address

  def full_name
    return fname.blank? ? "" : "#{title}#{fname} #{lname}"
  end
end
