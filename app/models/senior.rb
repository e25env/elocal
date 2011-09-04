class Senior < ActiveRecord::Base
  belongs_to :person
  belongs_to :address
  named_scope :seniors, :conditions=>{:underprivileged=>1}
  named_scope :handicaps, :conditions=>{:underprivileged=>2}
  named_scope :aids, :conditions=>{:underprivileged=>3}
  validate :no_duplicate

#  def nid=(val)
#    self[:nid]= val.gsub(/[\s-]/,'')
#  end
  def full_name
    if person
      "#{person.title}#{person.fname} #{person.lname}"
    else
      "id: #{id.to_s}"
    end
  end
  def no_duplicate
    errors.add(:nid, "ขออภัย มีบุคคลนี้ในระบบอยู่แล้ว") if
      Senior.exists?(:person_id=>person_id, :underprivileged=>underprivileged)
    return false
  end
end
