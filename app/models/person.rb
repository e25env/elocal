class Person < ActiveRecord::Base
  belongs_to :address

  def full_name
    return fname.blank? ? "" : "#{title}#{fname} #{lname}"
  end
  # split element using space, use in ajax call for enter land
  def full_names
    return fname.blank? ? "" : "#{title} #{fname} #{lname}"
  end
end
