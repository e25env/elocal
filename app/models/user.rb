class User < GmaUser
  set_table_name :gma_users

  def self.all_but_me
    find :all, :conditions=>['id!=? AND login!=?', session[:user_id], 'anonymous']
  end
  def full_name
    "#{title}#{fname} #{lname}"
  end
end
