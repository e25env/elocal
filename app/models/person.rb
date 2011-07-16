class Person < ActiveRecord::Base
  belongs_to :address

  def full_name
    return fname.blank? ? "" : "#{title}#{fname} #{lname}"
  end
  def label
    t = "#{nid}|#{full_name}|#{id}"
    t += "|#{address.name}" if address
    t += "|#{doc}" if doc
    t += "|#{address.doc}" if (address && address.doc)
    t
  end
end
