class Student < ActiveRecord::Base
  def full_name
    "#{person.title} #{person.fname} #{person.lname}"
  end
end
