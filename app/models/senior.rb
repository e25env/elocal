class Senior < ActiveRecord::Base
  named_scope :seniors, :conditions=>{:underprivileged=>1}
  named_scope :handicaps, :conditions=>{:underprivileged=>2}
  named_scope :aids, :conditions=>{:underprivileged=>3}
  validate :no_duplicate

  def nid=(val)
    self[:nid]= val.gsub(/[\s-]/,'')
  end
  def full_name
    "#{title}#{fname} #{lname}"
  end

  def no_duplicate
    errors.add(:nid, "ขออภัย มีบุคคลนี้ในระบบอยู่แล้ว") if
      Senior.exists?(:nid=>nid, :underprivileged=>underprivileged)
  end
end
