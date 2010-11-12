class DistrictOld < ActiveRecord::Base
  establish_connection(
    :adapter  => "mysql",
    :host     => "127.0.0.1",
    :username => "songrit_dloc",
    :password => "",
    :database => "dloc_elearning",
    :encoding => "utf8"
  )
  set_table_name "amphoes"
end
