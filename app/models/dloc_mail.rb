class DlocMail < ActiveRecord::Base
  establish_connection(
    :adapter  => "mysql",
    :host     => "203.170.239.245",
    :username => "songrit_dloc",
    :password => "",
    :database => "dloc_elearning",
    :encoding => "utf8"
  )
  set_table_name "mails"
  named_scope :unsent, :conditions => ['sent = 0']
end
