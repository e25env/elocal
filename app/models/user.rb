class User < GmaUser
  set_table_name :gma_users
  belongs_to :section
  belongs_to :subsection

  named_scope :finance, :conditions=>{:section_id=>2}, :order=>:fname

  def self.all_but_me
    find :all, :conditions=>['id!=? AND login!=?', session[:user_id], 'anonymous'], :order=>:fname
  end
  def self.finance_head
    find 5
  end
  def self.palat
    find 4
  end
  def self.mayor
    find 3
  end
  def full_name
    "#{title}#{fname} #{lname}"
  end
end
